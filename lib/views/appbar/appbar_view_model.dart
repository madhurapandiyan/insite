import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:stacked_services/stacked_services.dart';

class AppbarViewModel extends InsiteViewModel {
  var _navigationService = locator<NavigationService>();
  var _localService = locator<LocalService>();
  var _localStorageService = locator<LocalStorageService>();

  AppbarViewModel() {
    _localStorageService.setUp();
  }

  onHomePressed() {
    _navigationService.replaceWith(dashboardViewRoute);
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
