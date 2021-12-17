import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/services/utilization_graph_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class CumulativeViewModel extends InsiteViewModel {
  Logger? log;
  UtilizationGraphsService? _utilizationGraphService = locator<UtilizationGraphsService>();

  RunTimeCumulative? _runTimeCumulative;
  RunTimeCumulative? get runTimeCumulative => _runTimeCumulative;

  FuelBurnedCumulative? _fuelBurnedCumulative;
  FuelBurnedCumulative? get fuelBurnedCumulative => _fuelBurnedCumulative;

  bool _loading = true;
  bool get loading => _loading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  CumulativeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _utilizationGraphService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getRunTimeCumulative();
      getFuelBurnedCumulative();
    });
  }

  getRunTimeCumulative() async {
    RunTimeCumulative? result =
        await (_utilizationGraphService!.getRunTimeCumulative(startDate, endDate));
    if (result!.cumulatives == null)
      _runTimeCumulative = null;
    else
      _runTimeCumulative = result;
    _loading = false;
    notifyListeners();
  }

  getFuelBurnedCumulative() async {
    FuelBurnedCumulative? result = await (_utilizationGraphService!
        .getFuelBurnedCumulative(startDate, endDate) );
    if (result!.cumulatives == null)
      _fuelBurnedCumulative = null;
    else
      _fuelBurnedCumulative = result;
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    _isRefreshing = true;
    notifyListeners();
    RunTimeCumulative resultRuntime =
        await (_utilizationGraphService!.getRunTimeCumulative(startDate, endDate) as Future<RunTimeCumulative>);
    if (resultRuntime.cumulatives == null)
      _runTimeCumulative = null;
    else
      _runTimeCumulative = resultRuntime;
    FuelBurnedCumulative resultFuel = await (_utilizationGraphService!
        .getFuelBurnedCumulative(startDate, endDate) as Future<FuelBurnedCumulative>);
    if (resultFuel.cumulatives == null)
      _fuelBurnedCumulative = null;
    else
      _fuelBurnedCumulative = resultFuel;
    _isRefreshing = false;
    notifyListeners();
  }
}
