import 'package:insite/core/locator.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class RuntimeHoursViewModel extends BaseViewModel {
  Logger log;

  var _utilizationService = locator<AssetUtilizationService>();

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  int pageNumber = 1;
  int pageCount = 50;

  bool _loading = true;
  bool get loading => _loading;

  String _startDate;

  String _endDate;

  RuntimeHoursViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
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
