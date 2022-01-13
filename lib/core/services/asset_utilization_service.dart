import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class AssetUtilizationService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();

  AssetUtilizationService() {
    setUp();
  }

  setUp() async {
    try {
      //  _localService!.saveAccountInfoData();
      accountSelected = await _localService!.getAccountInfo();
      // want to change local service customerSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getAccountInfo();
      Logger().d("account selected " + accountSelected!.CustomerUID!);
      Logger().d("customer selected " + customerSelected!.CustomerUID!);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<AssetResult>?> getUtilizationData(
    String? assetUID,
    String? startDate,
    String? endDate,
  ) async {
    try {
      Map<String, String> queryMap = Map();
      if (assetUID != null) {
        queryMap["assetUid"] = assetUID.toString();
      }
      if (startDate != null) {
        queryMap["startDate"] = startDate;
      }
      if (endDate != null) {
        queryMap["endDate"] = endDate;
      }
      queryMap["sort"] = "-LastReportedUtilizationTime";
      queryMap["includeNonReportedDays"] = true.toString();
      queryMap["includeOutsideLastReportedDay"] = true.toString();
      // if (customerSelected != null) {
      //   queryMap["customerUID"] = customerSelected.CustomerUID;
      // }
      if (isVisionLink) {
        UtilizationSummaryResponse utilizationSummaryResponse =
            await MyApi().getClient()!.utilLizationListVL(
                  Urls.utlizationDetailsVL +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                );
        return utilizationSummaryResponse.utilization;
      } else {
        UtilizationSummaryResponse utilizationSummaryResponse = await MyApi()
            .getClient()!
            .utilLizationList(
                Urls.utilizationDetails +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.vutilizationPrefix);
        return utilizationSummaryResponse.utilization;
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<AssetUtilization?> getAssetUtilGraphDate(
      String? assetUID, String date) async {
    Logger().i("getAssetUtilGraphDate");
    try {
      Map<String, String> queryMap = Map();
      if (assetUID != null) {
        queryMap["assetUid"] = assetUID.toString();
      }
      if (date.isNotEmpty && date.isNotEmpty) {
        queryMap["date"] = date;
      }
      if (isVisionLink) {
        AssetUtilization result = await MyApi()
            .getClient()!
            .assetUtilGraphDataVL(
                Urls.utlizationDetailsSummaryVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return result;
      } else {
        AssetUtilization result = await MyApi().getClient()!.assetUtilGraphData(
            Urls.utilizationSummaryV1 +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected!.CustomerUID,
            Urls.vfleetPrefix);
        return result;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<Utilization?> getUtilizationResult(
      String? startDate,
      String? endDate,
      String sort,
      int pageNo,
      int pageCount,
      List<FilterData?>? appliedFilters,
      query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            query,
            accountSelected?.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);

        Utilization assetCountFromGraphql =
            Utilization.fromJson(data.data!['getfleetUtilization']);

        return assetCountFromGraphql;
      } else {
        if (isVisionLink) {
          if (startDate != null &&
              startDate.isNotEmpty &&
              endDate != null &&
              endDate.isNotEmpty) {
            Utilization response =
                accountSelected != null && customerSelected != null
                    ? await MyApi().getClient()!.utilizationVL(
                          Urls.utlizationSummaryVL +
                              FilterUtils.getFilterURL(
                                  startDate,
                                  endDate,
                                  pageNo,
                                  pageCount,
                                  customerSelected!.CustomerUID,
                                  sort,
                                  appliedFilters!,
                                  ScreenType.UTILIZATION),
                          accountSelected!.CustomerUID,
                        )
                    : await MyApi().getClient()!.utilizationVL(
                          Urls.utlizationSummaryVL +
                              FilterUtils.getFilterURL(
                                  startDate,
                                  endDate,
                                  pageNo,
                                  pageCount,
                                  null,
                                  sort,
                                  appliedFilters!,
                                  ScreenType.UTILIZATION),
                          accountSelected!.CustomerUID,
                        );
            return response;
          }
        } else {
          var customer = await _localService!.getCustomerInfo();
          if (startDate != null &&
              startDate.isNotEmpty &&
              endDate != null &&
              endDate.isNotEmpty) {
            Utilization response =
                accountSelected != null && customerSelected != null
                    ? await MyApi().getClient()!.utilization(
                        Urls.utlizationSummary +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNo,
                                pageCount,
                                customer?.CustomerUID == null
                                    ? null
                                    : customer!.CustomerUID,
                                sort,
                                appliedFilters!,
                                ScreenType.UTILIZATION),
                        accountSelected!.CustomerUID,
                        Urls.vfleetPrefix)
                    : await MyApi().getClient()!.utilization(
                        Urls.utlizationSummary +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNo,
                                pageCount,
                                null,
                                sort,
                                appliedFilters!,
                                ScreenType.UTILIZATION),
                        accountSelected!.CustomerUID,
                        Urls.vfleetPrefix);
            return response;
          }
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<SingleAssetUtilization?> getSingleAssetUtilizationResult(
    String? assetUID,
    String sort,
    String? startDate,
    String? endDate,
  ) async {
    try {
      Map<String, String> queryMap = Map();
      if (assetUID != null) {
        queryMap["assetUid"] = assetUID;
      }
      if (startDate != null) {
        queryMap["startDate"] = startDate;
      }
      if (endDate != null) {
        queryMap["endDate"] = endDate;
      }
      if (sort != null) {
        queryMap["sort"] = sort;
      }
      if (isVisionLink) {
        SingleAssetUtilization response = await MyApi()
            .getClient()!
            .singleAssetUtilizationVL(
                Urls.utilizationAggregateVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return response;
      } else {
        SingleAssetUtilization response = await MyApi()
            .getClient()!
            .singleAssetUtilization(
                Urls.utilizationAggregate +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.vutilizationPrefix);
        return response;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<UtilizationSummary?> getUtilizationSummary(
      String date, String query) async {
    Logger().i("getUtilizationSummary");
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            query,
            accountSelected?.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);

        UtilizationSummary utilizationSummary = UtilizationSummary.fromJson(
            data.data!["getDashboardUtilizationSummary"]);

        return utilizationSummary;
      } else {
        Map<String, String?> queryMap = Map();
        if (date != null) {
          queryMap["date"] = date;
        }
        if (customerSelected != null) {
          queryMap["customerUID"] = customerSelected!.CustomerUID;
        }
        if (isVisionLink) {
          UtilizationSummary response =
              await MyApi().getClient()!.getAssetUtilizationVL(
                    Urls.utilizationSummaryV1VL +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                  );
          if (response != null) {
            return response;
          } else {
            return null;
          }
        } else {
          UtilizationSummary response = await MyApi()
              .getClient()!
              .getAssetUtilization(
                  Urls.utilizationSummaryV1 +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                  Urls.vfleetPrefix);
          if (response != null) {
            return response;
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<UtilizationSummary?> getUtilizationFilterData(
      endDate, productFamilyKey) async {
    Logger().i("getUtilizationFilterData");
    try {
      Map<String, String?> queryMap = Map();
      if (productFamilyKey != null) {
        queryMap["productfamily"] = productFamilyKey;
      }
      if (endDate != null) {
        queryMap["date"] = endDate;
      }
      if (customerSelected != null) {
        queryMap["customerUID"] = customerSelected!.CustomerUID;
      }
      if (isVisionLink) {
        UtilizationSummary utilizationSummary = await MyApi()
            .getClient()!
            .utilizationSummaryVL(
                Urls.utilizationSummaryV1VL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return utilizationSummary;
      } else {
        UtilizationSummary utilizationSummary = await MyApi()
            .getClient()!
            .utilizationSummary(
                Urls.utilizationSummaryV1 +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.vfleetPrefix);
        return utilizationSummary;
      }
    } catch (e) {
      Logger().d(e);
    }
    return null;
  }
}
