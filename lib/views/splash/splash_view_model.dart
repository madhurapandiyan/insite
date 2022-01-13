import 'package:flutter/services.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
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
  late bool checkingFavour;

  SplashViewModel() {
    checkingFavour = isVisionLink;
    this.log = getLogger(this.runtimeType.toString());
    _nativeService!.nativeToFlutterplatform
        .setMethodCallHandler(nativeMethodCallHandler);
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedIn();
    });
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    Logger().d("method name ${methodCall.method}");
    switch (methodCall.method) {
      case "code_received":
        _localService!.setIsloggedIn(true);
        if (AppConfig.instance!.enalbeNativeLogin) {
          isProcessing = true;
        }
        getLoggedInUserDetails(methodCall.arguments);
        return "This data from flutter.....";
      case "logout_completed": //when login/logout happens on chrome app only.
        await _nativeService?.login();
        return "This data from flutter  after logout";
      default:
        return "Nothing";
    }
  }

  void checkLoggedIn() async {
    try {
      bool? val = await _localService!.getIsloggedIn();
      Customer? account = await _localService!.getAccountInfo();
      Logger().d("checkLoggedIn " + val.toString());
      //val = true;
      if (val == null || !val) {
        //use this user name and password
        // nitin_r@gmail.com
        // Welcome@1234
        // or below one
        //nithyamahalakshmi_p@trimble.com
        //OsgTe@m20!9
        if (AppConfig.instance!.enalbeNativeLogin) {
          await _nativeService!.login();
        } else {
          Logger().i("show webview");
          //below three lines decides to show web view or not for login
          shouldLoadWebview = true;
          Future.delayed(Duration(seconds: 2), () {
            notifyListeners();
          });
          // _nagivationService.replaceWith(loginPageRoute);
        }
        // Logger().i("login result %s" + result);
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
        //  await _localService!.saveAccountInfoData();
       // await _localService!.saveDummyToken();
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
          if (AppConfig.instance!.enalbeNativeLogin) {
            await _nativeService?.login();
          } else {
            shouldLoadWebview = true;
            Future.delayed(Duration(seconds: 1), () {
              notifyListeners();
            });
          }
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
          if (AppConfig.instance!.enalbeNativeLogin) {
            await _nativeService!.login();
          } else {
            shouldLoadWebview = true;
            Future.delayed(Duration(seconds: 1), () {
              notifyListeners();
            });
          }
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

  void getLoggedInUserDetails(String receivedData) async {
    Logger().d("getLoggedInUserDetails $receivedData");
    try {
      List<String> data = receivedData.split(",");
      LoginResponse? result =
          await _loginService!.getLoginDataV4(data[0], data[1], data[2]);
      if (result != null) {
        await _localService!.saveTokenInfo(result);
        await _loginService!.saveToken(
            result.access_token, result.expires_in.toString(), false);
      }
    } catch (e) {
      Logger().e("getLoggedInUserDetails", e);
    }
  }
}
