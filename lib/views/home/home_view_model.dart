import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  var _localService = locator<LocalService>();
  Logger log;
  ScreenType _currentScreenType;
  ScreenType get currentScreenType => _currentScreenType;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _currentScreenType = ScreenType.ACCOUNT;
    checkAccountSelected();
  }

  checkAccountSelected() async {
    try {
      Customer account = await _localService.getAccountInfo();
      Customer subAccount = await _localService.getCustomerInfo();
      if (account != null) {
        Logger().i("account selected already");
        _currentScreenType = ScreenType.HOME;
        notifyListeners();
      }
    } catch (e) {}
  }

  void updateState(newState) {
    _currentScreenType = newState;
    notifyListeners();
  }
}
