import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class FleetViewModel extends InsiteViewModel {
  var _fleetService = locator<FleetService>();
  var _navigationService = locator<NavigationService>();

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

  inCreasePage() {
    page = page + 1;
  }

  getFleetSummaryList() async {
    List<Fleet> result = await _fleetService.getFleetSummaryList();
    _assets = result;
    _loading = false;
    notifyListeners();
  }

  onDetailPageSelected(Fleet fleet) {
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(fleet: fleet));
  }

  onHomeSelected() {
    _navigationService.replaceWith(dashboardViewRoute);
  }
}
