import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class FleetViewModel extends BaseViewModel {
  var _fleetService = locator<FleetService>();
  Logger log;

  int page = 1;

  List<Fleet> _assets = [];
  List<Fleet> get assets => _assets;

  bool _loading = true;
  bool get loading => _loading;

  FleetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _fleetService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getFleetSummaryList();
    });
  }

  inCreasePage(){
   page=page+1 ;
  }

  getFleetSummaryList() async {
    List<Fleet> result = await _fleetService.getFleetSummaryList();
    _assets = result;
    _loading = false;
    notifyListeners();
  }
}
