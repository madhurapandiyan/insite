import 'dart:convert';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class SubScriptionService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;
  String token;

  SubScriptionService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
      token = await _localService.getToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<DashboardResult> getResultsFromSubscriptionApi() async {
    print('vvvvvvvvvvvvvvvvvvvvvvvvv');
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }

      DashboardResult dashboardResult =
          await MyApi().getClientEight().getSubscriptionDashboardResults(
                Urls.subscriptionResults +
                    FilterUtils.constructQueryFromMap(queryMap),
              );
      if (dashboardResult == null) {
        Logger().d('no data found');
      }

      Logger().d('subscription result: $dashboardResult');
      return dashboardResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
