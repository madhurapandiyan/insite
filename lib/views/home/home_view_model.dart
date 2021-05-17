import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
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
  Logger log;
  AssetStatusData _assetStatusData;
  AssetStatusData get assetStatusData => _assetStatusData;
  bool _loading = true;
  bool get loading => _loading;

  ScreenType _currentScreenType;
  ScreenType get currentScreenType => _currentScreenType;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setup();
    _assetLocationService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetStatusData();
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
    print(
        '@@@ Init LATLNG: ${_assetLocation.mapRecords[0].lastReportedLocationLatitude}, ${_assetLocation.mapRecords[0].lastReportedLocationLongitude}');
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
    print('result: ${result.countData[0].count}');
    _loading = false;
    notifyListeners();
  }
}
