import 'package:insite/core/locator.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class CumulativeViewModel extends BaseViewModel {
  Logger log;
  var _utilizationGraphService = locator<UtilizationGraphsService>();

  RunTimeCumulative _runTimeCumulative;
  RunTimeCumulative get runTimeCumulative => _runTimeCumulative;

  FuelBurnedCumulative _fuelBurnedCumulative;
  FuelBurnedCumulative get fuelBurnedCumulative => _fuelBurnedCumulative;

  bool _loading = true;
  bool get loading => _loading;

  CumulativeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getRunTimeCumulative();
    getFuelBurnedCumulative();
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

  getRunTimeCumulative() async {
    RunTimeCumulative result = await _utilizationGraphService
        .getRunTimeCumulative(_startDate, _endDate);
    _runTimeCumulative = result;
    _loading = false;
    notifyListeners();
  }

  getFuelBurnedCumulative() async {
    FuelBurnedCumulative result = await _utilizationGraphService
        .getFuelBurnedCumulative(_startDate, _endDate);
    _fuelBurnedCumulative = result;
    _loading = false;
    notifyListeners();
  }
}
