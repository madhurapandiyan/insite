import 'dart:convert';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService extends BaseService {
  final SharedPreferences? preferences;
  LocalService(this.preferences);
  static const String USER_INFO = "userInfo";
  static const String TOKEN_INFO = "tokenInfo";
  static const String ACCOUNT_INFO = "accountInfo";
  static const String CUSTOMER_INFO = "customerInfo";
  static const String TOKEN = "token";
  static const String EXPIREY_TIME = "expiry_token";
  static const String IS_LOGGEDIN = "isLoggedIn";
  static const String HAS_PERMISSION = "hasPermission";
  static const String USERID = "userId";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String CODE_VERIFIER = "code_verifier";
  static const String STAGGED_TOKEN = "token";

  Future setIsloggedIn(bool isLoggedIn) async {
    return await preferences!.setBool(IS_LOGGEDIN, isLoggedIn);
  }

  Future saveToken(token) async {
    return await preferences!.setString(TOKEN, token);
  }

  Future saveStaggedToken(token) async {
    return await preferences!.setString(STAGGED_TOKEN, token);
  }

  Future saveCodeVerfier(code_verifier) async {
    return await preferences!.setString(CODE_VERIFIER, code_verifier);
  }

  Future getCodeVerifier() async {
    return await preferences!.getString(CODE_VERIFIER);
  }

  Future saveRefreshToken(refreshToken) async {
    return await preferences!.setString(REFRESH_TOKEN, refreshToken);
  }

  Future saveExpiryTime(time) async {
    return await preferences!.setString(EXPIREY_TIME, time);
  }

  Future saveDummyToken() async {
    String token =
        " eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjQxNzkzOTQwLCJuYmYiOjE2NDE3OTAzNDAsImlhdCI6MTY0MTc5MDM0MCwianRpIjoiMDQ1NDJhMGUzYWJiNGI2MGFhMDI5YjkwZWJiOTgwZTIiLCJqd3RfdmVyIjoyLCJzdWIiOiIxZDAyMmI1YS0yZTRhLTRmNWItYmQ4MS1hZDJhNzU5NzdlMjEiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2NDE3OTAzNDAsImF6cCI6ImFmMmIwM2QwLTdiMjctNDFlYi04YTNhLTk1Yjg5ZDIwZjc4ZCIsImF1ZCI6WyJhZjJiMDNkMC03YjI3LTQxZWItOGEzYS05NWI4OWQyMGY3OGQiXSwic2NvcGUiOiJQcm9kLVZpc2lvbkxpbmtBZG1pbmlzdHJhdG9yIn0.uOa-m74hMenXbVOcnHuQcoIZgSMOJl16YXTTFrzMUCJLypXFog1j4Dfb7gTKFjOYGUDlFLUwF8o2ymUW67PB1xwUnkpTW-HHricrw5hvRysZxwBek7D_rGROv6443cYo7gYhlfWg1S_WkessEO2VRsrxTXD7-veQgqOFBj2r1yaDVioeSEUfwjey6ziluujth07nGgNTC_LkwYzbOUvj83_yX1V_4CIOXNZbRmbRZblEc_APzk1CVloDIHiXfLhtBSwX5JngaitavxuiDhgGApmZQc8KkftDaHP7blTZaBP8nYcw_Xg_UfZzcg1FxsoJzyIkmrHk4THFhci4-aTQ9Q";
    return await preferences!.setString(TOKEN, token);
  }

  Future<String> getToken() async {
    return preferences!.getString(TOKEN)!;
  }

  Future<String> getStaggedToken() async {
    return preferences!.getString(STAGGED_TOKEN)!;
  }

  Future saveUserId(String userId) async {
    return await preferences!.setString(USERID, userId);
  }

  Future<String?> getUserId() async {
    return preferences!.getString(USERID);
  }

  Future<String?> getRefreshToken() async {
    return preferences!.getString(REFRESH_TOKEN);
  }

  Future<String?> getExpiry() async {
    return preferences!.getString(EXPIREY_TIME);
  }

  Future<bool?> getIsloggedIn() async {
    return preferences!.getBool(IS_LOGGEDIN);
  }

  Future<bool> saveUserInfo(UserInfo? userLogin) async {
    return await preferences!.setString(USER_INFO, jsonEncode(userLogin));
  }

  Future<UserInfo?> getLoggedInUser() async {
    String? data = preferences!.getString(USER_INFO);
    if (data == null) {
      return null;
    }
    return UserInfo.fromJson(json.decode(data));
  }

  Future<bool> saveAccountInfo(Customer account) async {
    Logger().d("save account info " + account.CustomerUID!);
    return await preferences!.setString(ACCOUNT_INFO, jsonEncode(account));
  }

  Future saveAccountInfoData() async {
    Customer? value;
    // if (isVisionLink) {
    //   value = Customer(
    //       CustomerUID: "d7ac4554-05f9-e311-8d69-d067e5fd4637",
    //       Children: [],
    //       CustomerType: "Dealer",
    //       DisplayName: "(8050) Tata Hitachi Corporate Office",
    //       Name: "Tata Hitachi Corporate Office");
    // } else {
    //   value = Customer(
    //       CustomerUID: "1857723c-ada1-11eb-8529-0242ac130003",
    //       Children: [],
    //       CustomerType: "Dealer",
    //       DisplayName: "(8050) Tata Hitachi Corporate Office",
    //       Name: "Tata Hitachi Corporate Office");
    // }

    return await preferences!.setString(ACCOUNT_INFO, jsonEncode(value));
  }

  Future<Customer?> getAccountInfo() async {
    String? data = preferences!.getString(ACCOUNT_INFO);
    if (data == null) {
      return null;
    }
    return Customer.fromJson(json.decode(data));
  }

  Future<bool> saveTokenInfo(LoginResponse userInfo) async {
    Logger().d("save token info " + userInfo.id_token!);
    return await preferences!.setString(TOKEN_INFO, jsonEncode(userInfo));
  }

  Future<LoginResponse?> getTokenInfo() async {
    Logger().d("get token info ");
    String? data = preferences!.getString(TOKEN_INFO);
    if (data == null) {
      return null;
    }
    return LoginResponse.fromJson(json.decode(data));
  }

  Future<bool> saveCustomerInfo(Customer? customer) async {
    Logger().d("save customer info ");
    return await preferences!
        .setString(CUSTOMER_INFO, customer != null ? jsonEncode(customer) : "");
  }

  Future<Customer?> getCustomerInfo() async {
    String? data = preferences!.getString(CUSTOMER_INFO);
    if (data == null || data.isEmpty) {
      return null;
    }
    return Customer.fromJson(json.decode(data));
  }

  Future setHasPermission(bool hasPermission) async {
    return await preferences!.setBool(HAS_PERMISSION, hasPermission);
  }

  Future<bool?> getHasPermission() async {
    return preferences!.getBool(HAS_PERMISSION);
  }

  void clearAll() async {
    await preferences!.remove("codeVerifierInfo");
    await preferences!.remove(CUSTOMER_INFO);
    await preferences!.remove(TOKEN_INFO);
    await preferences!.remove(ACCOUNT_INFO);
    await preferences!.remove(TOKEN);
    await preferences!.remove(EXPIREY_TIME);
    await preferences!.remove(USER_INFO);
    await preferences!.remove(IS_LOGGEDIN);
    await preferences!.clear();
    await preferences!.remove(CODE_VERIFIER);
  }
}
