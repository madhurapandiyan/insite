import 'package:insite/core/locator.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class IdlePercentTrendViewModel extends BaseViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  bool _loading = true;
  bool get loading => _loading;

  String _startDate;
  String _endDate;

  IdlePercentTrend _idlePercentTrend;
  IdlePercentTrend get idlePercentTrend => _idlePercentTrend;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  IdlePercentTrendViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
    getIdlePercentTrend();
  }

  getIdlePercentTrend() async {
    IdlePercentTrend result = await _utilizationGraphService
        .getIdlePercentTrend(_range, _startDate, _endDate, 1, 25, true);
    _idlePercentTrend = result;
    _loading = false;
    notifyListeners();
  }

  updateDate(startDate, endDate) {
    _startDate = startDate;
    _endDate = endDate;
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    IdlePercentTrend result = await _utilizationGraphService
        .getIdlePercentTrend(_range, _startDate, _endDate, 1, 25, true);
    _idlePercentTrend = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
