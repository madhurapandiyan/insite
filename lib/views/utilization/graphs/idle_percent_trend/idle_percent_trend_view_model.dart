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

  String _startDate =
      '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}';
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  IdlePercentTrend _idlePercentTrend;
  IdlePercentTrend get idlePercentTrend => _idlePercentTrend;

  String _endDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  IdlePercentTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getIdlePercentTrend();
  }

  getIdlePercentTrend() async {
    IdlePercentTrend result = await _utilizationGraphService
        .getIdlePercentTrend(_range, _startDate, _endDate, 1, 25, true);
    _idlePercentTrend = result;
    _loading = false;
    notifyListeners();
  }
}
