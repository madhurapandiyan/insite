import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import '../locator.dart';
import 'local_service.dart';

class LoginService extends BaseService {
  final _nagivationService = locator<NavigationService>();
  final _localService = locator<LocalService>();

  Future<UserInfo> getLoggedInUserInfo() async {
    try {
      //commented code will be used when we use intentify.trimble.com to get access token
      // var payLoad = UserPayLoad(
      //     env: "dev",
      //     code: code,
      //     client_key: "r9GxbyX4uNMjpB1yZge6fiWSGQ4a",
      //     grant_type: "authorization_code",
      //     tenantDomain: "trimble.com",
      //     client_secret: "4Xk8oEFLfxvnyiO821JpQMzHhf8a",
      //     redirect_uri: "eoltool://mobile");
      UserInfo userInfo = await MyApi().getClientOne().getUserInfo(
          "application/json", "Bearer" + " " + await _localService.getToken());
      return userInfo;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  void getUser(token, shouldRemovePreviousRoutes) async {
    _localService.setIsloggedIn(true);
    _localService.saveToken(token);
    try {
      UserInfo userInfo = await getLoggedInUserInfo();
      Future.delayed(Duration(seconds: 1), () {
        if (userInfo != null) {
          _localService.saveUserInfo(userInfo);
          Logger().i("launching home from login service");
          if (shouldRemovePreviousRoutes) {
            _nagivationService.pushNamedAndRemoveUntil(
                customerSelectionViewRoute,
                predicate: (Route<dynamic> route) => false);
          } else {
            _nagivationService.replaceWith(customerSelectionViewRoute);
          }
        }
      });
    } catch (e) {
      Logger().e(e);
      Logger().i("launching home from login service");
      if (shouldRemovePreviousRoutes) {
        _nagivationService.pushNamedAndRemoveUntil(customerSelectionViewRoute,
            predicate: (Route<dynamic> route) => false);
      } else {
        _nagivationService.replaceWith(customerSelectionViewRoute);
      }
    }
  }

  void saveExpiryTime(String expiryTime) {}

  Future<List<Customer>> getCustomers() async {
    try {
      CustomersResponse response =
          await MyApi().getClient().accountHierarchy(true);
      List<Customer> list = response.Customers;
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<Customer>> getSubCustomers(customerId) async {
    try {
      CustomersResponse response =
          await MyApi().getClient().accountHierarchyChildren(customerId);
      List<Customer> list = [];
      if (response.Customers.isNotEmpty) {
        list = response.Customers[0].Children;
      }
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<Permission>> getPermissions() async {
    try {
      Customer customer = await _localService.getAccountInfo();
      PermissionResponse response = await MyApi().getClient().getPermission(
          10000,
          "Prod-VLUnifiedFleet",
          customer.CustomerUID,
          customer.CustomerUID);
      List<Permission> list = [];
      if (response != null && response.permission_list.isNotEmpty) {
        list = response.permission_list;
      }
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<LoginResponse> getLoginData(
    username,
    password,
  ) async {
    try {
      LoginResponse loginResponse = await MyApi().getClientOne().getLoginData(
          username,
          password,
          'password',
          'kk3nOJhfWo1_GkxiMnvQ8iHtax8a',
          '_bd5Ohhjft9AbrTANMeILT4sMBoa',
          'openid',
          "application/x-www-form-urlencoded");
      return loginResponse;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  saveToken(token, String expiryTime) {
    Logger().i("saveToken from webview");
    getUser(token, false);
    saveExpiryTime(expiryTime);
  }
}
