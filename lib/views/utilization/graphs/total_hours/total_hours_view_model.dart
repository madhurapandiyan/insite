import 'package:insite/core/locator.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TotalHoursViewModel extends BaseViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  bool _loading = true;
  bool get loading => _loading;

  TotalHours _totalHours;
  TotalHours get totalHours => _totalHours;

  String _startDate;

  String _endDate;

  TotalHoursViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
    getTotalHours();
  }

  getTotalHours() async {
    TotalHours result = await _utilizationGraphService.getTotalHours(
        _range, _startDate, _endDate, 1, 25, true);
    _totalHours = result;
    _loading = false;
    notifyListeners();
  }
}
