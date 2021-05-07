import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/services/asset_utilization_service.dart';

import 'package:insite/core/services/utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class UtilLizationViewModel extends BaseViewModel {
  Logger log;
  var _utilService = locator<AssetUtilService>();
  var _utilizationService = locator<AssetUtilizationService>();

  List<UtilizationData> _utilLizationList = [];
  List<UtilizationData> get utilLizationList => _utilLizationList;

  Utilization _utilization;
  Utilization get utilization => _utilization;

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

  bool _loading = true;
  bool get loading => _loading;

  UtilLizationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _utilService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getUtilization();
      getUtilList();
    });
  }

  getUtilList() async {
    var result = await _utilService.getUtilizationData();
    _utilLizationList = result;

    print('result:$result');

    _loading = false;
    notifyListeners();
  }

  getUtilization() async {
    Utilization result = await _utilizationService.getUtilizationResult(
        _startDate, _endDate, '-RuntimeHours');
    _utilization = result;
    _loading = false;
    notifyListeners();
  }
}
