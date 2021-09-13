import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/db/asset_count_data.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import '../locator.dart';
import 'local_service.dart';

class AssetStatusService extends DataBaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  AssetStatusService() {
    init();
  }

  init() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
      Logger().d("account selected " + accountSelected.CustomerUID);
      Logger().d("customer selected " + customerSelected.CustomerUID);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetCount> getAssetCount(key, FilterType type) async {
    Logger().d("getAssetCount $type");
    try {
      AssetCount assetCountFromLocal = await getAssetCountFromLocal(type, null);
      if (assetCountFromLocal != null) {
        Logger().d("from local");
        return assetCountFromLocal;
      } else {
        Logger().d("from api");
        if (isVisionLink) {
          AssetCount assetStatusResponse = key != null
              ? customerSelected != null
                  ? await MyApi().getClient().assetCountcustomerUIDVL(key,
                      customerSelected.CustomerUID, accountSelected.CustomerUID)
                  : await MyApi()
                      .getClient()
                      .assetCountVL(key, accountSelected.CustomerUID)
              : customerSelected != null
                  ? await MyApi().getClient().assetCountAllcustomerUIDVL(
                      customerSelected.CustomerUID, accountSelected.CustomerUID)
                  : await MyApi()
                      .getClient()
                      .assetCountAllVL(accountSelected.CustomerUID);
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
          AssetCount assetStatusResponse = key != null
              ? customerSelected != null
                  ? await MyApi().getClient().assetCountcustomerUID(
                      Urls.assetCountSummary,
                      key,
                      customerSelected.CustomerUID,
                      accountSelected.CustomerUID,
                      Urls.vfleetPrefix)
                  : await MyApi().getClient().assetCount(Urls.assetCountSummary,
                      key, accountSelected.CustomerUID, Urls.vfleetPrefix)
              : customerSelected != null
                  ? await MyApi().getClient().assetCountAllcustomerUID(
                      Urls.assetCountSummary,
                      customerSelected.CustomerUID,
                      accountSelected.CustomerUID,
                      Urls.vfleetPrefix)
                  : await MyApi().getClient().assetCountAll(
                      Urls.assetCountSummary,
                      accountSelected.CustomerUID,
                      Urls.vfleetPrefix);
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
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount> getAssetCountByFilter(
    startDate,
    endDate,
    sort,
    screenType,
    appliedFilters,
  ) async {
    Logger().d("getAssetCountByFilter");
    try {
      if (isVisionLink) {
        AssetCount assetStatusResponse =
            await MyApi().getClient().assetCountByFilterVL(
                  Urls.assetCountSubscriptionSummaryVL +
                      FilterUtils.getFilterURLForCount(
                          startDate,
                          endDate,
                          accountSelected != null && customerSelected != null
                              ? customerSelected.CustomerUID
                              : null,
                          sort,
                          appliedFilters,
                          screenType),
                  accountSelected.CustomerUID,
                );
        if (assetStatusResponse != null) {
          return assetStatusResponse;
        } else {
          return null;
        }
      } else {
        AssetCount assetStatusResponse = await MyApi()
            .getClient()
            .assetCountByFilter(
                Urls.assetCountSubscriptionSummary +
                    FilterUtils.getFilterURLForCount(
                        startDate,
                        endDate,
                        accountSelected != null && customerSelected != null
                            ? customerSelected.CustomerUID
                            : null,
                        sort,
                        appliedFilters,
                        screenType),
                accountSelected.CustomerUID,
                Urls.vfleetPrefix);
        if (assetStatusResponse != null) {
          return assetStatusResponse;
        } else {
          return null;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount> getAssetCountFromLocal(
      FilterType type, FilterSubType subType) async {
    try {
      int size = await assetCountBox.values.length;
      if (size == 0) {
        return null;
      } else {
        int index = -1;
        for (var i = 0; i < size; i++) {
          AssetCountData data = assetCountBox.getAt(i);
          if (data.type == type) {
            print("match asset count data " + data.counts.length.toString());
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
          AssetCountData filterData = await assetCountBox.getAt(index);
          List<Count> counts = [];
          for (CountData countData in filterData.counts) {
            counts
                .add(Count(count: countData.count, countOf: countData.countOf));
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
    Logger().d("updateAssetCount $type");
    List<CountData> counts = [];
    try {
      for (Count countData in assetCount.countData) {
        counts
            .add(CountData(count: countData.count, countOf: countData.countOf));
      }
      AssetCountData assetCountData =
          AssetCountData(counts: counts, type: type);
      int size = await assetCountBox.values.length;
      if (size == 0) {
        await assetCountBox.add(assetCountData);
      } else {
        bool shouldUpdate = false;
        int index = -1;
        for (var i = 0; i < size; i++) {
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
              assetCountData.counts.length.toString());
          await assetCountBox.add(assetCountData);
        }
      }
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<AssetCount> getFuellevel(FilterType type) async {
    Logger().d("getFuellevel");
    try {
      AssetCount assetCountFromLocal = await getAssetCountFromLocal(type, null);
      if (assetCountFromLocal != null) {
        Logger().d("from local");
        return assetCountFromLocal;
      } else {
        Logger().d("from api");
        if (isVisionLink) {
          AssetCount fuelLevelDatarespone = customerSelected != null
              ? await MyApi().getClient().fuelLevelCustomerUIDVL(
                    "fuellevel",
                    "25-50-75-100",
                    customerSelected.CustomerUID,
                    accountSelected.CustomerUID,
                  )
              : await MyApi().getClient().fuelLevelVL(
                  "fuellevel", "25-50-75-100", accountSelected.CustomerUID);
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
          AssetCount fuelLevelDatarespone = customerSelected != null
              ? await MyApi().getClient().fuelLevelCustomerUID(
                  Urls.assetCountSummary,
                  "fuellevel",
                  "25-50-75-100",
                  customerSelected.CustomerUID,
                  accountSelected.CustomerUID,
                  Urls.vfleetPrefix)
              : await MyApi().getClient().fuelLevel(
                  Urls.assetCountSummary,
                  "fuellevel",
                  "25-50-75-100",
                  accountSelected.CustomerUID,
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
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCount> getIdlingLevelData(
      startDate, endDate, FilterType type, FilterSubType subType) async {
    Logger().d("getIdlingLevelData");
    try {
      AssetCount assetCountFromLocal =
          await getAssetCountFromLocal(type, subType);
      if (assetCountFromLocal != null) {
        Logger().d(" from local");
        return assetCountFromLocal;
      } else {
        Logger().d(" from api");
        if (isVisionLink) {
          AssetCount idlingLevelDataResponse = customerSelected != null
              ? await MyApi().getClient().idlingLevelCustomerUIDVL(
                    startDate,
                    "[0,10][10,15][15,25][25,]",
                    endDate,
                    customerSelected.CustomerUID,
                    accountSelected.CustomerUID,
                  )
              : await MyApi().getClient().idlingLevelVL(
                    startDate,
                    "[0,10][10,15][15,25][25,]",
                    endDate,
                    accountSelected.CustomerUID,
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
          AssetCount idlingLevelDataResponse = customerSelected != null
              ? await MyApi().getClient().idlingLevelCustomerUID(
                  Urls.assetCountSummary,
                  startDate,
                  "[0,10][10,15][15,25][25,]",
                  endDate,
                  customerSelected.CustomerUID,
                  accountSelected.CustomerUID,
                  Urls.vfleetPrefix)
              : await MyApi().getClient().idlingLevel(
                  Urls.assetCountSummary,
                  startDate,
                  "[0,10][10,15][15,25][25,]",
                  endDate,
                  accountSelected.CustomerUID,
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

  Future<AssetCount> getFaultCount(startDate, endDate) async {
    try {
      if (isVisionLink) {
        AssetCount faultCountResponse = customerSelected != null
            ? await MyApi().getClient().faultCountcustomerUIDVL(
                  Urls.faultCountSummaryVL,
                  startDate,
                  endDate,
                  customerSelected.CustomerUID,
                  accountSelected.CustomerUID,
                )
            : await MyApi().getClient().faultCountVL(
                  Urls.faultCountSummaryVL,
                  startDate,
                  endDate,
                  accountSelected.CustomerUID,
                );
        if (faultCountResponse != null) {
          return faultCountResponse;
        } else {
          return null;
        }
      } else {
        AssetCount faultCountResponse = customerSelected != null
            ? await MyApi().getClient().faultCountcustomerUID(
                Urls.faultCountSummary,
                startDate,
                endDate,
                customerSelected.CustomerUID,
                accountSelected.CustomerUID,
                Urls.faultPrefix)
            : await MyApi().getClient().faultCount(
                Urls.faultCountSummary,
                startDate,
                endDate,
                accountSelected.CustomerUID,
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

  Future<AssetCount> getAssetStatusFilter(productFamilyKey, key) async {
    try {
      if (isVisionLink) {
        AssetCount assetStatusResponse = productFamilyKey != null
            ? await MyApi().getClient().assetStatusFilterDataVL(
                key, productFamilyKey, accountSelected.CustomerUID)
            : await MyApi()
                .getClient()
                .assetCountVL(key, accountSelected.CustomerUID);
        return assetStatusResponse;
      } else {
        AssetCount assetStatusResponse = productFamilyKey != null
            ? await MyApi().getClient().assetStatusFilterData(
                Urls.assetCountSummary,
                key,
                productFamilyKey,
                accountSelected.CustomerUID,
                Urls.vfleetPrefix)
            : await MyApi().getClient().assetCount(Urls.assetCountSummary, key,
                accountSelected.CustomerUID, Urls.vfleetPrefix);
        return assetStatusResponse;
      }
    } catch (e) {
      Logger().d(e.toString());
    }
    return null;
  }

  Future<AssetCount> getFuellevelFilterData(productFamilyKey, key) async {
    try {
      if (isVisionLink) {
        AssetCount assetStatusResponse = productFamilyKey != null
            ? await MyApi().getClient().fuelLevelFilterDataVL(key,
                productFamilyKey, "25-50-75-100", accountSelected.CustomerUID)
            : await MyApi().getClient().fuelLevelVL(
                  "fuellevel",
                  "25-50-75-100",
                  accountSelected.CustomerUID,
                );
        return assetStatusResponse;
      } else {
        AssetCount assetStatusResponse = productFamilyKey != null
            ? await MyApi().getClient().fuelLevelFilterData(
                Urls.assetCountSummary,
                key,
                productFamilyKey,
                "25-50-75-100",
                accountSelected.CustomerUID,
                Urls.vfleetPrefix)
            : await MyApi().getClient().fuelLevel(
                Urls.assetCountSummary,
                "fuellevel",
                "25-50-75-100",
                accountSelected.CustomerUID,
                Urls.vfleetPrefix);
        return assetStatusResponse;
      }
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  Future<AssetCount> getIdlingLevelFilterData(
      startDate, productFamilyKey, endDate) async {
    try {
      if (isVisionLink) {
        AssetCount idlinglevelDataResponse = productFamilyKey != null
            ? await MyApi().getClient().idlingLevelFilterDataVL(
                startDate,
                "[0,10][10,15][15,25][25,]",
                productFamilyKey,
                endDate,
                accountSelected.CustomerUID)
            : await MyApi().getClient().idlingLevelVL(
                startDate,
                "[0,10][10,15][15,25][25,]",
                endDate,
                accountSelected.CustomerUID);
        return idlinglevelDataResponse;
      } else {
        AssetCount idlinglevelDataResponse = productFamilyKey != null
            ? await MyApi().getClient().idlingLevelFilterData(
                Urls.assetCountSummary,
                startDate,
                "[0,10][10,15][15,25][25,]",
                productFamilyKey,
                endDate,
                accountSelected.CustomerUID,
                Urls.vfleetPrefix)
            : await MyApi().getClient().idlingLevel(
                Urls.assetCountSummary,
                startDate,
                "[0,10][10,15][15,25][25,]",
                endDate,
                accountSelected.CustomerUID,
                Urls.vfleetPrefix);
        return idlinglevelDataResponse;
      }
    } catch (e) {
      Logger().d(e);
    }
    return null;
  }

  Future<AssetCount> getIdlingLevel(startDate, endDate) async {
    try {
      if (isVisionLink) {
        AssetCount idlingLevelDataResponse = await MyApi()
            .getClient()
            .idlingLevelVL(startDate, "[0,10][10,15][15,25][25,]", endDate,
                accountSelected.CustomerUID);
        print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
        return idlingLevelDataResponse;
      } else {
        AssetCount idlingLevelDataResponse = await MyApi()
            .getClient()
            .idlingLevel(
                Urls.assetCountSummary,
                startDate,
                "[0,10][10,15][15,25][25,]",
                endDate,
                accountSelected.CustomerUID,
                Urls.vfleetPrefix);
        print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
        return idlingLevelDataResponse;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
