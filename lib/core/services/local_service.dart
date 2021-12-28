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

  Future setIsloggedIn(bool isLoggedIn) async {
    return await preferences!.setBool(IS_LOGGEDIN, isLoggedIn);
  }

  Future saveToken(token) async {
    return await preferences!.setString(TOKEN, token);
  }

  Future saveExpiryTime(time) async {
    return await preferences!.setString(EXPIREY_TIME, time);
  }

  Future saveDummyToken() async {
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjQwNjIwMzQ4LCJuYmYiOjE2NDA2MTY3NDgsImlhdCI6MTY0MDYxNjc0OCwianRpIjoiMWI3MWI2YzkyZTEyNDBlY2FjYmUwMWRiMzZmYzIxMmMiLCJqd3RfdmVyIjoyLCJzdWIiOiIxZDAyMmI1YS0yZTRhLTRmNWItYmQ4MS1hZDJhNzU5NzdlMjEiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2NDA2MTY3NDUsImF6cCI6IjEzMDUxMGJkLThhOTAtNDI3OC1iOTdhLWQ4MTFkZjQ0ZWYxMCIsImF1ZCI6WyIxMzA1MTBiZC04YTkwLTQyNzgtYjk3YS1kODExZGY0NGVmMTAiXSwic2NvcGUiOiJPU0ctRlJBTUUtQVBQLVBST0QifQ.kHLqJz05SqF_ZaXI1Taw10RJABdLgqm1tCXXZ2UhEoLysgh8QA94ONLZiqX6ZKMWhMJ-49qtRBpOZ6L_OSiKmTexOz9cXlGgUy-bTIpPJfOvE_th7QKOXy91GZnTAgcXypj4VEeHLgyd_W4X8eICFsosCHFau-e1q4cR0PrR819EcU_R6iajBSWRzsy4bJJT3C_GloplnID3rq0DFmfUyJTRCmrO43AqycTimQhgy-yrragIqg2uE5_XHdBJjrrFpibOLEdtXso7Lxw7g72jhRDQz4x5clJdmFjLq2x51NpOLgm5TCD_IfhV_Xc78cgTQu99KSQ2m4zle_s4-ZXLDg";
    return await preferences!.setString(TOKEN, token);
  }

  Future<String> getToken() async {
    return preferences!.getString(TOKEN)!;
  }

  Future saveUserId(String userId) async {
    return await preferences!.setString(USERID, userId);
  }

  Future<String?> getUserId() async {
    return preferences!.getString(USERID);
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
    Customer value;
    if (isVisionLink) {
      value = Customer(
          CustomerUID: "d7ac4554-05f9-e311-8d69-d067e5fd4637",
          Children: [],
          CustomerType: "Dealer",
          DisplayName: "(8050) Tata Hitachi Corporate Office",
          Name: "Tata Hitachi Corporate Office");
    } else {
      value = Customer(
          CustomerUID: "1857723c-ada1-11eb-8529-0242ac130003",
          Children: [],
          CustomerType: "Dealer",
          DisplayName: "(8050) Tata Hitachi Corporate Office",
          Name: "Tata Hitachi Corporate Office");
    }

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
    await preferences!.remove(CUSTOMER_INFO);
    await preferences!.remove(TOKEN_INFO);
    await preferences!.remove(ACCOUNT_INFO);
    await preferences!.remove(TOKEN);
    await preferences!.remove(EXPIREY_TIME);
    await preferences!.remove(USER_INFO);
    await preferences!.remove(IS_LOGGEDIN);
    await preferences!.clear();
  }
}
