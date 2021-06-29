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
  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;
  String _startDate =
      '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}';
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  int pageNumber = 1;
  int pageSize = 2500;

  onFleetPageSelected(){
    _navigationService.navigateTo(fleetViewRoute,
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
  
  getAssetLocation() async {
    Logger().d("getAssetLocation");
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        pageNumber, pageSize, '-lastlocationupdateutc', appliedFilters);
    _assetLocation = result;
    _loading = false;
    notifyListeners();
  }
}

enum TYPE { LOCATION, SEARCH }
