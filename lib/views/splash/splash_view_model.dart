import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends InsiteViewModel {
  Logger? log;
  final NavigationService? _nagivationService = locator<NavigationService>();
  final LocalService? _localService = locator<LocalService>();
  final NativeService? _nativeService = locator<NativeService>();
  final LoginService? _loginService = locator<LoginService>();

  bool isProcessing = false;
  bool shouldLoadWebview = false;

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _nativeService!.platform.setMethodCallHandler(nativeMethodCallHandler);
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedIn();
    });
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "OauthCode":
        _localService!.setIsloggedIn(true);
        debugPrint(methodCall.arguments);
        getLoggedInUserDetails();
        return "This data from flutter.....";

      default:
        return "Nothing";
    }
  }

  void checkLoggedIn() async {
    try {
      bool? val = await _localService!.getIsloggedIn();
      Customer? account = await _localService!.getAccountInfo();
      Logger().d("checkLoggedIn " + val.toString());
     // val = true;
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
        //below three lines decides to show web view or not for login
        shouldLoadWebview = true;
        Future.delayed(Duration(seconds: 2), () {
          notifyListeners();
        });
        // _nagivationService!.replaceWith(loginPageRoute);
      } else {
        if (!isProcessing) {
          Logger().i("checking for permission");
          checkPermission(account);
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  checkPermission(Customer? account) async {
    try {
      if (isVisionLink) {
        await _localService!.saveAccountInfoData();
        await _localService!.saveDummyToken();
        List<Permission>? list = await _loginService!.getPermissions();
        if (list!.isNotEmpty) {
          _localService!.setHasPermission(true);
          if (account != null) {
            _nagivationService!.replaceWith(homeViewRoute);
          } else {
            _nagivationService!.replaceWith(customerSelectionViewRoute);
          }
        } else {
          //below three lines decides to show web view or not for login
          _localService!.setHasPermission(false);
          _localService!.clearAll();
          shouldLoadWebview = true;
          Future.delayed(Duration(seconds: 1), () {
            notifyListeners();
          });
          // _nagivationService.replaceWith(loginPageRoute);
          // // below lines for redirecting inside app
          // if (account != null) {
          //   _nagivationService.replaceWith(homeViewRoute);
          // } else {
          //   _nagivationService.replaceWith(customerSelectionViewRoute);
          // }
        }
      } else {
        //await _localService!.saveDummyToken();
        UserInfo? userInfo = await _loginService!.getLoggedInUserInfo();
        if (userInfo == null) {
          _localService!.setHasPermission(false);
          _localService!.clearAll();
          shouldLoadWebview = true;
          Future.delayed(Duration(seconds: 1), () {
            notifyListeners();
          });
        } else {
          _localService!.setHasPermission(true);
          if (account != null) {
            _nagivationService!.replaceWith(homeViewRoute);
          } else {
            _nagivationService!.replaceWith(customerSelectionViewRoute);
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void getLoggedInUserDetails() async {
    try {
      UserInfo? userInfo = await _loginService!.getLoggedInUserInfo();
      _localService!.saveUserInfo(userInfo);
      Logger().i("launching home get logged in user detail");
      _nagivationService!.replaceWith(homeViewRoute);
      isProcessing = false;
    } catch (e) {
      Logger().i("getLoggedInUserDetails");
      Logger().e(e);
    }
  }
}
