import 'dart:core';

import 'package:insite/core/models/asset_status.dart';

import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/db/asset_count_data.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/report_count.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import '../locator.dart';
import 'graphql_schemas_service.dart';
import 'local_service.dart';

class AssetStatusService extends DataBaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();

  AssetStatusService() {
    init();
  }

  init() async {
    try {
      //  await _localService!.saveAccountInfoData();
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
      Logger().d("account selected ${accountSelected?.CustomerUID!}");
      Logger().d("customer selected  ${customerSelected?.CustomerUID!}");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetCount?> getAssetCount(
      key, FilterType type, query, bool? isFromDashboard) async {
    Logger().d("getAssetCount $type");
    try {
      AssetCount? assetCountFromLocal =
          await getAssetCountFromLocal(type, null);
      if (assetCountFromLocal != null) {
        Logger().d("from local");
        return assetCountFromLocal;
      } else {
        Logger().d("from api");
        if (enableGraphQl) {
          var data = await Network().getGraphqlData(
            query: query,
            customerId: accountSelected?.CustomerUID,
            userId: (await _localService!.getLoggedInUser())!.sub,
            subId: customerSelected?.CustomerUID == null
                ? ""
                : customerSelected?.CustomerUID,
          );
          if (isFromDashboard == true) {
            AssetCount assetCountFromGraphql =
                AssetCount.fromJson(data.data['getDashboardAsset']);
            return assetCountFromGraphql;
          }
          if (isFromDashboard == false) {
            AssetCount assetCountFromGraphql =
                AssetCount.fromJson(data.data['fleetFiltersGrouping']);
            return assetCountFromGraphql;
          }
          if (isFromDashboard == null) {
            AssetCount assetCountFromGraphql =
                AssetCount.fromJson(data.data['userManagementRefine']);
            return assetCountFromGraphql;
          }
        } else {
          if (isVisionLink) {
            Map<String, String?> queryMap = Map();
            if (key != null) {
              queryMap["grouping"] = key;
            }
            if (customerSelected != null) {
              queryMap["customerUID"] = customerSelected?.CustomerUID;
            }
            AssetCount assetStatusResponse = await MyApi()
                .getClient()!
                .assetCountVL(
                    Urls.assetCountSummaryVL +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID);

            if (assetStatusResponse != null) {
              bool updated = await updateAssetCount(assetStatusResponse, type);
              Logger().d("updated $updated");
              if (updated) {
                return assetStatusResponse;
              } else {
                return null;
              }
            } else {
              return null;
            }
          } else {
            Map<String, String?> queryMap = Map();
            if (key != null) {
              if (type == FilterType.USERTYPE || type == FilterType.JOBTYPE) {
                queryMap["FilterName"] = key;
              } else {
                queryMap["grouping"] = key;
              }
            }
            if (customerSelected != null) {
              queryMap["customerUID"] = customerSelected?.CustomerUID;
            }

            AssetCount assetStatusResponse = await MyApi()
                .getClient()!
                .assetCount(
                    type == FilterType.USERTYPE || type == FilterType.JOBTYPE
                        ? Urls.userCount +
                            FilterUtils.constructQueryFromMap(queryMap)
                        : Urls.assetCountSummary +
                            FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                    type == FilterType.USERTYPE || type == FilterType.JOBTYPE
                        ? Urls.userCountPrefix
                        : Urls.vfleetPrefix);
            if (assetStatusResponse != null) {
              bool updated = await updateAssetCount(assetStatusResponse, type);
              Logger().d("updated $updated");
              if (updated) {
                return assetStatusResponse;
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount?> getAssetCountByFilter(
      startDate, endDate, sort, screenType, appliedFilters, query) async {
    Logger().d("getAssetCountByFilter");
    try {
      if (!enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data!['utilizationTotal']);

        return assetCountFromGraphql;
      } else {
        if (isVisionLink) {
          AssetCount assetStatusResponse =
              await MyApi().getClient()!.assetCountVL(
                    Urls.assetCountSubscriptionSummaryVL +
                        FilterUtils.getFilterURLForCount(
                            startDate,
                            endDate,
                            accountSelected != null && customerSelected != null
                                ? customerSelected?.CustomerUID
                                : null,
                            sort,
                            appliedFilters,
                            screenType),
                    accountSelected!.CustomerUID,
                  );
          if (assetStatusResponse != null) {
            return assetStatusResponse;
          } else {
            return null;
          }
        } else {
          AssetCount assetStatusResponse = await MyApi()
              .getClient()!
              .assetCount(
                  Urls.assetCountSubscriptionSummary +
                      FilterUtils.getFilterURLForCount(
                          startDate,
                          endDate,
                          accountSelected != null && customerSelected != null
                              ? customerSelected?.CustomerUID
                              : null,
                          sort,
                          appliedFilters,
                          screenType),
                  accountSelected!.CustomerUID,
                  Urls.vfleetPrefix);
          if (assetStatusResponse != null) {
            return assetStatusResponse;
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

  Future<AssetCount?> getAssetCountFromLocal(
      FilterType type, FilterSubType? subType) async {
    try {
      int? size = await assetCountBox.values.length;
      if (size == 0) {
        return null;
      } else {
        int index = -1;
        for (var i = 0; i < size!; i++) {
          AssetCountData data = assetCountBox.getAt(i);
          if (data.type == type) {
            print("match asset count data " + data.counts!.length.toString());
            if (subType != null) {
              if (data.subType == subType) {
                index = i;
              }
            } else {
              index = i;
            }
            break;
          }
        }
        if (index != -1) {
          AssetCountData? filterData = await assetCountBox.getAt(index);
          List<Count> counts = [];
          for (CountData? countData in filterData!.counts!) {
            if (type == FilterType.JOBTYPE || type == FilterType.USERTYPE) {
              counts.add(Count(
                  count: countData!.count,
                  countOf: countData.countOf,
                  name: countData.name,
                  id: countData.id));
            } else {
              counts.add(Count(
                count: countData!.count,
                countOf: countData.countOf,
              ));
            }
          }
          return AssetCount(countData: counts);
        }
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<bool> updateAssetCount(AssetCount assetCount, FilterType type) async {
    Logger().d("updateAssetCount $assetCount $type");
    List<CountData> counts = [];
    try {
      if (assetCount == null) {
        return false;
      }
      for (Count? countData in assetCount.countData!) {
        if (type == FilterType.JOBTYPE || type == FilterType.USERTYPE) {
          counts.add(CountData(
              count: countData!.count,
              countOf: countData.countOf,
              name: countData.name,
              id: countData.id));
        } else {
          counts.add(CountData(
            count: countData!.count,
            countOf: countData.countOf,
          ));
        }
      }
      AssetCountData assetCountData =
          AssetCountData(counts: counts, type: type);
      int? size = await assetCountBox.values.length;
      if (size == 0) {
        await assetCountBox.add(assetCountData);
      } else {
        bool shouldUpdate = false;
        int index = -1;
        for (var i = 0; i < size!; i++) {
          AssetCountData data = await assetCountBox.getAt(i);
          if (data.type == assetCountData.type) {
            shouldUpdate = true;
            index = i;
            break;
          }
        }
        if (shouldUpdate) {
          print("update asset count data index and value" +
              index.toString() +
              " " +
              assetCountData.type.toString());
          await assetCountBox.putAt(index, assetCountData);
        } else {
          print("update asset count data " +
              assetCountData.counts!.length.toString());
          await assetCountBox.add(assetCountData);
        }
      }
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<AssetCount?> getFuellevel(FilterType type, String query) async {
    Logger().d("getFuellevel");
    try {
      AssetCount? assetCountFromLocal =
          await getAssetCountFromLocal(type, null);
      if (assetCountFromLocal != null) {
        Logger().d("from local");
        return assetCountFromLocal;
      } else {
        Logger().d("from api");
        if (enableGraphQl) {
          var data = await Network().getGraphqlData(
            query: query,
            customerId: accountSelected?.CustomerUID,
            userId: (await _localService!.getLoggedInUser())!.sub,
            subId: customerSelected?.CustomerUID == null
                ? ""
                : customerSelected?.CustomerUID,
          );
          AssetCount assetCountFromGraphql =
              AssetCount.fromJson(data.data['getDashboardAsset']);
          return assetCountFromGraphql;
          // else {
          //     // AssetCount assetCountFromGraphql =
          //     //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
          //     //     return assetCountFromGraphql;
          //   }
        } else {
          if (isVisionLink) {
            Map<String, String?> queryMap = Map();
            queryMap["grouping"] = "fuellevel";
            queryMap["thresholds"] = "25-50-75-100";
            if (customerSelected != null) {
              queryMap["customerUID"] = customerSelected?.CustomerUID;
            }
            AssetCount fuelLevelDatarespone = customerSelected != null
                ? await MyApi().getClient()!.assetCountVL(
                      Urls.assetCountSummaryVL +
                          FilterUtils.constructQueryFromMap(queryMap),
                      accountSelected!.CustomerUID,
                    )
                : await MyApi().getClient()!.assetCountVL(
                      Urls.assetCountSummaryVL +
                          FilterUtils.constructQueryFromMap(queryMap),
                      accountSelected!.CustomerUID,
                    );
            print('data:${fuelLevelDatarespone.toJson()}');
            if (fuelLevelDatarespone != null) {
              bool updated = await updateAssetCount(fuelLevelDatarespone, type);
              if (updated) {
                return fuelLevelDatarespone;
              } else {
                return null;
              }
            } else {
              return null;
            }
          } else {
            Map<String, String?> queryMap = Map();
            queryMap["grouping"] = "fuellevel";
            queryMap["thresholds"] = "25-50-75-100";
            if (customerSelected != null) {
              queryMap["customerUID"] = customerSelected?.CustomerUID;
            }
            AssetCount fuelLevelDatarespone = await MyApi()
                .getClient()!
                .fuelLevel(
                    Urls.assetCountSummary +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                    Urls.vfleetPrefix);
            print('data:${fuelLevelDatarespone.toJson()}');
            if (fuelLevelDatarespone != null) {
              bool updated = await updateAssetCount(fuelLevelDatarespone, type);
              if (updated) {
                return fuelLevelDatarespone;
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount?> getIdlingLevelData(startDate, endDate, FilterType type,
      FilterSubType? subType, String query) async {
    Logger().d("getIdlingLevelData");
    try {
      AssetCount? assetCountFromLocal =
          await getAssetCountFromLocal(type, subType);
      if (assetCountFromLocal != null) {
        Logger().d(" from local");
        return assetCountFromLocal;
      } else {
        Logger().d(" from api");
        Map<String, String> queryMap = Map();
        queryMap["startDate"] = startDate;
        queryMap["endDate"] = endDate;
        queryMap["idleEfficiencyRanges"] = "[0,10][10,15][15,25][25,]";
        if (customerSelected != null) {
          queryMap["customerUID"] = customerSelected!.CustomerUID!;
        }
        if (enableGraphQl) {
          // Logger().w(isFromDashboard);
          var data = await Network().getGraphqlData(
            query: query,
            customerId: accountSelected?.CustomerUID,
            userId: (await _localService!.getLoggedInUser())!.sub,
            subId: customerSelected?.CustomerUID == null
                ? ""
                : customerSelected?.CustomerUID,
          );
          // if (isFromDashboard) {
          AssetCount assetCountFromGraphql =
              AssetCount.fromJson(data.data['getDashboardAsset']);
          return assetCountFromGraphql;
          // } else {
          //   // AssetCount assetCountFromGraphql =
          //   //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
          //   //     return assetCountFromGraphql;
          // }
        }
        if (isVisionLink) {
          AssetCount idlingLevelDataResponse =
              await MyApi().getClient()!.idlingLevelVL(
                    Urls.assetCountSummaryVL +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                  );
          if (idlingLevelDataResponse != null) {
            bool updated =
                await updateAssetCount(idlingLevelDataResponse, type);
            Logger().d("updated $updated");
            if (updated) {
              return idlingLevelDataResponse;
            } else {
              return null;
            }
          } else {
            return null;
          }
        } else {
          AssetCount idlingLevelDataResponse = await MyApi()
              .getClient()!
              .idlingLevel(
                  Urls.assetCountSummary +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                  Urls.vfleetPrefix);
          if (idlingLevelDataResponse != null) {
            bool updated =
                await updateAssetCount(idlingLevelDataResponse, type);
            Logger().d("updated $updated");
            if (updated) {
              return idlingLevelDataResponse;
            } else {
              return null;
            }
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

  Future<AssetCount?> getFaultCount(startDate, endDate, query) async {
    //dashboardcountdata returns null
    //faultcountdata  returns null

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

        AssetCount faultCountResponse =
            AssetCount.fromJson(data.data!['faultCountData']);

        return faultCountResponse;
      } else {
        if (isVisionLink) {
          Map<String, String?> queryMap = Map();
          queryMap["startDateTime"] = startDate;
          queryMap["endDateTime"] = endDate;
          if (customerSelected != null) {
            queryMap["customerUid"] = customerSelected?.CustomerUID;
          }
          AssetCount faultCountResponse =
              await MyApi().getClient()!.faultCountVL(
                    Urls.faultCountSummaryVL +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                  );
          if (faultCountResponse != null) {
            Logger().wtf("response");
            return faultCountResponse;
          } else {
            return null;
          }
        } else {
          Map<String, String?> queryMap = Map();
          queryMap["startDateTime"] = startDate;
          queryMap["endDateTime"] = endDate;
          if (customerSelected != null) {
            queryMap["customerUid"] = customerSelected?.CustomerUID;
          }
          AssetCount faultCountResponse = await MyApi().getClient()!.faultCount(
              Urls.faultCountSummary +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID,
              Urls.faultPrefix);
          if (faultCountResponse != null) {
            return faultCountResponse;
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

  Future<AssetCount?> getFaultCountFilterApplied(
      filter, startDate, endDate, String query) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["startDateTime"] = startDate;
      queryMap["endDateTime"] = endDate;
      queryMap["productfamily"] = filter;
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected!.CustomerUID!;
      }
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        // if (isFromDashboard) {
        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data['faultCountData']);
        return assetCountFromGraphql;
        // } else {
        // AssetCount assetCountFromGraphql =
        //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
        //     return assetCountFromGraphql;
        //}
      }
      if (isVisionLink) {
        AssetCount faultCountResponse = await MyApi().getClient()!.faultCountVL(
              Urls.faultCountSummaryVL +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID,
            );
        if (faultCountResponse != null) {
          return faultCountResponse;
        } else {
          return null;
        }
      } else {
        AssetCount faultCountResponse = await MyApi().getClient()!.faultCount(
            Urls.faultCountSummary +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected!.CustomerUID,
            Urls.faultPrefix);
        if (faultCountResponse != null) {
          return faultCountResponse;
        } else {
          return null;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount?> getAssetStatusFilter(productFamilyKey, key) async {
    try {
      Map<String, String> queryMap = Map();
      if (key != null) {
        queryMap["grouping"] = key;
      }
      if (productFamilyKey != null) {
        queryMap["productfamily"] = productFamilyKey;
      }
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected!.CustomerUID!;
      }
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: graphqlSchemaService!.getAssetCount(
              grouping: "assetstatus", productFamily: productFamilyKey),
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        // if (isFromDashboard) {
        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data['getDashboardAsset']);
        return assetCountFromGraphql;
        // } else {
        // AssetCount assetCountFromGraphql =
        //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
        //     return assetCountFromGraphql;
        //}
      }
      if (isVisionLink) {
        AssetCount assetStatusResponse = await MyApi()
            .getClient()!
            .assetCountVL(
                Urls.assetCountSummaryVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return assetStatusResponse;
      } else {
        AssetCount assetStatusResponse = await MyApi().getClient()!.assetCount(
            Urls.assetCountSummary +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected!.CustomerUID,
            Urls.vfleetPrefix);
        return assetStatusResponse;
      }
    } catch (e) {
      Logger().d(e.toString());
    }
    return null;
  }

  Future<AssetCount?> getFuellevelFilterData(productFamilyKey, key) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["grouping"] = key;
      if (productFamilyKey != null) {
        queryMap["productfamily"] = productFamilyKey;
      }
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected!.CustomerUID!;
      }
      queryMap["thresholds"] = "25-50-75-100";
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: graphqlSchemaService!.getAssetCount(
              grouping: "fuellevel",
              productFamily: productFamilyKey,
              threshold: "25-50-75-100"),
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        // if (isFromDashboard) {
        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data['getDashboardAsset']);
        return assetCountFromGraphql;
        // } else {
        // AssetCount assetCountFromGraphql =
        //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
        //     return assetCountFromGraphql;
        //}
      }
      if (isVisionLink) {
        AssetCount assetStatusResponse = await MyApi().getClient()!.fuelLevelVL(
              Urls.assetCountSummaryVL +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID,
            );
        return assetStatusResponse;
      } else {
        AssetCount assetStatusResponse = await MyApi().getClient()!.fuelLevel(
            Urls.assetCountSummary +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected!.CustomerUID,
            Urls.vfleetPrefix);
        return assetStatusResponse;
      }
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  Future<AssetCount?> getIdlingLevelFilterData(
      startDate, String? productFamilyKey, endDate, query) async {
    try {
      if (enableGraphQl) {
        // Logger().w(isFromDashboard);
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        // if (isFromDashboard) {
        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data['getDashboardAsset']);
        return assetCountFromGraphql;
        // } else {
        //   // AssetCount assetCountFromGraphql =
        //   //     AssetCount.fromJson(data.data['fleetFiltersGrouping']);
        //   //     return assetCountFromGraphql;
        // }
      } else {
        Map<String, String?> queryMap = Map();
        queryMap["startDate"] = startDate;
        queryMap["endDate"] = endDate;
        queryMap["idleEfficiencyRanges"] = "[0,10][10,15][15,25][25,]";
        if (productFamilyKey != null && productFamilyKey.isNotEmpty) {
          queryMap["productfamily"] = productFamilyKey;
        }
        if (customerSelected != null) {
          queryMap["customerUid"] = customerSelected?.CustomerUID;
        }
        if (isVisionLink) {
          AssetCount idlinglevelDataResponse = await MyApi()
              .getClient()!
              .idlingLevelVL(
                  Urls.assetCountSummaryVL +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID);
          return idlinglevelDataResponse;
        } else {
          AssetCount idlinglevelDataResponse = await MyApi()
              .getClient()!
              .idlingLevel(
                  Urls.assetCountSummary +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                  Urls.vfleetPrefix);
          return idlinglevelDataResponse;
        }
      }
    } catch (e) {
      Logger().d(e);
    }
    return null;
  }

  Future<AssetCount?> getIdlingLevel(startDate, endDate, query) async {
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

        AssetCount assetCountFromGraphql =
            AssetCount.fromJson(data.data!['getDashboardAsset']);

        return assetCountFromGraphql;
      } else {
        Map<String, String> queryMap = Map();
        queryMap["startDate"] = startDate;
        queryMap["endDate"] = endDate;
        queryMap["idleEfficiencyRanges"] = "[0,10][10,15][15,25][25,]";
        if (isVisionLink) {
          AssetCount idlingLevelDataResponse = await MyApi()
              .getClient()!
              .idlingLevelVL(
                  Urls.assetCountSummaryVL +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID);
          print('idlingdata:${idlingLevelDataResponse.countData![0].count}');
          return idlingLevelDataResponse;
        } else {
          AssetCount idlingLevelDataResponse = await MyApi()
              .getClient()!
              .idlingLevel(
                  Urls.assetCountSummary +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                  Urls.vfleetPrefix);
          print('idlingdata:${idlingLevelDataResponse.countData![0].count}');
          return idlingLevelDataResponse;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<ReportCount?> getCountReportData(query) async {
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
        ReportCount reportCountResponse =
            ReportCount.fromJson(data.data['reportCount']);
        return reportCountResponse;
      } else {
        if (isVisionLink) {
          ReportCount reportCountResponse = await MyApi()
              .getClientSeven()!
              .getReportCountDataVL(Urls.manageReportData + "/" + "Count",
                  accountSelected!.CustomerUID);
          return reportCountResponse;
        } else {
          ReportCount reportCountResponse = await MyApi()
              .getClient()!
              .getReportCountData(
                  Urls.countReportData,
                  "in-reports-rpt-rmapi",
                  accountSelected!.CustomerUID,
                  (await _localService!.getLoggedInUser())!.sub);
          return reportCountResponse;
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
