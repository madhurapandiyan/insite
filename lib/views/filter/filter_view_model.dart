import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:logger/logger.dart';

class FilterViewModel extends InsiteViewModel {
  var _searchService = locator<FilterService>();
  bool _loading = true;
  bool get loading => _loading;
  List<FilterData> filterDataDeviceType = [];
  List<FilterData> filterDataMake = [];
  List<FilterData> filterDataModel = [];
  List<FilterData> filterDataSubscription = [];
  List<FilterData> filterDataModelYear = [];
  List<FilterData> filterDataProductFamily = [];

  FilterViewModel() {
    _searchService.setUp();
    getFilterData();
  }

  getFilterData() async {
    AssetStatusData resultModel = await _searchService.getAssetCount("model");
    addData(filterDataModel, resultModel, FilterType.MODEL);

    AssetStatusData resultDeviceType =
        await _searchService.getAssetCount("deviceType");
    addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);

    AssetStatusData resultSubscriptiontype =
        await _searchService.getAssetCount("subscriptiontype");
    addData(filterDataSubscription, resultSubscriptiontype,
        FilterType.SUBSCRIPTION_DATE);

    AssetStatusData resultManufacturer =
        await _searchService.getAssetCount("manufacturer");
    addData(filterDataMake, resultManufacturer, FilterType.MAKE);

    AssetStatusData resultProductfamily =
        await _searchService.getAssetCount("productfamily");
    addData(filterDataProductFamily, resultProductfamily, FilterType.MAKE);

    _loading = false;
    notifyListeners();
  }

  addData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (CountData countData in resultModel.countData) {
        FilterData data = FilterData(
            count: countData.count.toString(),
            title: countData.countOf,
            isSelected: false,
            type: type);
        filterData.add(data);
      }
    }
  }

  onFilterSelected(List<FilterData> list, FilterType type) {
    
  }
}
