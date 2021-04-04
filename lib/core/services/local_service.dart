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

  Future setIsloggedIn(bool isLoggedIn) async {
    return await preferences.setBool("isLoggedIn", isLoggedIn);
  }

  Future saveToken(token) async {
    return await preferences.setString("token", token);
  }

  Future<String> getoken() async {
    return preferences.getString("token");
  }

  Future<bool> getIsloggedIn() async {
    return preferences.getBool("isLoggedIn");
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
}
