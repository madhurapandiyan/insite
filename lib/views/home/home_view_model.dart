import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/widgets/smart_widgets/idling_level.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_view.dart';

class HomeViewModel extends InsiteViewModel {
  var _localService = locator<LocalService>();
  var _navigationService = locator<NavigationService>();
  var _assetService = locator<AssetStatusService>();
  var _assetLocationService = locator<AssetLocationService>();
  var _localStorageService = locator<LocalStorageService>();
  var _assetUtilizationService = locator<AssetUtilizationService>();

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

  AssetCount _fuelLevelData;
  AssetCount get fuelLevelData => _fuelLevelData;

  AssetCount _idlingLevelData;
  AssetCount get idlingLevelData => _idlingLevelData;

  String _endDayRange = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDayRange(String endDay) {
    this._endDayRange = endDay;
  }

  String get endDayRange => _endDayRange;

  UtilizationSummary _utilizationSummary;
  UtilizationSummary get utilizationSummary => _utilizationSummary;
  List<ChartSampleData> statusChartData = [];
  List<ChartSampleData> fuelChartData = [];

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setUp();
    _assetLocationService.setUp();
    _localStorageService.setUp();
    _assetUtilizationService.setUp();
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetStatusData();
      getFuelLevelData();
      getIdlingLevelData();
      //  getAssetLocation();
      getUtilizationSummary();
    });
  }

  void updateState(newState) {
    notifyListeners();
  }

  int pageNumber = 1;
  int pageSize = 2500;

  // getAssetLocation() async {
  //   AssetLocationData result =
  //       await _assetLocationService.getAssetLocationWithoutFilter(
  //           pageNumber, pageSize, '-lastlocationupdateutc');
  //   _assetLocation = result;
  //   _assetLocationloading = false;
  //   notifyListeners();
  // }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.FLEET) {
      _navigationService.navigateWithTransition(FleetView(),
          transition: "rightToLeft");
    }
  }

  void logout() {
    _localService.clearAll();
    _localStorageService.clearAll();
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(loginViewRoute);
    });
  }

  getAssetStatusData() async {
    AssetCount result =
        await _assetService.getAssetCount("assetstatus", FilterType.ALL_ASSETS);
    _assetStatusData = result;
    for (var stausData in _assetStatusData.countData) {
      statusChartData.add(ChartSampleData(
        x: stausData.countOf,
        y: stausData.count.round(),
      ));
    }
    _assetStatusloading = false;
    notifyListeners();
  }

  getFuelLevelData() async {
    AssetCount result = await _assetService.getFuellevel(FilterType.FUEL_LEVEL);
    if (result != null) {
      _fuelLevelData = result;
      for (var fuelData in _fuelLevelData.countData) {
        if (fuelData.countOf != "Not Reporting") {
          fuelChartData.add(
              ChartSampleData(x: fuelData.countOf, y: fuelData.count.round()));
        }
      }
    }
    _assetFuelloading = false;
    notifyListeners();
  }

  getIdlingLevelData() async {
    _isSwitching = true;
    AssetCount result =
        await _assetService.getIdlingLevelData(getStartRange(), endDayRange);
    if (result != null) {
      _idlingLevelData = result;
      _isSwitching = false;
    }
    _idlingLevelDataloading = false;
    notifyListeners();
  }

  onFilterSelected(FilterData data) async {
    Logger().d("onFilterSelected " + data.count);
    await addFilter(data);
    _navigationService.navigateWithTransition(FleetView(),
        transition: "rightToLeft");
  }

  gotoFleetPage() {
    _navigationService.navigateWithTransition(FleetView(),
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

  getStartRange() {
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
}
