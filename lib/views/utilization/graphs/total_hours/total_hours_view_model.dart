import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class TotalHoursViewModel extends InsiteViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  bool _loading = true;
  bool get loading => _loading;

  bool _isSwitching = false;
  bool get isSwitching => _isSwitching;

  TotalHours _totalHours;
  TotalHours get totalHours => _totalHours;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  TotalHoursViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getTotalHours();
  }

  getTotalHours() async {
    _isSwitching = true;
    TotalHours result = await _utilizationGraphService.getTotalHours(
        _range, startDate, endDate, 1, 25, true);
    if (result == null || result.cumulatives == null)
      _totalHours = null;
    else
      _totalHours = result;
    _loading = false;
    _isSwitching = false;
    notifyListeners();
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    TotalHours result = await _utilizationGraphService.getTotalHours(
        _range, startDate, endDate, 1, 25, true);
    if (result == null || result.cumulatives == null)
      _totalHours = null;
    else
      _totalHours = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
