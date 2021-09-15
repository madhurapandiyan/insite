import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/core/services/utilization_graph_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class TotalFuelBurnedViewModel extends InsiteViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  TotalFuelBurned _totalFuelBurned;
  TotalFuelBurned get totalFuelBurned => _totalFuelBurned;

  bool _loading = true;
  bool get loading => _loading;

  bool _isSwitching = false;
  bool get isSwitching => _isSwitching;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  TotalFuelBurnedViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getTotalFuelBurned();
  }

  getTotalFuelBurned() async {
    _isSwitching = true;
    TotalFuelBurned result = await _utilizationGraphService.getTotalFuelBurned(
        _range, startDate, endDate, 1, 25, true);
    if (result == null || result.cumulatives == null)
      _totalFuelBurned = null;
    else
      _totalFuelBurned = result;
    _loading = false;
    _isSwitching = false;
    notifyListeners();
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    TotalFuelBurned result = await _utilizationGraphService.getTotalFuelBurned(
        _range, startDate, endDate, 1, 25, true);
    if (result.cumulatives == null)
      _totalFuelBurned = null;
    else
      _totalFuelBurned = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
