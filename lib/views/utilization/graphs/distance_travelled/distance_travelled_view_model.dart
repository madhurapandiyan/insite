import 'package:insite/core/locator.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class DistanceTravelledViewModel extends BaseViewModel {
  Logger log;
  var _utilizationService = locator<AssetUtilizationService>();

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  int pageNumber = 1;
  int pageCount = 50;

  bool _loading = true;
  bool get loading => _loading;

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

  DistanceTravelledViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getUtilization();
  }

  getUtilization() async {
    Logger().d("getUtilization");

    Utilization result = await _utilizationService.getUtilizationResult(
        _startDate, _endDate, '-RuntimeHours', pageNumber, pageCount);
    if (result != null) {
      if (result.assetResults.isNotEmpty) {
        _utilLizationListData.addAll(result.assetResults);
        _loading = false;

        notifyListeners();
      } else {
        _utilLizationListData.addAll(result.assetResults);
        _loading = false;

        notifyListeners();
      }
    } else {
      _loading = false;

      notifyListeners();
    }
  }
}
