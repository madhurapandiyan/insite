import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class LoginViewModel extends InsiteViewModel {
  Logger? log;
  var formKey = GlobalKey<FormState>();
  LoginService? _loginService = locator<LoginService>();
  LocalService? _localService = locator<LocalService>();
  var usernameController;
  var passwordController;
  bool _loading = false;
  bool get loading => _loading;

  LoginViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  getLoginData(String? username, String? password) async {
    _loading = true;
    notifyListeners();
    LoginResponse? result = await _loginService!.getLoginData(username, password);
    if (result != null) {
      await _localService!.saveTokenInfo(result);
      await _loginService!.saveToken(
          result.access_token, result.expires_in.toString(), false);
    } else {
      snackbarService!.showSnackbar(
          message: "Something went wrong!", duration: Duration(seconds: 2));
    }
    Future.delayed(Duration(seconds: 1), () {
      _loading = false;
      notifyListeners();
    });
    print('data:$result');
  }

  getLoginDataV4() async {
    _loading = true;
    notifyListeners();
    LoginResponse? result =
        await _loginService!.getLoginDataV4("username", "password", "");
    if (result != null) {
      await _localService!.saveTokenInfo(result);
      await _loginService!.saveToken(
          result.access_token, result.expires_in.toString(), false);
    } else {
      snackbarService!.showSnackbar(
          message: "Something went wrong!", duration: Duration(seconds: 2));
    }
    Future.delayed(Duration(seconds: 1), () {
      _loading = false;
      notifyListeners();
    });
    print('data:$result');
  }

  submit() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return null;
    }
    formKey.currentState!.save();
  }
}
