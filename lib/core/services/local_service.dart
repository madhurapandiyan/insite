import 'dart:convert';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService extends BaseService {
  final SharedPreferences preferences;
  LocalService(this.preferences);
  static const String USER_INFO = "userInfo";
  static const String ACCOUNT_INFO = "accountInfo";
  static const String CUSTOMER_INFO = "customerInfo";
  static const String TOKEN = "token";
  static const String EXPIREY_TIME = "expiry_token";
  static const String IS_LOGGEDIN = "isLoggedIn";
  static const String HAS_PERMISSION = "hasPermission";

  Future setIsloggedIn(bool isLoggedIn) async {
    return await preferences.setBool(IS_LOGGEDIN, isLoggedIn);
  }

  Future saveToken(token) async {
    return await preferences.setString(TOKEN, token);
  }

  Future saveExpiryTime(time) async {
    return await preferences.setString(EXPIREY_TIME, time);
  }

  Future<String> getToken() async {
    return preferences.getString(TOKEN);
  }

  Future<String> getExpiry() async {
    return preferences.getString(EXPIREY_TIME);
  }

  Future<bool> getIsloggedIn() async {
    return preferences.getBool(IS_LOGGEDIN);
  }

  Future<bool> saveUserInfo(UserInfo userLogin) async {
    return await preferences.setString(USER_INFO, jsonEncode(userLogin));
  }

  Future<UserInfo> getLoggedInUser() async {
    String data = preferences.getString(USER_INFO);
    if (data == null) {
      return null;
    }
    return UserInfo.fromJson(json.decode(data));
  }

  Future<bool> saveAccountInfo(Customer account) async {
    Logger().d("save account info " + account.CustomerUID);
    return await preferences.setString(ACCOUNT_INFO, jsonEncode(account));
  }

  Future<Customer> getAccountInfo() async {
    String data = preferences.getString(ACCOUNT_INFO);
    if (data == null) {
      return null;
    }
    return Customer.fromJson(json.decode(data));
  }

  Future<bool> saveCustomerInfo(Customer customer) async {
    return await preferences.setString(
        CUSTOMER_INFO, customer != null ? jsonEncode(customer) : "");
  }

  Future<Customer> getCustomerInfo() async {
    String data = preferences.getString(CUSTOMER_INFO);
    if (data == null || data.isEmpty) {
      return null;
    }
    return Customer.fromJson(json.decode(data));
  }

  Future setHasPermission(bool hasPermission) async {
    return await preferences.setBool(HAS_PERMISSION, hasPermission);
  }

  Future<bool> getHasPermission() async {
    return preferences.getBool(HAS_PERMISSION);
  }

  void clearAll() async {
    await preferences.remove(CUSTOMER_INFO);
    await preferences.remove(ACCOUNT_INFO);
    await preferences.remove(TOKEN);
    await preferences.remove(EXPIREY_TIME);
    await preferences.remove(USER_INFO);
    await preferences.remove(IS_LOGGEDIN);
    await preferences.clear();
  }
}
