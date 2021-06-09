import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/filter_service.dart';

class FilterViewModel extends InsiteViewModel {
  var _filterService = locator<FilterService>();
  bool _loading = true;
  bool get loading => _loading;
  List<FilterData> filterDataDeviceType = [];
  List<FilterData> filterDataMake = [];
  List<FilterData> filterDataModel = [];
  List<FilterData> filterDataSubscription = [];
  List<FilterData> filterDataModelYear = [];
  List<FilterData> filterDataProductFamily = [];
  List<FilterData> filterDataAllAssets = [];
  List<FilterData> filteredData = [];

  FilterViewModel() {
    _filterService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getFilterData();
    });
  }

  getFilterData() async {
    AssetStatusData resultModel = await _filterService.getAssetCount("model");
    addData(filterDataModel, resultModel, FilterType.MODEL);

    AssetStatusData resultDeviceType =
        await _filterService.getAssetCount("deviceType");
    addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);

    AssetStatusData resultSubscriptiontype =
        await _filterService.getAssetCount("subscriptiontype");
    addData(filterDataSubscription, resultSubscriptiontype,
        FilterType.SUBSCRIPTION_DATE);

    AssetStatusData resultManufacturer =
        await _filterService.getAssetCount("manufacturer");
    addData(filterDataMake, resultManufacturer, FilterType.MAKE);

    AssetStatusData resultProductfamily =
        await _filterService.getAssetCount("productfamily");
    addData(filterDataProductFamily, resultProductfamily,
        FilterType.PRODUCT_FAMILY);

    AssetStatusData resultAllAssets =
        await _filterService.getAssetCount("assetstatus");
    addData(filterDataAllAssets, resultAllAssets, FilterType.ALL_ASSETS);

    // AssetStatusData resultFuleLevel =
    //     await _searchService.getAssetCount("fuellevel");
    // addData(filterDataProductFamily, resultProductfamily, FilterType.MAKE);

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

  @override
  void dispose() {
    super.dispose();
  }

  onFilterSelected(List<FilterData> list, FilterType type) {
    _filterService.updateFilterInDb(type, list);
    getSelectedFilterData();
  }

  onFilterCleared(FilterType type) {
    _filterService.clearFilterInDb(type);
  }
}
