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

  CumulativeViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _startDate = startDate;
    _endDate = endDate;
    getRunTimeCumulative();
    getFuelBurnedCumulative();
  }

  String _startDate;

  String _endDate;

  getRunTimeCumulative() async {
    _loading = true;
    RunTimeCumulative result = await _utilizationGraphService
        .getRunTimeCumulative(_startDate, _endDate);
    _runTimeCumulative = result;
    _loading = false;
    notifyListeners();
  }

  getFuelBurnedCumulative() async {
    _loading = true;
    FuelBurnedCumulative result = await _utilizationGraphService
        .getFuelBurnedCumulative(_startDate, _endDate);
    _fuelBurnedCumulative = result;
    _loading = false;
    notifyListeners();
  }
}
