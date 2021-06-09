import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class FuelBurnRateTrendViewModel extends BaseViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  bool _loading = true;
  bool get loading => _loading;

  FuelBurnRateTrend _fuelBurnRateTrend;
  FuelBurnRateTrend get fuelBurnRateTrend => _fuelBurnRateTrend;

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

  FuelBurnRateTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getFuelBurnRateTrend();
  }

  getFuelBurnRateTrend() async {
    FuelBurnRateTrend result = await _utilizationGraphService
        .getFuelBurnRateTrend(_range, _startDate, _endDate, 1, 25, true);
    _fuelBurnRateTrend = result;
    _loading = false;
    notifyListeners();
  }
}
