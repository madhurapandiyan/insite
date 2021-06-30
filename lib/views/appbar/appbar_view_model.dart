import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AppbarViewModel extends InsiteViewModel {
  var _navigationService = locator<NavigationService>();
  var _localService = locator<LocalService>();
  var _localStorageService = locator<LocalStorageService>();
  var _snackbarService = locator<SnackbarService>();

  Customer accountSelected;
  Customer customerSelected;

  AppbarViewModel() {
    setUp();
    _localStorageService.setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  onHomePressed() {
    if (accountSelected == null) {
      Logger().i("account not selected");
      _snackbarService.showSnackbar(
          message: "Account not selected", duration: Duration(seconds: 2));
    } else {
      _navigationService.replaceWith(dashboardViewRoute);
    }
  }

  onAccountPressed() {
    _navigationService.replaceWith(customerSelectionViewRoute);
  }

  void logout() {
    _localService.clearAll();
    _localStorageService.clearAll();
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(loginViewRoute);
    });
  }
}
