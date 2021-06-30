import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationViewModel extends InsiteViewModel {
  Logger log;

  var _assetLocationService = locator<AssetLocationService>();
  var _navigationService = locator<NavigationService>();
  bool _loading = true;
  bool get loading => _loading;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  int pageNumber = 1;
  int pageSize = 2500;

  onFleetPageSelected() {
    _navigationService.navigateTo(
      fleetViewRoute,
    );
  }

  LocationViewModel(TYPE type) {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    setUp();
    if (type == TYPE.LOCATION) {
      Future.delayed(Duration(seconds: 1), () {
        getAssetLocation();
      });
    }
  }

  refresh() async {
    await getDateRangeFilterData();
    Logger().d("refresh getAssetLocation");
    _refreshing = true;
    notifyListeners();
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        pageNumber, pageSize, '-lastlocationupdateutc', appliedFilters);
    _assetLocation = result;
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  getAssetLocation() async {
    Logger().d("getAssetLocation");
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        pageNumber, pageSize, '-lastlocationupdateutc', appliedFilters);
    _assetLocation = result;
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }
}

enum TYPE { LOCATION, SEARCH }
