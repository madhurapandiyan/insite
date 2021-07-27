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
        AssetCount assetStatusResponse = key != null
            ? await MyApi()
                .getClient()
                .assetCount(key, accountSelected.CustomerUID)
            : await MyApi()
                .getClient()
                .assetCountAll(accountSelected.CustomerUID);
        bool updated = await updateAssetCount(assetStatusResponse, type);
        Logger().d("updated $updated");
        if (updated) {
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

  Future<AssetCount> getAssetCountByFilter(
    startDate,
    endDate,
    sort,
    screenType,
    appliedFilters,
  ) async {
    Logger().d("getAssetCountByFilter ");
    try {
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
              accountSelected.CustomerUID);
      return assetStatusResponse;
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
      return true;
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
        AssetCount fuelLevelDatarespone = await MyApi().getClient().fuelLevel(
            "fuellevel", "25-50-75-100", accountSelected.CustomerUID);
        print('data:${fuelLevelDatarespone.toJson()}');
        bool updated = await updateAssetCount(fuelLevelDatarespone, type);
        if (updated) {
          return fuelLevelDatarespone;
        } else {
          return null;
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
        AssetCount idlingLevelDataResponse = await MyApi()
            .getClient()
            .idlingLevel(startDate, "[0,10][10,15][15,25][25,]", endDate,
                accountSelected.CustomerUID);
        bool updated = await updateAssetCount(idlingLevelDataResponse, type);
        Logger().d("updated $updated");
        if (updated) {
          return idlingLevelDataResponse;
        } else {
          return null;
        }
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
