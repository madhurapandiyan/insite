import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
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
  final _loginService = locator<LoginService>();

  bool isProcessing = false;
  bool shouldLoadWebview = false;

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _nativeService.platform.setMethodCallHandler(nativeMethodCallHandler);
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedIn();
    });
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "OauthCode":
        _localService.setIsloggedIn(true);
        debugPrint(methodCall.arguments);
        getLoggedInUserDetails(methodCall.arguments);
        return "This data from flutter.....";
        break;
      default:
        return "Nothing";
        break;
    }
  }

  void checkLoggedIn() async {
    bool val = await _localService.getIsloggedIn();
    Logger().d("checkLoggedIn " + val.toString());
    if (val == null || !val) {
      //use this user name and password
      // nitin_r@gmail.com
      // Welcome@1234
      // or below one
      //nithyamahalakshmi_p@trimble.com
      //OsgTe@m20!9
      // String result = await _nativeService.openLogin();
      // Logger().i("login result %s" + result);
      shouldLoadWebview = true;
      notifyListeners();
    } else {
      if (!isProcessing) {
        _nagivationService.navigateTo(homeViewRoute);
      }
    }
  }

  void getLoggedInUserDetails(code) async {
    UserInfo userInfo = await _loginService.getLoggedInUserInfo(code);
    _localService.saveUserInfo(userInfo);
    _nagivationService.replaceWith(homeViewRoute);
    isProcessing = false;
  }
}
