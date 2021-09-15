import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/core/services/utilization_graph_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class FuelBurnRateTrendViewModel extends InsiteViewModel {
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

  FuelBurnRateTrend _fuelBurnRateTrend;
  FuelBurnRateTrend get fuelBurnRateTrend => _fuelBurnRateTrend;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FuelBurnRateTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getFuelBurnRateTrend();
  }

  getFuelBurnRateTrend() async {
    _isSwitching = true;
    FuelBurnRateTrend result = await _utilizationGraphService
        .getFuelBurnRateTrend(_range, startDate, endDate, 1, 25, true);
    if (result == null || result.cumulatives == null)
      _fuelBurnRateTrend = null;
    else
      _fuelBurnRateTrend = result;
    _loading = false;
    _isSwitching = false;
    notifyListeners();
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    FuelBurnRateTrend result = await _utilizationGraphService
        .getFuelBurnRateTrend(_range, startDate, endDate, 1, 25, true);
    if (result == null || result.cumulatives == null)
      _fuelBurnRateTrend = null;
    else
      _fuelBurnRateTrend = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
