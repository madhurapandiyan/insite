import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/fuel_level_service.dart';
import 'package:insite/core/services/idling_level_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_view.dart';

class HomeViewModel extends InsiteViewModel {
  var _localService = locator<LocalService>();
  var _navigationService = locator<NavigationService>();
  var _assetService = locator<AssetStatusService>();
  var _assetLocationService = locator<AssetLocationService>();
  var _fuelLevelService = locator<FuelLevelService>();
  var _idlingLevelService = locator<IdlingLevelService>();

  Logger log;

  bool _assetStatusloading = true;
  bool get assetStatusloading => _assetStatusloading;

  bool _assetFuelloading = true;
  bool get assetFuelloading => _assetFuelloading;

  bool _idlingLevelDataloading = true;
  bool get idlingLevelDataloading => _idlingLevelDataloading;

  bool _assetLocationloading = true;
  bool get assetLocationloading => _assetLocationloading;

  AssetCountData _assetStatusData;
  AssetCountData get assetStatusData => _assetStatusData;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  AssetCountData _fuelLevelData;
  AssetCountData get fuelLevelData => _fuelLevelData;

  AssetCountData _idlingLevelData;
  AssetCountData get idlingLevelData => _idlingLevelData;

  Set<Marker> markers = {};
  int markerId = 1;
  List<ChartSampleData> statusChartData = [];
  List<ChartSampleData> fuelChartData = [];

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setUp();
    _assetLocationService.setUp();
    _fuelLevelService.setUp();
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetStatusData();
      getFuelLevelData();
      getIdlingLevelData();
      getAssetLocation();
    });
  }

  void updateState(newState) {
    notifyListeners();
  }

  int pageNumber = 1;
  int pageSize = 2500;

  getAssetLocation() async {
    AssetLocationData result =
        await _assetLocationService.getAssetLocationWithoutFilter(
            pageNumber, pageSize, '-lastlocationupdateutc');
    _assetLocation = result;

    _assetLocationloading = false;
    notifyListeners();
  }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.FLEET) {
      _navigationService.navigateWithTransition(FleetView(),
          transition: "rightToLeft");
    }
  }

  void logout() {
    _localService.clearAll();
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(loginViewRoute);
    });
  }

  getAssetStatusData() async {
    AssetCountData result = await _assetService.getAssetStatus();
    _assetStatusData = result;
    for (var stausData in _assetStatusData.countData) {
      statusChartData.add(ChartSampleData(
        x: stausData.countOf,
        y: stausData.count.roundToDouble(),
      ));
    }
    _assetStatusloading = false;
    notifyListeners();
  }

  getFuelLevelData() async {
    AssetCountData result = await _fuelLevelService.getFuellevel();
    _fuelLevelData = result;
    for (var fuelData in _fuelLevelData.countData) {
      if (fuelData.countOf != "Not Reporting") {
        fuelChartData.add(ChartSampleData(
            x: fuelData.countOf, y: fuelData.count.roundToDouble()));
      }
    }
    _assetFuelloading = false;
    notifyListeners();
  }

  getIdlingLevelData() async {
    AssetCountData result =
        await _idlingLevelService.getIdlingLevel(startDate, endDate);
    _idlingLevelData = result;
    _idlingLevelDataloading = false;
    notifyListeners();
  }

  onFilterSelected(FilterData data) {
    Logger().d("onFilterSelected " + data.count);
    addFilter(data);
    _navigationService.navigateWithTransition(FleetView(),
        transition: "rightToLeft");
  }
}
