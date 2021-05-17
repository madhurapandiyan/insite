import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fuel_level.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/fuel_level_service.dart';
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
  Logger log;
  AssetStatusData _assetStatusData;
  AssetStatusData get assetStatusData => _assetStatusData;
  bool _loading = true;
  bool get loading => _loading;

  ScreenType _currentScreenType;
  ScreenType get currentScreenType => _currentScreenType;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  FuelLevelData _fuelLevelData;
  FuelLevelData get fuelLevelData => _fuelLevelData;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setup();
    _assetLocationService.setUp();
    _fuelLevelService.setup();
    Future.delayed(Duration(seconds: 1), () {
      getAssetStatusData();
      getFuelLevelData();
    });
    _currentScreenType = ScreenType.ACCOUNT;
    checkAccountSelected();
    getAssetLocation();
  }

  checkAccountSelected() async {
    try {
      Customer account = await _localService.getAccountInfo();
      Customer subAccount = await _localService.getCustomerInfo();
      if (account != null) {
        Logger().i("account selected already " + account.DisplayName);
        _currentScreenType = ScreenType.HOME;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void updateState(newState) {
    _currentScreenType = newState;
    notifyListeners();
  }

  getAssetLocation() async {
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        1, 2500, '-lastlocationupdateutc');
    _assetLocation = result;
    _loading = false;
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
    AssetStatusData result = await _assetService.getassetStatus();
    _assetStatusData = result;
    _loading = false;
    notifyListeners();
  }

  getFuelLevelData() async {
    FuelLevelData result = await _fuelLevelService.getfuelLevel();
    _fuelLevelData = result;
    print('resul:${result.countData[0].count}');
    _loading = false;
    notifyListeners();
  }
}
