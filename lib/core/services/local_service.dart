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
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJvYXV0aF9wYXJhbWV0ZXJzIjp7ImNsaWVudF9pZCI6Ijg5NDUyNDVkLTU5NzAtNDAxNS04NmQzLTQwNDk3NmI5YWY1ZiIsImNvZGVfY2hhbGxlbmdlIjoiQlQ3OFZQdUFTTDUxYTl4MHIwVVhjT0xCMUhKT3lJaWFZa2xVbFVOa2FQWSIsImNvZGVfY2hhbGxlbmdlX21ldGhvZCI6IlMyNTYiLCJub25jZSI6ImZmZXlzZHp6enFvZjlocG41eHVpdWpmdWllaGRwN2pmZWV3dWRkb3NtQUwiLCJyZWRpcmVjdF91cmkiOiJodHRwczovL2QxejVxYTh5YzJ1aG5jLmNsb3VkZnJvbnQubmV0L2F1dGgiLCJyZXNwb25zZV90eXBlIjoiY29kZSIsInNjb3BlIjoib3BlbmlkIE9TRy1JTi1QVUxTRS1BUFAtUFJPRCIsInN0YXRlIjoiZmZleXNkenp6cW9mOWhwbjV4dWl1amZ1aWVoZHA3amZlZXd1ZGRvc21BTCJ9LCJleHRyYV9wYXJhbWV0ZXJzIjp7Im5hdmlnYXRpb25SZWRpcmVjdFVyaSI6Ii8ifX0.sN5FfQc5qdmK8HROVqJ_SXkjU-oVMLGmttFvL80A_lXV35CsNIi4o60I7190AbADE9xSEZT49YhDYz1Z7ANNBSf_IlkrLBiLScVaq1vYxaT8-GEa6m4vlW-sss83fQ-vthHbH5bItlO1n-ISL-zXEH9-2iqJ9rNyxVyL2KfFHVNiSgxXxkWJ1Ln61Ze4gXhLFXLPiWA2Rfm_U7KPT_Xpe-bfYtPVLmWCwrauX3dQquDBIoAoAVgr5ZIl5pHdTC1ePPqBP7Hcn9oIQTFxc3aibbeJ3ld83ezZ4tzsT_CoQH9IlDqIaG3GKgiellhdBeaNzBvL21BgAqpI5rbYnFgq3g";
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
