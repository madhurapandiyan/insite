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

  Future<AssetStatusData> getAssetCount(type) async {
    try {
      AssetStatusData assetStatusResponse = await MyApi()
          .getClient()
          .assetCount(type, accountSelected.CustomerUID);
      return assetStatusResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  void clearFromSelectedFilter() {}

  void clearFilterInDb(FilterType type) async {
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

  void updateFilterInDb(FilterType type, List<FilterData> list) {
    try {
      for (FilterData data in list) {
        box.add(data);
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
}
