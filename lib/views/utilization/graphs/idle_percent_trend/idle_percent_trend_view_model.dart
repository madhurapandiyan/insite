import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class IdlePercentTrendViewModel extends InsiteViewModel {
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

  IdlePercentTrend _idlePercentTrend;
  IdlePercentTrend get idlePercentTrend => _idlePercentTrend;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  IdlePercentTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getIdlePercentTrend();
  }

  getIdlePercentTrend() async {
    _isSwitching = true;
    IdlePercentTrend result = await _utilizationGraphService
        .getIdlePercentTrend(_range, startDate, endDate, 1, 25, true);
    if (result.cumulatives == null)
      _idlePercentTrend = null;
    else
      _idlePercentTrend = result;
    _loading = false;
    _isSwitching = false;
    notifyListeners();
  }

  updateDate(startDate, endDate) {
    startDate = startDate;
    endDate = endDate;
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    await getDateRangeFilterData();
    IdlePercentTrend result = await _utilizationGraphService
        .getIdlePercentTrend(_range, startDate, endDate, 1, 25, true);
    if (result.cumulatives == null)
      _idlePercentTrend = null;
    else
      _idlePercentTrend = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
