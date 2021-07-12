import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class FilterViewModel extends InsiteViewModel {
  var _filterService = locator<FilterService>();
  var _assetService = locator<AssetStatusService>();
  bool _loading = true;
  bool get loading => _loading;
  List<FilterData> filterDataDeviceType = [];
  List<FilterData> filterDataMake = [];
  List<FilterData> filterDataModel = [];
  List<FilterData> filterDataSubscription = [];
  List<FilterData> filterDataModelYear = [];
  List<FilterData> filterDataProductFamily = [];
  List<FilterData> filterDataAllAssets = [];
  List<FilterData> filterDataFuelLevel = [];
  List<FilterData> filterDataIdlingLevel = [];
  List<FilterData> selectedFilterData = [];

  FilterViewModel() {
    _filterService.setUp();
    _assetService.setUp();
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
      getFilterData();
    });
  }

  getFilterData() async {
    AssetCount resultModel =
        await _assetService.getAssetCount("model", FilterType.MODEL);
    addData(filterDataModel, resultModel, FilterType.MODEL);

    AssetCount resultDeviceType =
        await _assetService.getAssetCount("deviceType", FilterType.DEVICE_TYPE);
    addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);

    AssetCount resultSubscriptiontype = await _assetService.getAssetCount(
        "subscriptiontype", FilterType.SUBSCRIPTION_DATE);
    addData(filterDataSubscription, resultSubscriptiontype,
        FilterType.SUBSCRIPTION_DATE);

    AssetCount resultManufacturer =
        await _assetService.getAssetCount("manufacturer", FilterType.MAKE);
    addData(filterDataMake, resultManufacturer, FilterType.MAKE);

    AssetCount resultProductfamily = await _assetService.getAssetCount(
        "productfamily", FilterType.PRODUCT_FAMILY);
    addData(filterDataProductFamily, resultProductfamily,
        FilterType.PRODUCT_FAMILY);

    AssetCount resultAllAssets =
        await _assetService.getAssetCount("assetstatus", FilterType.ALL_ASSETS);
    addData(filterDataAllAssets, resultAllAssets, FilterType.ALL_ASSETS);

    AssetCount resultFuelLevel =
        await _assetService.getFuellevel(FilterType.FUEL_LEVEL);
    filterDataFuelLevel.removeWhere((element) => element.title == "");
    addFuelData(filterDataFuelLevel, resultFuelLevel, FilterType.FUEL_LEVEL);

    AssetCount resultIdlingLevel = await _assetService.getIdlingLevelData(
        startDate, endDate, FilterType.IDLING_LEVEL);
    addIdlingData(
        filterDataIdlingLevel, resultIdlingLevel, FilterType.IDLING_LEVEL);

    _loading = false;
    notifyListeners();
  }

  addData(filterData, AssetCount resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

  addFuelData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

  addIdlingData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          var x = countData.countOf;
          var y = countData.countOf
              .split(",")
              .last
              .replaceAll("[", "")
              .replaceAll("]", "");
          Logger().d("idling level data x", x);
          Logger().d("idling level data y", y);
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [x, y],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

  bool isAlreadSelected(String name, FilterType type) {
    try {
      var item = appliedFilters.isNotEmpty
          ? appliedFilters.firstWhere(
              (element) => element.title == name && element.type == type,
              orElse: () {
                return null;
              },
            )
          : null;
      if (item != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
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
    getSelectedFilterData();
  }
}
