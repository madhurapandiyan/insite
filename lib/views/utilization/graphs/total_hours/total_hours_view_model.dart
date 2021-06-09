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

  TotalHoursViewModel() {
    this.log = getLogger(this.runtimeType.toString());
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
