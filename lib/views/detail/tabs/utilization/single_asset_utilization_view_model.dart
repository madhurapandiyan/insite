import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/services/single_asset_utilization_service.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationViewModel extends InsiteViewModel {
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

  SingleAssetUtilizationViewModel() {
    // this.log = getLogger(this.runtimeType.toString());
    _singleAssetUtilizationService.setUp();
    getSingleAssetUtilization();
  }

  getSingleAssetUtilization() async {
    print('@@@ Start');
    print('@@@ Start Date: $_startDate');
    print('@@@ End Date: $_endDate');
    SingleAssetUtilization result =
        await _singleAssetUtilizationService.getSingleAssetUtilizationResult(
            '64be6463-d8c1-11e7-80fc-065f15eda309',
            '-LastReportedUtilizationTime',
            _endDate,
            _startDate);
    _singleAssetUtilization = result;
    print('@@@ END RES: ${_singleAssetUtilization.toJson().toString()}');
    _loading = false;
    notifyListeners();
  }
}
