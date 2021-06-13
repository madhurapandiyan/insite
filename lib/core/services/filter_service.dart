import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';
import '../locator.dart';
import 'local_service.dart';
import 'package:hive/hive.dart';

class FilterService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();
  var box;

  setUp() async {
    try {
      box = await Hive.openBox<FilterData>('filter');
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetCountData> getAssetCount(type) async {
    try {
      AssetCountData assetStatusResponse = await MyApi()
          .getClient()
          .assetCount(type, accountSelected.CustomerUID);
      return assetStatusResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetCountData> getFuellevel(type) async {
    try {
      AssetCountData fuelLevelDatarespone = await MyApi()
          .getClient()
          .fuelLevel(type, "25-50-75-100", accountSelected.CustomerUID);
      print('data:${fuelLevelDatarespone.countData[0].countOf}');
      return fuelLevelDatarespone;
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetCountData> getIdlingLevelData(startDate, endDate) async {
    try {
      AssetCountData idlingLevelDataResponse = await MyApi()
          .getClient()
          .idlingLevel(startDate, "[0,10][10,15][15,25][25,]", endDate,
              accountSelected.CustomerUID);
      print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
      return idlingLevelDataResponse;
    } catch (e) {
      Logger().e(e);
    }
  }

  clearFromSelectedFilter() {}

  //removes filters of particular type
  clearFilterInDb(FilterType type) async {
    try {
      int size = box.values.length;
      print("filter size before clear");
      print(box.values.length);
      print("FilterType " + type.toString());
      for (var i = 0; i < size; i++) {
        FilterData data = box.get(i);
        print("current filter type " + data.type.toString());
        if (data.type == type) {
          await box.deleteAt(i);
        }
      }
      print("filter size after clear");
      print(box.values.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  updateFilterInDb(FilterType type, List<FilterData> list) {
    try {
      for (FilterData data in list) {
        addFilter(data);
      }
      print("filter size after update");
      print(box.values.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<FilterData>> getSelectedFilters() async {
    try {
      Logger().d("getSelectedFilters");
      print(box.values.length);
      return box.values.toList();
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //removes a particular filter
  removeFilter(value) async {
    int size = box.values.length;
    for (var i = 0; i < size; i++) {
      FilterData data = box.get(i);
      print("current filter title " + data.title.toString());
      if (data.title == value.title) {
        await box.deleteAt(i);
        return;
      }
    }
  }

  addFilter(value) async {
    int size = box.values.length;
    if (size == 0) {
      box.add(value);
    } else {
      bool shouldAdd = true;
      for (var i = 0; i < size; i++) {
        FilterData data = box.get(i);
        print("current filter type " + data.type.toString());
        if (data.title == value.title) {
          shouldAdd = false;
          return;
        }
      }
      if (shouldAdd) {
        box.add(value);
      }
    }
  }
}
