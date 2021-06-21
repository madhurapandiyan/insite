import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
  List<FilterData> filterDataFuelLevel = [];
  List<FilterData> filterDataIdlingLevel = [];
  List<FilterData> selectedFilterData = [];

  // String _startDate =
  //     '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}-${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}-${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}';
  String _startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String get startDate => _startDate;

  // String _endDate =
  //     '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String _endDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(Duration(days: DateTime.now().weekday)));
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  String get endDate => _endDate;

  FilterViewModel() {
    _filterService.setUp();
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
      getFilterData();
    });
  }

  getFilterData() async {
    AssetCountData resultModel = await _filterService.getAssetCount("model");
    addData(filterDataModel, resultModel, FilterType.MODEL);

    AssetCountData resultDeviceType =
        await _filterService.getAssetCount("deviceType");
    addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);

    AssetCountData resultSubscriptiontype =
        await _filterService.getAssetCount("subscriptiontype");
    addData(filterDataSubscription, resultSubscriptiontype,
        FilterType.SUBSCRIPTION_DATE);

    AssetCountData resultManufacturer =
        await _filterService.getAssetCount("manufacturer");
    addData(filterDataMake, resultManufacturer, FilterType.MAKE);

    AssetCountData resultProductfamily =
        await _filterService.getAssetCount("productfamily");
    addData(filterDataProductFamily, resultProductfamily,
        FilterType.PRODUCT_FAMILY);

    AssetCountData resultAllAssets =
        await _filterService.getAssetCount("assetstatus");
    addData(filterDataAllAssets, resultAllAssets, FilterType.ALL_ASSETS);

    AssetCountData resultFuelLevel =
        await _filterService.getFuellevel("fuellevel");
    filterDataFuelLevel.removeWhere((element) => element.title == "");
    addFuelData(filterDataFuelLevel, resultFuelLevel, FilterType.FUEL_LEVEL);

    AssetCountData resultIdlingLevel =
        await _filterService.getIdlingLevelData(startDate, endDate);
    addIdlingData(
        filterDataIdlingLevel, resultIdlingLevel, FilterType.IDLING_LEVEL);

    _loading = false;
    notifyListeners();
  }

  addData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (CountData countData in resultModel.countData) {
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
      for (CountData countData in resultModel.countData) {
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
      for (CountData countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          var x = countData.countOf
              .split(",")
              .first
              .replaceAll("[", "")
              .replaceAll("]", "");
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
