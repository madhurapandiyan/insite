import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import '../locator.dart';
import 'local_service.dart';

class FaultService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  Customer? accountSelected;
  Customer? customerSelected;

  FaultService() {
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

  Future<FaultSummaryResponse?> getFaultSummaryList(startDate, endDate,
      pageSize, pageNumber, List<FilterData?>? appliedFilters, query) async {
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
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        FaultSummaryResponse faultSummaryResponse =
            FaultSummaryResponse.fromJson(data.data!['faultdata']);

        return faultSummaryResponse;
      } else {
        if (isVisionLink) {
          FaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.faultViewSummaryURLVL(
                        Urls.faultViewSummaryVL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNumber,
                                pageSize,
                                customerSelected?.CustomerUID,
                                "en-US",
                                appliedFilters!,
                                ScreenType.HEALTH),
                        filters,
                        accountSelected!.CustomerUID,
                      )
                  : await MyApi().getClient()!.faultViewSummaryURLVL(
                        Urls.faultViewSummaryVL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNumber,
                                pageSize,
                                null,
                                "en-US",
                                appliedFilters!,
                                ScreenType.HEALTH),
                        filters,
                        accountSelected!.CustomerUID,
                      );

          return fleetSummaryResponse;
        } else {
          FaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.faultViewSummaryURL(
                      Urls.faultViewSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected?.CustomerUID,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      filters,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix)
                  : await MyApi().getClient()!.faultViewSummaryURL(
                      Urls.faultViewSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      filters,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix);
          return fleetSummaryResponse;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetFaultSummaryResponse?> getAssetViewSummaryList(startDate, endDate,
      pageSize, pageNumber, List<FilterData?>? appliedFilters, query) async {
    dynamic filters = {
      "colFilters": ["asset.basic", "asset.details", "asset.dynamic"]
    };
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        AssetFaultSummaryResponse assetFaultSummaryResponse =
            AssetFaultSummaryResponse.fromJson(data.data!['assetData']);

        return assetFaultSummaryResponse;
      } else {
        if (isVisionLink) {
          AssetFaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetViewSummaryURLVL(
                        Urls.assetViewSummaryVL +
                            FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected?.CustomerUID,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH,
                            ),
                        filters,
                        accountSelected!.CustomerUID,
                      )
                  : await MyApi().getClient()!.assetViewSummaryURLVL(
                        Urls.assetViewSummaryVL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNumber,
                                pageSize,
                                null,
                                "en-US",
                                appliedFilters!,
                                ScreenType.HEALTH),
                        filters,
                        accountSelected!.CustomerUID,
                      );
          return fleetSummaryResponse;
        } else {
          AssetFaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetViewSummaryURL(
                      Urls.assetViewSummary +
                          FilterUtils.getFilterURL(
                            startDate,
                            endDate,
                            pageNumber,
                            pageSize,
                            customerSelected?.CustomerUID,
                            "en-US",
                            appliedFilters!,
                            ScreenType.HEALTH,
                          ),
                      filters,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix)
                  : await MyApi().getClient()!.assetViewSummaryURL(
                      Urls.assetViewSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      filters,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix);
          return fleetSummaryResponse;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<FaultSummaryResponse?> getAssetViewDetailSummaryList(
      startDate,
      endDate,
      pageSize,
      pageNumber,
      List<FilterData?>? appliedFilters,
      assetId,
      query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return FaultSummaryResponse.fromJson(data.data["faultsinglesData"]);
      } else {
        if (isVisionLink) {
          FaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClientThree()!.assetViewDetailSummaryURLVL(
                      Urls.assetHealthSummaryVL +
                          "/${assetId}/Faults" +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected?.CustomerUID,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      accountSelected!.CustomerUID)
                  : await MyApi().getClientThree()!.assetViewDetailSummaryURLVL(
                      Urls.assetHealthSummaryVL +
                          "/${assetId}/Faults" +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      accountSelected!.CustomerUID);
          return fleetSummaryResponse;
        } else {
          FaultSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetViewDetailSummaryURL(
                      Urls.assetHealthSummary +
                          "/${assetId}/Faults" +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected?.CustomerUID,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix)
                  : await MyApi().getClient()!.assetViewDetailSummaryURL(
                      Urls.assetHealthSummary +
                          "/${assetId}/Faults" +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix);

          return fleetSummaryResponse;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<HealthListResponse?> getHealthListData(String? assetUid, endDateTime,
      limit, page, startDateTime, String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return HealthListResponse.fromJson(data.data["singleAsset"]);
      }
      if (isVisionLink) {
        HealthListResponse healthListResponse =
            await MyApi().getClient()!.getHealthListDataVL(
                  assetUid,
                  endDateTime,
                  'en-US',
                  limit,
                  page,
                  startDateTime,
                  accountSelected!.CustomerUID,
                );
        return healthListResponse;
      } else {
        Map<String, String> queryMap = Map();
        if (assetUid != null) {
          queryMap["assetUid"] = assetUid;
        }
        if (startDateTime != null) {
          queryMap["startDateTime"] = startDateTime;
        }
        if (endDateTime != null) {
          queryMap["endDateTime"] = endDateTime;
        }
        if (page != null) {
          queryMap["page"] = page.toString();
        }
        if (limit != null) {
          queryMap["limit"] = limit.toString();
        }
        queryMap["langDesc"] = 'en-US';
        HealthListResponse healthListResponse = await MyApi()
            .getClient()!
            .getHealthListData(
                Urls.assetViewDetailSummaryV1 +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.faultPrefix);
        Logger().w(healthListResponse.toJson());
        return healthListResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<HealthListResponse?> getAssetViewLocationSummary(assetUid, startDate,
      endDate, page, limit, List<FilterData?>? appliedFilters, query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return HealthListResponse.fromJson(data.data["singleAsset"]);
      } else {
        if (isVisionLink) {
          HealthListResponse healthListResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetViewLocationSummaryURLVL(
                        Urls.assetViewDetailSummaryV1VL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                page,
                                limit,
                                customerSelected?.CustomerUID,
                                "en-US",
                                appliedFilters!,
                                ScreenType.HEALTH),
                        assetUid,
                        accountSelected!.CustomerUID,
                      )
                  : await MyApi().getClient()!.assetViewLocationSummaryURLVL(
                        Urls.assetViewDetailSummaryV1VL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                page,
                                limit,
                                null,
                                "en-US",
                                appliedFilters!,
                                ScreenType.HEALTH),
                        assetUid,
                        accountSelected!.CustomerUID,
                      );
          return healthListResponse;
        } else {
          HealthListResponse healthListResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetViewLocationSummaryURL(
                      Urls.assetViewDetailSummaryV1 +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              page,
                              limit,
                              customerSelected?.CustomerUID,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      assetUid,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix)
                  : await MyApi().getClient()!.assetViewLocationSummaryURL(
                      Urls.assetViewDetailSummaryV1 +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              page,
                              limit,
                              null,
                              "en-US",
                              appliedFilters!,
                              ScreenType.HEALTH),
                      assetUid,
                      accountSelected!.CustomerUID,
                      Urls.faultPrefix);
          return healthListResponse;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<SingleAssetFaultResponse?> getDashboardListData(
    assetUid,
    endDateTime,
    startDateTime,
  ) async {
    try {
      if (isVisionLink) {
        SingleAssetFaultResponse assetCountResponse = await MyApi()
            .getClient()!
            .getDashboardListDataVL(assetUid, endDateTime, startDateTime,
                accountSelected!.CustomerUID);
        return assetCountResponse;
      } else {
        Map<String, String> queryMap = Map();
        if (assetUid != null) {
          queryMap["assetUid"] = assetUid;
        }

        if (startDateTime != null) {
          queryMap["startDateTime"] = startDateTime;
        }
        if (endDateTime != null) {
          queryMap["endDateTime"] = endDateTime;
        }
        SingleAssetFaultResponse assetCountResponse = await MyApi()
            .getClient()!
            .getDashboardListData(
                Urls.faultSummary + FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.faultPrefix);
        return assetCountResponse;
      }
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }
}
