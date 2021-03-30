import 'package:insite/core/locator.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  Logger log;
  final _nagivationService = locator<NavigationService>();
  final _localService = locator<LocalService>();
  final _nativeService = locator<NativeService>();

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedIn();
    });
  }

  void checkLoggedIn() async {
    bool val = await _localService.getIsloggedIn();
    Logger().d("checkLoggedIn " + val.toString());
    if (!val) {
      //use this user name and password
      // nitin_r@gmail.com
      // Welcome@1234
      String result = await _nativeService.openLogin();
      Logger().i("login result %s" + result);
    } else {
      _nagivationService.navigateTo(dashViewRoute);
    }
  }
}
