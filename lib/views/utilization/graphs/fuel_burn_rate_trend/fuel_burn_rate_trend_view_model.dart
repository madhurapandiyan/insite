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

  String _startDate;
  String _endDate;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FuelBurnRateTrendViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
    getFuelBurnRateTrend();
  }

  getFuelBurnRateTrend() async {
    FuelBurnRateTrend result = await _utilizationGraphService
        .getFuelBurnRateTrend(_range, _startDate, _endDate, 1, 25, true);
    _fuelBurnRateTrend = result;
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
    FuelBurnRateTrend result = await _utilizationGraphService
        .getFuelBurnRateTrend(_range, _startDate, _endDate, 1, 25, true);
    _fuelBurnRateTrend = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
