import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class FilterViewModel extends InsiteViewModel {
  AssetStatusService? _assetService = locator<AssetStatusService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();
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
  List<FilterData> filterSeverity = [];
  List<FilterData> filterDataJobType = [];
  List<FilterData> filterDataUserType = [];

  List<FilterData?>? selectedFilterData = [];
  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FilterViewModel() {
    setUp();
    _assetService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
      getFilterData();
    });
  }

  getFilterData() async {
    AssetCount? resultModel = await _assetService!.getAssetCount(
        "model", FilterType.MODEL, _graphqlSchemaService!.allAssets);
    addData(filterDataModel, resultModel, FilterType.MODEL);

    AssetCount? resultDeviceType = await _assetService!.getAssetCount(
        "deviceType", FilterType.DEVICE_TYPE, _graphqlSchemaService!.allAssets);
    addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);

    // AssetCount resultSubscriptiontype = await _assetService.getAssetCount(
    //     "subscriptiontype", FilterType.SUBSCRIPTION_DATE);
    // addData(filterDataSubscription, resultSubscriptiontype,
    //     FilterType.SUBSCRIPTION_DATE);

    AssetCount? resultManufacturer = await _assetService!.getAssetCount(
        "manufacturer", FilterType.MAKE, _graphqlSchemaService!.allAssets);
    addData(filterDataMake, resultManufacturer, FilterType.MAKE);

    AssetCount? resultProductfamily = await _assetService!.getAssetCount(
        "productfamily",
        FilterType.PRODUCT_FAMILY,
        _graphqlSchemaService!.allAssets);
    addData(filterDataProductFamily, resultProductfamily,
        FilterType.PRODUCT_FAMILY);

    AssetCount? resultAllAssets = await _assetService!.getAssetCount(
        "assetstatus",
        FilterType.ALL_ASSETS,
        _graphqlSchemaService!.assetStatusCount);
    addData(filterDataAllAssets, resultAllAssets, FilterType.ALL_ASSETS);

    AssetCount? resultFuelLevel = await _assetService!.getFuellevel(
        FilterType.FUEL_LEVEL, _graphqlSchemaService!.fuelLevelCount);
    filterDataFuelLevel.removeWhere((element) => element.title == "");
    addFuelData(filterDataFuelLevel, resultFuelLevel, FilterType.FUEL_LEVEL);

    AssetCount? resultIdlingLevel = await _assetService!
        .getIdlingLevelData(startDate, endDate, FilterType.IDLING_LEVEL, null);
    addIdlingData(
        filterDataIdlingLevel, resultIdlingLevel, FilterType.IDLING_LEVEL);

    AssetCount? resultSeverity = await _assetService!.getFaultCount(
        Utils.getDateInFormatyyyyMMddTHHmmssZStartSingleAssetDay(startDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        _graphqlSchemaService!.getFaultCountData);
    addData(filterSeverity, resultSeverity, FilterType.SEVERITY);

    AssetCount? resultJobType = await _assetService!.getAssetCount(
        "JobType", FilterType.JOBTYPE, _graphqlSchemaService!.allAssets);
    addUserData(filterDataJobType, resultJobType!, FilterType.JOBTYPE);

    AssetCount? resultUserType = await _assetService!.getAssetCount(
        "UserType", FilterType.USERTYPE, _graphqlSchemaService!.allAssets);
    addUserData(filterDataUserType, resultUserType!, FilterType.USERTYPE);

    selectedFilterData = appliedFilters;
    _loading = false;
    notifyListeners();
  }

  addData(filterData, AssetCount? resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData!.isNotEmpty) {
      for (Count countData in resultModel.countData!) {
        // if (countData.countOf != "Not Reporting" && //enabling not reporting
        if (countData.countOf != "Excluded") {
          FilterData data = FilterData(
              count: type == FilterType.SEVERITY
                  ? countData.assetCount.toString()
                  : countData.count.toString(),
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

  addUserData(filterData, AssetCount resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData!.isNotEmpty) {
      for (Count countData in resultModel.countData!) {
        FilterData data = FilterData(
            count: countData.count.toString(),
            title: countData.name,
            isSelected: isAlreadSelected(countData.countOf, type),
            extras: [countData.id.toString()],
            type: type);
        filterData.add(data);
      }
    }
  }

  void onFilterApplied() {
    _isRefreshing = true;
    notifyListeners();
    updateFilterInDb(selectedFilterData!);
    getSelectedFilterData();
    _isRefreshing = false;
    notifyListeners();
  }

  addIdlingData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          var x = countData.countOf!
              .split(",")
              .first
              .replaceAll("[", "")
              .replaceAll("]", "");
          var y = countData.countOf!
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

  removeAllSelectedFilter() async {
    selectedFilterData!.clear();
    notifyListeners();
  }

  removeSelectedFilter(value) async {
    Logger().d("removeFilter title " + value.title.toString());
    try {
      int size = selectedFilterData!.length;
      if (size > 0) {
        for (var i = 0; i < size; i++) {
          FilterData data = selectedFilterData![i]!;
          Logger().d("current filter data on loop ", data);
          if (data.title == value.title && data.type == value.type) {
            print("delete filter " + data.title.toString());
            selectedFilterData!.removeAt(i);
            break;
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onFilterSelected(List<FilterData> list, FilterType type) {
    if (list.isEmpty) {
      clearFilterOfType(type);
    } else {
      list.forEach((element) {
        updateFilter(element);
      });
    }
    notifyListeners();
    // updateFilterInDb(list);
    // getSelectedFilterData();
  }

  updateFilter(FilterData value) async {
    int size = selectedFilterData!.length;
    if (size == 0) {
      selectedFilterData!.add(value);
    } else {
      bool shouldAdd = true;
      for (var i = 0; i < size; i++) {
        FilterData data = selectedFilterData![i]!;
        if (data.title == value.title) {
          shouldAdd = false;
          break;
        }
      }
      if (shouldAdd) {
        print("add filter " + value.title.toString());
        selectedFilterData!.add(value);
      }
    }
  }

  //removes filters of particular type
  clearFilterOfType(FilterType type) async {
    try {
      int size = selectedFilterData!.length;
      print("filter size before clear");
      print(selectedFilterData!.length);
      print("FilterType " + type.toString());
      selectedFilterData!.removeWhere((element) => element!.type == type);
      //commenting tradional way of removing elements in list
      // for (var i = 0; i < size; i++) {
      //   FilterData data = selectedFilterData[i];
      //   Logger().d("current filter data on loop ${data.type} , ${data.title}");
      //   if (data.type == type) {
      //     selectedFilterData.removeAt(i);
      //   }
      // }
      print("filter size after clear");
      print(selectedFilterData!.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  onFilterCleared(FilterType type) {
    clearFilterOfType(type);
    notifyListeners();
    // clearFilterOfTypeInDb(type);
    // getSelectedFilterData();
  }
}
