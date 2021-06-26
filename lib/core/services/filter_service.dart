import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';

class FilterService extends DataBaseService {
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
      return null;
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
      return null;
    }
  }

  clearFromSelectedFilter() {}

  clearDatabase() {
    box.clear();
  }

  //removes filters of particular type
  clearFilterInDb(FilterType type) async {
    try {
      int size = box.values.length;
      print("filter size before clear");
      print(box.values.length);
      print("FilterType " + type.toString());
      for (var i = 0; i < size; i++) {
        FilterData data = box.getAt(i);
        Logger().d("current filter data on loop ", data);
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
      return await box.values.toList();
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //removes a particular filter
  removeFilter(FilterData value) {
    try {
      int size = box.values.length;
      Logger().d("removeFilter service " + size.toString());
      if (size > 0) {
        for (var i = 0; i <= size; i++) {
          FilterData data = box.getAt(i);
          Logger().d("current filter data on loop ", data);
          if (data.title == value.title && data.type == value.type) {
            print("delete filter " + data.title.toString());
            box.deleteAt(i);
            return;
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  addFilter(FilterData value) async {
    int size = box.values.length;
    if (size == 0) {
      box.add(value);
    } else {
      bool shouldAdd = true;
      for (var i = 0; i < size; i++) {
        FilterData data = box.getAt(i);
        if (data.title == value.title) {
          shouldAdd = false;
          return;
        }
      }
      if (shouldAdd) {
        print("add filter " + value.title.toString());
        await box.add(value);
      }
    }
  }

  updateFilter(FilterData value) async {
    int size = box.values.length;
    if (size == 0) {
      box.add(value);
    } else {
      bool shouldUpdate = false;
      int index = 0;
      for (var i = 0; i < size; i++) {
        FilterData data = box.getAt(i);
        if (data.title == value.title) {
          shouldUpdate = true;
          index = i;
          return;
        }
      }
      if (shouldUpdate) {
        print("update date filter index and value" +
            index.toString() +
            " " +
            value.title.toString());
        await box.putAt(index, value);
      } else {
        print("add date filter and value" + value.title.toString());
        await box.add(value);
      }
    }
  }
}
