import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/router_constants_india_stack.dart' as indiaStack;
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/login/india_stack_login_view.dart';
import 'package:insite/views/splash/india_stack_splash_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart' as service;

import '../../core/services/login_service.dart';

class AppbarViewModel extends InsiteViewModel {
  var _navigationService = locator<service.NavigationService>();
  var _localService = locator<LocalService>();
  var _localStorageService = locator<LocalStorageService>();
  var _nativeService = locator<NativeService>();
  LoginService? _loginService = locator<LoginService>();

  Customer? _accountSelected;
  Customer? get accountSelected => _accountSelected;

  Customer? _customerSelected;
  Customer? get customerSelected => _customerSelected;

  ScreenType? _screenType;
  ScreenType? get screenType => _screenType;

  AppbarViewModel(this._screenType) {
    Future.delayed(Duration(seconds: 3), () {
      setUp();
    });
    _localStorageService.setUp();
  }

  setUp() async {
    try {
      _accountSelected = await _localService.getAccountInfo();
      _customerSelected = await _localService.getCustomerInfo();
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  onHomePressed() {
    if (accountSelected == null) {
      Logger().i("account not selected");
      snackbarService!.showSnackbar(
          message: "Account not selected", duration: Duration(seconds: 2));
    } else {
      if (screenType != ScreenType.HOME) {
        _navigationService.replaceWith(homeViewRoute);
        _localStorageService.clearAll();
      }
    }
  }

  onAccountPressed() {
    _navigationService.replaceWith(customerSelectionViewRoute);
  }

  Future<void> logout() async {
    // _localService.removeTokenInfo();
    LoginResponse? response = await _localService.getTokenInfo();
    // await _loginService!.logout(response!.id_token!);

    // print(Urls.getV4LogoutUrl(response!.id_token, Urls.tataHitachiLogoutUrl))
    // Logger()
    //     .w(Urls.getV4LogoutUrl(response!.id_token, Urls.tataHitachiLogoutUrl));
    // return;
    _localService.clearAll();
    _localStorageService.clearAll();
    Future.delayed(Duration(seconds: 2), () async {
      // if normal api login is used below set of lines should be called on logout
      // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //   Logger().i("packageInfo ${packageInfo.packageName}");
      //   if (packageInfo.packageName == "com.trimble.insite.indiastack") {
      // _navigationService.replaceWith(indiaStack.indiaStackLoginViewRoute,
      //     arguments: LoginArguments(response: response));
      //   } else {
      //     _navigationService.replaceWith(splashViewRoute);
      //   }
      // });

      //if oauth style login used below line should be called on logout
      // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //   Logger().i("packageInfo ${packageInfo.packageName}");
      //   if (packageInfo.packageName == "com.trimble.insite.indiastack") {
      //     _navigationService.replaceWith(indiaStack.indiaStackLoginViewRoute,
      //         arguments: LoginArguments(response: response));
      //   } else {
      //     _navigationService.replaceWith(loginViewRoute);
      //   }
      // });
      if (AppConfig.instance!.enalbeNativeLogin) {
        await _nativeService.logout(response?.id_token);
      } else {
        if (isVisionLink) {
          _navigationService.replaceWith(indiaStack.indiaStackLoginViewRoute,
              arguments: LoginArguments(response: response));
        } else {
          _navigationService.clearTillFirstAndShow(
            indiaStack.indiaStackSplashViewRoute,
          );
        }
      }
    });
  }
}
