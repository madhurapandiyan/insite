import 'dart:convert';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/preference_data.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';


import 'package:logger/logger.dart';

class PreferenceService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService _graphqlSchemaService = locator<GraphqlSchemaService>();
  Customer? accountSelected;
  Customer? customerSelected;
  PreferenceService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }


  Future<Data?>? getPreferenceData() async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqUserPreferenceData(
            query: _graphqlSchemaService.getPreferenceData("global"),
            userId: (await _localService!.getLoggedInUser())!.sub);

        Data preferenceData = Data.fromJson(data.data);

        return preferenceData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  getPreferenceDataLocal() async {
    try {
      Data? result = await getPreferenceData();
      Logger().w(result?.toJson());
      var data = result!.getUserPreference!.preferenceJson;

      if (result.getUserPreference != null) {
        UserPreference userPreference =
            UserPreference.fromJson(jsonDecode(data!));
        _localService!.setUserPreferenceData(userPreference);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  createPreferenceData({String? userPrefernce, String? time}) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: _graphqlSchemaService.createUpdateUserPreference(
              time: time, userPreference: userPrefernce),
          payLoad: {
            "userPreferenceInput": {
              "preferenceKeyName": "global",
              "preferenceJson": userPrefernce,
              "targetUserUID": "88c00121-f3e4-4b1e-aef3-f63ff1029223",
              "schemaVersion": "1.0",
              "actionUTC": "2022-08-10T10:09:02.990Z"
            },
            "isCreate": false
          },
          userId: (await _localService?.getLoggedInUser())?.sub,
          customerId: accountSelected!.CustomerUID,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        Data preferenceData = Data.fromJson(data.data);

        return preferenceData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
