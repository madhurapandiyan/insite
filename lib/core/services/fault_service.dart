import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:logger/logger.dart';

import '../locator.dart';
import 'local_service.dart';

class FaultService extends BaseService {
  var _localService = locator<LocalService>();
  Customer accountSelected;
  Customer customerSelected;
  FaultService() {
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

  Future<FaultSummaryResponse> getFaultSummaryList(
    startDate,
    endDate,
    pageSize,
    pageNumber,
    List<FilterData> appliedFilters,
  ) async {
    dynamic filters = {
      "colFilters": [
        "basic",
        "details",
        "dynamic",
        "asset.basic",
        "asset.details",
        "asset.dynamic"
      ]
    };
    try {
      FaultSummaryResponse fleetSummaryResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClientThree().faultViewSummaryURL(
                  Urls.faultViewSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          customerSelected.CustomerUID,
                          "en-US",
                          appliedFilters,
                          ScreenType.HEALTH),
                  filters,
                  accountSelected.CustomerUID)
              : await MyApi().getClientThree().faultViewSummaryURL(
                  Urls.faultViewSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          null,
                          "en-US",
                          appliedFilters,
                          ScreenType.HEALTH),
                  filters,
                  accountSelected.CustomerUID);
      return fleetSummaryResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetFaultSummaryResponse> getAssetViewSummaryList(
    startDate,
    endDate,
    pageSize,
    pageNumber,
    List<FilterData> appliedFilters,
  ) async {
    dynamic filters = {
      "colFilters": ["asset.basic", "asset.details", "asset.dynamic"]
    };
    try {
      AssetFaultSummaryResponse fleetSummaryResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClientThree().assetViewSummaryURL(
                  Urls.assetViewSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          customerSelected.CustomerUID,
                          "en-US",
                          appliedFilters,
                          ScreenType.HEALTH),
                  filters,
                  accountSelected.CustomerUID)
              : await MyApi().getClientThree().assetViewSummaryURL(
                  Urls.assetViewSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          null,
                          "en-US",
                          appliedFilters,
                          ScreenType.HEALTH),
                  filters,
                  accountSelected.CustomerUID);
      return fleetSummaryResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<HealthListResponse> getHealthListData(String assetUID,
       endDate,  limit,  page,  startDate) async {
    try {
      HealthListResponse healthListResponse =
          await MyApi().getClient().getHealthListData(
                assetUID,
                endDate,
                'en-US',
                limit,
                page,
                startDate,
                accountSelected.CustomerUID,
              );
      print('@@@:${healthListResponse.assetData.assetUid}');
      return healthListResponse;
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
