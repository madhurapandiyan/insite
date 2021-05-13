import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class LocationViewModel extends BaseViewModel {
  Logger log;

  var _assetLocationService = locator<AssetLocationService>();

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

  LocationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    getAssetLocation();
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
}
