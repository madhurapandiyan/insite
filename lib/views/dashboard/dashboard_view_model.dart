import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/views/asset_operation/asset_list_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/health/health_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/location/location_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends InsiteViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();
  var _loginService = locator<LoginService>();
  var _localService = locator<LocalService>();

  DashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 1), () {
      checkPermission();
    });
  }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.DASHBOARD) {
      _navigationService.navigateWithTransition(HomeView(), transition: "fade");
    } else if (type == ScreenType.FLEET) {
      _navigationService.navigateWithTransition(FleetView(),
          transition: "fade");
    } else if (type == ScreenType.ASSET_OPERATION) {
      _navigationService.navigateWithTransition(AssetListView(),
          transition: "fade");
    } else if (type == ScreenType.UTILIZATION) {
      _navigationService.navigateWithTransition(UtilLizationView(),
          transition: "fade");
    } else if (type == ScreenType.LOCATION) {
      _navigationService.navigateWithTransition(LocationView(),
          transition: "fade");
    } else {
      _navigationService.navigateWithTransition(HealthView(),
          transition: "fade");
    }
  }

  checkPermission() async {
    try {
      List<Permission> list = await _loginService.getPermissions();
      if (list.isNotEmpty) {
        _localService.setHasPermission(true);
      } else {
        youDontHavePermission = true;
        _localService.setHasPermission(false);
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
