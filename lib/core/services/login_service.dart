import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/models/token.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import '../locator.dart';
import 'local_service.dart';

class LoginService extends BaseService {
  final _nagivationService = locator<NavigationService>();
  final _localService = locator<LocalService>();
  UserInfo? userInfo;

  Future<UserInfo?> getLoggedInUserInfo() async {
    try {
      String? token = await _localService.getToken();

      //commented code will be used when we use intentify.trimble.com to get access token
      // var payLoad = UserPayLoad(
      //     env: "dev",
      //     code: code,
      //     client_key: "r9GxbyX4uNMjpB1yZge6fiWSGQ4a",
      //     grant_type: "authorization_code",
      //     tenantDomain: "trimble.com",
      //     client_secret: "4Xk8oEFLfxvnyiO821JpQMzHhf8a",
      //     redirect_uri: "insite://mobile");
      if (isVisionLink) {
        UserInfo userInfo = await MyApi()
            .getClientFive()!
            .getUserInfoVl("application/json", "Bearer" + " " + token);
        return userInfo;
      } else {
        UserInfo userInfo = await MyApi().getClientFive()!.getUserInfoV4(
            "application/x-www-form-urlencoded",
            "Bearer" + " " + token,
            AccessToken(access_token: await _localService.getToken()));
        Logger().d(userInfo.toJson());
        await _localService.saveUserInfo(userInfo);
        return userInfo;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AuthenticatedUser?> getAuthenticateUserId() async {
    AuthenticatedUser? userAuthenticateStatus;
    AuthenticatePayload data =
        AuthenticatePayload(uuid: userInfo!.sub, email: userInfo!.email);
    Logger().d(data.toJson());
    if (isVisionLink) {
    } else {
      userAuthenticateStatus = await MyApi()
          .getClientNine()!
          .authenticateUser(Urls.authenticateUrl, data);
      await _localService
          .saveUserId(Utils.getUserId(userAuthenticateStatus.result!));
    }

    return userAuthenticateStatus;
  }

  getUser(token, shouldRemovePreviousRoutes) async {
    _localService.setIsloggedIn(true);
    _localService.saveToken(token);
    try {
      //await getAuthenticateUserId();
      userInfo = await getLoggedInUserInfo();

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
      if (userInfo != null) {
        _localService.saveUserInfo(userInfo);
        if (shouldRemovePreviousRoutes) {
          Logger().i("true");
          _nagivationService.pushNamedAndRemoveUntil(customerSelectionViewRoute,
              predicate: (Route<dynamic> route) => false);
        } else {
          _nagivationService.replaceWith(customerSelectionViewRoute);
        }
      }else{
        _nagivationService.replaceWith(customerSelectionViewRoute);
      }
    }
  }

  saveExpiryTime(String expiryTime) async {
    _localService.saveExpiryTime(expiryTime);
  }

  Future<List<Customer>?> getCustomers() async {
    if (isVisionLink) {
      try {
        CustomersResponse response =
            await MyApi().getClient()!.accountHierarchyVL(true);
        List<Customer>? list = response.Customers;
        return list;
      } catch (e) {
        Logger().e(e);
        return [];
      }
    } else {
      try {
        CustomersResponse response = await MyApi()
            .getClient()!
            .accountHierarchy(Urls.accounthierarchy, true,
                "in-vlmasterdata-api-vlmd-customer");
        List<Customer>? list = response.Customers;
        return list;
      } catch (e) {
        Logger().e(e);
        return [];
      }
    }
  }

  Future<List<Customer>?> getSubCustomers(customerId) async {
    try {
      if (isVisionLink) {
        CustomersResponse response =
            await MyApi().getClient()!.accountHierarchyChildrenVL(customerId);
        List<Customer>? list = [];
        if (response.Customers!.isNotEmpty) {
          list = response.Customers![0].Children;
        }
        return list;
      } else {
        CustomersResponse response = await MyApi()
            .getClient()!
            .accountHierarchyChildren(Urls.accounthierarchy, customerId,
                "in-vlmasterdata-api-vlmd-customer");
        List<Customer>? list = [];
        if (response.Customers!.isNotEmpty) {
          list = response.Customers![0].Children;
        }
        return list;
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<Permission>?> getPermissions() async {
    try {
      if (isVisionLink) {
        Customer? customer = await _localService.getAccountInfo();
        PermissionResponse response = await MyApi()
            .getClient()!
            .getPermissionVL(10000, "Prod-VLUnifiedFleet",
                customer!.CustomerUID, customer.CustomerUID);
        List<Permission>? list = [];
        if (response != null && response.permission_list!.isNotEmpty) {
          list = response.permission_list;
        }
        return list;
      } else {
        UserInfo? userInfo = await _localService.getLoggedInUser();
        Customer? customer = await _localService.getAccountInfo();
        PermissionResponse response = await MyApi()
            .getClientFour()!
            .getPermission(10000, "Frame-Fleet-in", customer!.CustomerUID,
                customer.CustomerUID!, userInfo!.uuid!);
        List<Permission>? list = [];
        if (response != null && response.permission_list!.isNotEmpty) {
          list = response.permission_list;
        }
        return list;
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<LoginResponse?> getLoginData(
    username,
    password,
  ) async {
    try {
      LoginResponse loginResponse = await MyApi().getClientOne()!.getToken(
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

  Future<LoginResponse?> getLoginDataV4(
      code, code_challenge, code_verifier) async {
    try {
      if (isVisionLink) {
        LoginResponse loginResponse = await MyApi().getClientFive()!.getTokenV4(
            GetTokenData(
                code: code,
                code_challenge: code_challenge,
                code_verifier: code_verifier,
                tenantDomain: "Trimble.com",
                redirect_uri: Urls.administratorBaseUrl,
                grant_type: "authorization_code",
                client_id: Urls.visionLinkClientId),
            "application/x-www-form-urlencoded");
        return loginResponse;
      } else {
        LoginResponse loginResponse = await MyApi().getClientFive()!.getTokenV4(
            GetTokenData(
                code: code,
                code_challenge: code_challenge,
                code_verifier: code_verifier,
                tenantDomain: "Trimble.com",
                redirect_uri: Urls.tataHitachiRedirectUri,
                grant_type: "authorization_code",
                client_id: Urls.indiaStackClientId),
            "application/x-www-form-urlencoded");
        return loginResponse;
      }
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  Future<LoginResponse?> getTokenWithoutLogin() async {
    try {
      LoginResponse loginResponse = await MyApi()
          .getClientFive()!
          .getTokenWithoutLogin(
              Urls.idTokenKey, "application/x-www-form-urlencoded");
      if (loginResponse != null) {
        onTokenReceivedWithoutLogin(loginResponse);
      }
      return loginResponse;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  void onTokenReceivedWithoutLogin(LoginResponse response) {
    Logger().i("onTokenReceivedWithoutLogin");
    _localService.setIsloggedIn(true);
    _localService.saveToken(response.access_token);
    saveExpiryTime(response.expires_in.toString());
  }

  saveToken(token, String expiryTime, shouldRemovePrevRoutes) async {
    Logger().i("saveToken from webview");
    await getUser(token, shouldRemovePrevRoutes);
    await saveExpiryTime(expiryTime);
  }
}
