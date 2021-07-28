import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class LoginViewModel extends InsiteViewModel {
  Logger log;
  var formKey = GlobalKey<FormState>();
  var _loginService = locator<LoginService>();
  var usernameController;
  var passwordController;
  bool _loading = false;
  bool get loading => _loading;

  LoginViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  getLoginData(String username, String password) async {
    LoginResponse result = await _loginService.getLoginData(username, password);
    _loginService.saveToken(result.access_token, result.expires_in.toString());
    _loading = true;
    notifyListeners();
     print('data:$result');
  }

  submit() {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return null;
    }
    formKey.currentState.save();
  }
  
}
