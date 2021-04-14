import 'package:insite/core/locator.dart';
import 'package:insite/views/asset/asset_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends BaseViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();

  DashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.FLEET) {
      _navigationService.navigateWithTransition(FleetView(),
          transition: "fade");
    } else if (type == ScreenType.ASSET_OPERATION) {
      _navigationService.navigateWithTransition(AssetView(),
          transition: "fade");
    }
  }
}
