import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class LocationViewModel extends InsiteViewModel {
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

  int pageNumber = 1;
  int pageSize = 2500;

  LocationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    getAssetLocation();
  }

  getAssetLocation() async {
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        pageNumber, pageSize, '-lastlocationupdateutc', appliedFilters);
    _assetLocation = result;
    _loading = false;
    notifyListeners();
  }
}
