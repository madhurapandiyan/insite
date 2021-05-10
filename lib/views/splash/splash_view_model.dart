import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends InsiteViewModel {
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
        getLoggedInUserDetails();
        return "This data from flutter.....";
        break;
      default:
        return "Nothing";
        break;
    }
  }

  void checkLoggedIn() async {
    try {
      bool val = await _localService.getIsloggedIn();
      Customer account = await _localService.getAccountInfo();
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
        Logger().i("show webview");
        shouldLoadWebview = true;
        Future.delayed(Duration(seconds: 2), () {
          notifyListeners();
        });
      } else {
        if (!isProcessing) {
          if (account != null) {
            Logger().i("launching home splash view model");
            _nagivationService.replaceWith(dashboardViewRoute);
          } else {
            _nagivationService.replaceWith(customerSelectionViewRoute);
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void getLoggedInUserDetails() async {
    try {
      UserInfo userInfo = await _loginService.getLoggedInUserInfo();
      _localService.saveUserInfo(userInfo);
      Logger().i("launching home get logged in user detail");
      _nagivationService.replaceWith(dashboardViewRoute);
      isProcessing = false;
    } catch (e) {}
  }
}
