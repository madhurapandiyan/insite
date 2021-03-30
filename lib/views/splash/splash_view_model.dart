import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  Logger log;
  final _nagivationService = locator<NavigationService>();
  final _localService = locator<LocalService>();

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    await _localService.setIsloggedIn(true);
    bool val = await _localService.getIsloggedIn();
    Logger().d("checkLoggedIn " + val.toString());
    if (val) {}
  }
}
