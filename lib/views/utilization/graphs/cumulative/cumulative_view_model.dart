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

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  CumulativeViewModel(String startDate, String endDate) {
    this.log = getLogger(this.runtimeType.toString());
    _utilizationGraphService.setUp();
    _startDate = startDate;
    _endDate = endDate;
    Future.delayed(Duration(seconds: 1), () {
      getRunTimeCumulative();
      getFuelBurnedCumulative();
    });
  }

  String _startDate;
  String _endDate;

  getRunTimeCumulative() async {
    RunTimeCumulative result = await _utilizationGraphService
        .getRunTimeCumulative(_startDate, _endDate);
    _runTimeCumulative = result;
  }

  getFuelBurnedCumulative() async {
    FuelBurnedCumulative result = await _utilizationGraphService
        .getFuelBurnedCumulative(_startDate, _endDate);
    _fuelBurnedCumulative = result;
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
    RunTimeCumulative resultRuntime = await _utilizationGraphService
        .getRunTimeCumulative(_startDate, _endDate);
    _runTimeCumulative = resultRuntime;
    FuelBurnedCumulative resultFuel = await _utilizationGraphService
        .getFuelBurnedCumulative(_startDate, _endDate);
    _fuelBurnedCumulative = resultFuel;
    _isRefreshing = false;
    notifyListeners();
  }
}
