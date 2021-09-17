import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/health/health_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends InsiteViewModel {
  var _localService = locator<LocalService>();
  var _navigationService = locator<NavigationService>();
  var _assetService = locator<AssetStatusService>();
  var _assetLocationService = locator<AssetLocationService>();
  var _localStorageService = locator<LocalStorageService>();
  var _assetUtilizationService = locator<AssetUtilizationService>();
  var _dateRangeService = locator<DateRangeService>();

  Logger log;

  bool _assetStatusloading = true;
  bool get assetStatusloading => _assetStatusloading;

  bool _assetFuelloading = true;
  bool get assetFuelloading => _assetFuelloading;

  bool _idlingLevelDataloading = true;
  bool get idlingLevelDataloading => _idlingLevelDataloading;

  bool _assetLocationloading = true;
  bool get assetLocationloading => _assetLocationloading;

  IdlingLevelRange _idlingLevelRange = IdlingLevelRange.DAY;
  IdlingLevelRange get idlingLevelRange => _idlingLevelRange;
  set idlingLevelRange(IdlingLevelRange catchedRange) {
    this._idlingLevelRange = catchedRange;
  }

  int _totalCount = 0;
  int get totalCount => _totalCount;

  bool _isSwitching = false;
  bool get isSwitching => _isSwitching;

  bool _assetUtilizationLoading = true;
  bool get assetUtilizationLoading => _assetUtilizationLoading;

  double _utilizationTotalGreatestValue;
  double get utilizationTotalGreatestValue => _utilizationTotalGreatestValue;

  double _utilizationAverageGreatestValue;
  double get utilizationAverageGreatestValue =>
      _utilizationAverageGreatestValue;

  AssetCount _assetStatusData;
  AssetCount get assetStatusData => _assetStatusData;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  AssetCount _idlingLevelData;
  AssetCount get idlingLevelData => _idlingLevelData;

  AssetCount _faultCountData;
  AssetCount get faultCountData => _faultCountData;
  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _faultCountloading = true;
  bool get faultCountloading => _faultCountloading;

  String _endDayRange = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDayRange(String endDay) {
    this._endDayRange = endDay;
  }

  String get endDayRange => _endDayRange;

  bool _isFilterApplied = false;
  bool get isFilterApplied => _isFilterApplied;

  String _currentFilterSelected = "";
  String get currentFilterSelected => _currentFilterSelected;

  List<FilterData> filterDataProductFamily = [];

  UtilizationSummary _utilizationSummary;
  UtilizationSummary get utilizationSummary => _utilizationSummary;
  List<ChartSampleData> statusChartData = [];
  List<ChartSampleData> fuelChartData = [];

  DashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setUp();
    _assetLocationService.setUp();
    _localStorageService.setUp();
    _assetUtilizationService.setUp();
    _dateRangeService.setUp();
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetCount();
      getFilterData();
      getData();
    });
  }

  void updateState(newState) {
    notifyListeners();
  }

  int pageNumber = 1;
  int pageSize = 2500;

  void logout() {
    _localService.clearAll();
    _localStorageService.clearAll();
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(loginViewRoute);
    });
  }

  updateDateRangeFilter(FilterData data) async {
    await _dateRangeService.updateDateFilter(data);
  }

  getAssetStatusData() async {
    AssetCount result =
        await _assetService.getAssetCount("assetstatus", FilterType.ALL_ASSETS);
    if (result != null) {
      _assetStatusData = result;
      statusChartData.clear();
      for (var stausData in _assetStatusData.countData) {
        statusChartData.add(ChartSampleData(
          x: stausData.countOf,
          y: stausData.count.round(),
        ));
      }
    }
    _assetStatusloading = false;
    notifyListeners();
  }

  refresh() async {
    _refreshing = true;
    notifyListeners();
    await getAssetCount();
    await getAssetStatusData();
    await getFuelLevelData();
    await getUtilizationSummary();
    await getFaultCountData();
    await getIdlingLevelData(false);
    _refreshing = false;
    notifyListeners();
  }

  getAssetCount() async {
    AssetCount result =
        await _assetService.getAssetCount(null, FilterType.ASSET_STATUS);
    if (result != null) {
      if (result.countData.isNotEmpty && result.countData[0].count != null) {
        _totalCount = result.countData[0].count.toInt();
      }
    }
    notifyListeners();
  }

  getFuelLevelData() async {
    int totalAssetCount = 0;
    AssetCount result = await _assetService.getFuellevel(FilterType.FUEL_LEVEL);
    if (result != null) {
      fuelChartData.clear();
      for (int index = 0; index < result.countData.length; index++) {
        if (result.countData[index].countOf != "Not Reporting") {
          Logger().d("countOf ${result.countData[index].count}");
          totalAssetCount = totalAssetCount + result.countData[index].count;

          fuelChartData.add(ChartSampleData(
              x: result.countData[index].countOf,
              y: result.countData[index].count,
              z: totalAssetCount.toString()));
        }
      }
    }
    _assetFuelloading = false;
    notifyListeners();
  }

  getIdlingLevelData(bool switching) async {
    _isSwitching = switching;
    notifyListeners();
    if (isFilterApplied) {
      AssetCount result = await _assetService.getIdlingLevelFilterData(
        getStartRange(),
        currentFilterSelected,
        endDayRange,
      );
      if (result != null) {
        _idlingLevelData = result;
        _isSwitching = false;
      }
    } else {
      AssetCount result = await _assetService.getIdlingLevelData(
          getStartRange(),
          endDayRange,
          FilterType.IDLING_LEVEL,
          getFilterRange());
      if (result != null) {
        _idlingLevelData = result;
        _isSwitching = false;
      }
    }

    _idlingLevelDataloading = false;
    notifyListeners();
  }

  getFaultCountData() async {
    _faultCountloading = true;
    notifyListeners();
    AssetCount count = await _assetService.getFaultCount(
        Utils.getDateInFormatyyyyMMddTHHmmssZStartSingleAssetDay(endDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate));
    if (count != null) {
      _faultCountData = count;
    }
    _faultCountloading = false;
    notifyListeners();
  }

  onFilterSelected(FilterData data) async {
    Logger().d("onFilterSelected $data");
    // await clearFilterDb();
    await addFilter(data);
    // Future.delayed(Duration(seconds: 1), () {
    // gotoFleetPage();
    // });
  }

  onFaultFilterSelected(FilterData data) async {
    Logger().d("onFilterSelected $data");
    // await clearFilterDb();
    await addFilter(data);
    Future.delayed(Duration(seconds: 1), () {
      gotoFaultPage();
    });
  }

  onIdlingLevelFilterSelected(FilterData data) async {
    Logger().d("onIdlingLevelFilterSelected $data");
    // await clearFilterDb();
    await addFilter(data);
    Future.delayed(Duration(seconds: 1), () {
      gotoUtilizationPage();
    });
  }

  gotoFaultPage() {
    _navigationService.navigateWithTransition(HealthView(),
        transition: "rightToLeft");
  }

  gotoFleetPage() {
    _navigationService.navigateWithTransition(FleetView(),
        transition: "rightToLeft");
  }

  gotoUtilizationPage() {
    _navigationService.navigateWithTransition(UtilLizationView(),
        transition: "rightToLeft");
  }

  getUtilizationSummary() async {
    UtilizationSummary result =
        await _assetUtilizationService.getUtilizationSummary(
            '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}');
    if (result != null) {
      _utilizationSummary = result;
      _utilizationTotalGreatestValue = Utils.greatestOfThree(
          _utilizationSummary.totalDay.runtimeHours,
          _utilizationSummary.totalWeek.runtimeHours,
          _utilizationSummary.totalMonth.runtimeHours);
      _utilizationAverageGreatestValue = Utils.greatestOfThree(
          _utilizationSummary.averageDay.runtimeHours,
          _utilizationSummary.averageWeek.runtimeHours,
          _utilizationSummary.averageMonth.runtimeHours);
    }
    _assetUtilizationLoading = false;
    notifyListeners();
  }

  FilterSubType getFilterRange() {
    switch (_idlingLevelRange) {
      case IdlingLevelRange.DAY:
        return FilterSubType.DAY;
        break;
      case IdlingLevelRange.WEEK:
        return FilterSubType.WEEK;
        break;
      case IdlingLevelRange.MONTH:
        return FilterSubType.MONTH;
        break;
      default:
        return null;
    }
  }

  String getStartRange() {
    switch (_idlingLevelRange) {
      case IdlingLevelRange.DAY:
        return DateFormat('yyyy-MM-dd').format(DateTime.now());
        break;
      case IdlingLevelRange.WEEK:
        return DateFormat('yyyy-MM-dd').format(DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1)));
        break;
      case IdlingLevelRange.MONTH:
        return DateFormat('yyyy-MM-dd')
            .format(DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
        break;
      default:
        return null;
    }
  }

  getFilterData() async {
    AssetCount resultProductfamily = await _assetService.getAssetCount(
        "productfamily", FilterType.PRODUCT_FAMILY);
    addData(filterDataProductFamily, resultProductfamily,
        FilterType.PRODUCT_FAMILY);
  }

  addData(filterData, AssetCount resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
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

  getData() {
    this._isFilterApplied = false;
    this._currentFilterSelected = "";
    getAssetStatusData();
    getFuelLevelData();
    getIdlingLevelData(false);
    getUtilizationSummary();
    getFaultCountData();
  }

  getFilterDataApplied(dropDownValue) async {
    this._isFilterApplied = true;
    this._currentFilterSelected = dropDownValue;
    _refreshing = true;
    notifyListeners();
    await getAssetStatusFilterApplied(dropDownValue);
    await getFuelLevelFilterApplied(dropDownValue);
    await getUtilizationSummaryFilterData(dropDownValue);
    await getIdlingLevelFilterData(dropDownValue);
    await getFaultCountDataFilterData(dropDownValue);
    _refreshing = false;
    notifyListeners();
  }

  getAssetStatusFilterApplied(dropDownValue) async {
    AssetCount result =
        await _assetService.getAssetStatusFilter(dropDownValue, "assetstatus");
    if (result != null) {
      _assetStatusData = result;
      statusChartData.clear();
      for (var stausData in _assetStatusData.countData) {
        statusChartData.add(ChartSampleData(
          x: stausData.countOf,
          y: stausData.count.round(),
        ));
      }
    }
    _assetStatusloading = false;
    notifyListeners();
  }

  getFuelLevelFilterApplied(dropDownValue) async {
    int totalAssetCount = 0;
    AssetCount result =
        await _assetService.getFuellevelFilterData(dropDownValue, "fuellevel");
    if (result != null) {
      fuelChartData.clear();
      for (int index = 0; index < result.countData.length; index++) {
        if (result.countData[index].countOf != "Not Reporting") {
          Logger().d("countOf ${result.countData[index].count}");
          totalAssetCount = totalAssetCount + result.countData[index].count;
          fuelChartData.add(ChartSampleData(
              x: result.countData[index].countOf,
              y: result.countData[index].count,
              z: totalAssetCount.toString()));
        }
      }
    }
    _assetFuelloading = false;
    notifyListeners();
  }

  getIdlingLevelFilterData(dropDownValue) async {
    AssetCount result = await _assetService.getIdlingLevelFilterData(
        getStartRange(), dropDownValue, endDate);
    if (result != null) {
      _idlingLevelData = result;
    }
    _idlingLevelDataloading = false;
    notifyListeners();
  }

  getFaultCountDataFilterData(dropDownValue) async {
    _faultCountloading = true;
    notifyListeners();
    AssetCount count = await _assetService.getFaultCountFilterApplied(
        dropDownValue,
        Utils.getDateInFormatyyyyMMddTHHmmssZStartSingleAssetDay(endDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate));
    if (count != null) {
      _faultCountData = count;
    }
    _faultCountloading = false;
    notifyListeners();
  }

  getUtilizationSummaryFilterData(dropDownValue) async {
    UtilizationSummary result = await _assetUtilizationService
        .getUtilizationFilterData(endDate, dropDownValue);
    if (result != null) {
      _utilizationSummary = result;
      _utilizationTotalGreatestValue = Utils.greatestOfThree(
          _utilizationSummary.totalDay.runtimeHours,
          _utilizationSummary.totalWeek.runtimeHours,
          _utilizationSummary.totalMonth.runtimeHours);
      _utilizationAverageGreatestValue = Utils.greatestOfThree(
          _utilizationSummary.averageDay.runtimeHours,
          _utilizationSummary.averageWeek.runtimeHours,
          _utilizationSummary.averageMonth.runtimeHours);
    }
    _assetUtilizationLoading = false;
    notifyListeners();
  }
}
