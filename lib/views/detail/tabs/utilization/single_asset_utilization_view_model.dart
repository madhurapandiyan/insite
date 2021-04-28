import 'package:insite/core/locator.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/services/single_asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationViewModel extends BaseViewModel {
  Logger log;
  var _singleAssetUtilizationService = locator<SingleAssetUtilizationService>();

  SingleAssetUtilization _singleAssetUtilization;
  SingleAssetUtilization get singleAssetUtilization => _singleAssetUtilization;

  bool _loading = true;
  bool get loading => _loading;

  String _assetUID = '';
  set assetUID(String assetUID) {
    this._assetUID = assetUID;
  }

  String _startDate = '';
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate = '';
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  SingleAssetUtilizationViewModel() {
    // this.log = getLogger(this.runtimeType.toString());
    _singleAssetUtilizationService.setUp();
  }

  getSingleAssetUtilization() async {
    SingleAssetUtilization result =
        await _singleAssetUtilizationService.getSingleAssetUtilizationResult(
            '64be6463-d8c1-11e7-80fc-065f15eda309', _endDate, _startDate);
    _singleAssetUtilization = result;
    print('@@@ END RES: ${_singleAssetUtilization.toJson().toString()}');
    _loading = false;
    notifyListeners();
  }
}
