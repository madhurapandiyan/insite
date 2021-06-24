import 'package:insite/core/locator.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TotalFuelBurnedViewModel extends BaseViewModel {
  Logger log;

  var _utilizationGraphService = locator<UtilizationGraphsService>();

  String _range = 'daily';
  set range(String range) {
    this._range = range;
  }

  String _startDate;
  String _endDate;

  TotalFuelBurned _totalFuelBurned;
  TotalFuelBurned get totalFuelBurned => _totalFuelBurned;

  bool _loading = true;
  bool get loading => _loading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  TotalFuelBurnedViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
    getTotalFuelBurned();
  }

  getTotalFuelBurned() async {
    TotalFuelBurned result = await _utilizationGraphService.getTotalFuelBurned(
        _range, _startDate, _endDate, 1, 25, true);
    _totalFuelBurned = result;
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
    TotalFuelBurned result = await _utilizationGraphService.getTotalFuelBurned(
        _range, _startDate, _endDate, 1, 25, true);
    _totalFuelBurned = result;
    _isRefreshing = false;
    notifyListeners();
  }
}
