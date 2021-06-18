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
    for (var locationData in _assetLocation.mapRecords) {
      markers.add(Marker(
          markerId: MarkerId('${markerId++}'),
          position: LatLng(locationData.lastReportedLocationLatitude,
              locationData.lastReportedLocationLongitude)));
    }
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
