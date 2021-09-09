import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/models/token.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
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
      //     redirect_uri: "insite://mobile");
      UserInfo userInfo = await MyApi().getClientFive().getUserInfoV4(
          "application/x-www-form-urlencoded",
          "Bearer" + " " + await _localService.getToken(),
          AccessToken(access_token: await _localService.getToken()));
      return userInfo;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  getUser(token, shouldRemovePreviousRoutes) async {
    _localService.setIsloggedIn(true);
    _localService.saveToken(token);
    try {
      UserInfo userInfo = await getLoggedInUserInfo();
      Future.delayed(Duration(seconds: 1), () {
        if (userInfo != null) {
          _localService.saveUserInfo(userInfo);
          Logger().i("launching home from login service");
          if (shouldRemovePreviousRoutes) {
            Logger().i("true");
            _nagivationService.pushNamedAndRemoveUntil(
                customerSelectionViewRoute, predicate: (Route<dynamic> route) {
              return false;
            });
          } else {
            _nagivationService.replaceWith(customerSelectionViewRoute);
          }
        }
      });
    } catch (e) {
      Logger().e(e);
      Logger().i("exception launching home from login service");
      if (shouldRemovePreviousRoutes) {
        Logger().i("true");
        _nagivationService.pushNamedAndRemoveUntil(customerSelectionViewRoute,
            predicate: (Route<dynamic> route) => false);
      } else {
        _nagivationService.replaceWith(customerSelectionViewRoute);
      }
    }
  }

  saveExpiryTime(String expiryTime) async {}

  Future<List<Customer>> getCustomers() async {
    try {
      CustomersResponse response = await MyApi().getClient().accountHierarchy(
          Urls.accounthierarchy, true, "in-vlmasterdata-api-vlmd-customer");
      List<Customer> list = response.Customers;
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<Customer>> getSubCustomers(customerId) async {
    try {
      CustomersResponse response = await MyApi()
          .getClient()
          .accountHierarchyChildren(Urls.accounthierarchy, customerId,
              "in-vlmasterdata-api-vlmd-customer");
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
      UserInfo userInfo = await _localService.getLoggedInUser();
      Customer customer = await _localService.getAccountInfo();
      Logger().d("customer id ${customer.CustomerUID}");
      String uuid;
      await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        Logger().i("packageInfo ${packageInfo.packageName}");
        if (packageInfo.packageName == "com.example.insite.indiastack") {
          uuid = userInfo.sub != null ? userInfo.sub : "";
        } else {
          uuid = userInfo.uuid != null ? userInfo.uuid : "";
        }
      });
      Logger().d("uuid ${uuid}");
      PermissionResponse response = await MyApi().getClientFour().getPermission(
          10000,
          "Frame-Fleet-in",
          customer.CustomerUID,
          customer.CustomerUID,
          uuid);
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
      LoginResponse loginResponse = await MyApi().getClientOne().getToken(
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

  Future<LoginResponse> getLoginDataV4(
      code, code_challenge, code_verifier) async {
    try {
      LoginResponse loginResponse = await MyApi().getClientFive().getTokenV4(
          GetTokenData(
              code: code,
              code_challenge: code_challenge,
              code_verifier: code_verifier,
              tenantDomain: "Trimble.com",
              redirect_uri: "https://d1pavvpktln7z7.cloudfront.net/auth",
              grant_type: "authorization_code",
              client_id: "fe148324-cca6-4342-9a28-d5de23a95005"),
          "application/x-www-form-urlencoded");
      return loginResponse;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  saveToken(token, String expiryTime, shouldRemovePrevRoutes) async {
    Logger().i("saveToken from webview");
    await getUser(token, shouldRemovePrevRoutes);
    await saveExpiryTime(expiryTime);
  }
}
