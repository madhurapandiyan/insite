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

  TotalFuelBurned _totalFuelBurned;
  TotalFuelBurned get totalFuelBurned => _totalFuelBurned;

  bool _loading = true;
  bool get loading => _loading;

  TotalFuelBurnedViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getTotalFuelBurned();
  }

  getTotalFuelBurned() async {
    TotalFuelBurned result = await _utilizationGraphService.getTotalFuelBurned(
        _range, _startDate, _endDate, 1, 25, true);
    _totalFuelBurned = result;
    _loading = false;
    notifyListeners();
  }
}
