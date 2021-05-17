import 'dart:convert';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class AssetUtilService extends BaseService {
  var _localService = locator<LocalService>();
  Customer accountSelected;
  Customer customerSelected;
  AssetUtilService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<UtilizationData>> getUtilizationData() async {
    try {
      UtilizationSummaryResponse utilizationSummaryResponse = await MyApi()
          .getClient()
          .utilLizationList('64be6463-d8c1-11e7-80fc-065f15eda309', "04/19/21",
              "04/21/21", "d7ac4554-05f9-e311-8d69-d067e5fd4637");
      return utilizationSummaryResponse.utilization;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
