import 'package:insite/core/locator.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/views/asset_operation/asset_list_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends BaseViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();
  var _loginService = locator<LoginService>();
  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;
  var _localService = locator<LocalService>();

  DashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 3), () {
      checkPermission();
    });
  }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.FLEET) {
      _navigationService.navigateWithTransition(FleetView(),
          transition: "fade");
    } else if (type == ScreenType.ASSET_OPERATION) {
      _navigationService.navigateWithTransition(AssetListView(),
          transition: "fade");
    } else if (type == ScreenType.UTILIZATION) {
      _navigationService.navigateWithTransition(UtilLizationView(),
          transition: "fade");
    }
  }

  checkPermission() async {
    try {
      List<Permission> list = await _loginService.getPermissions();
      if (list.isNotEmpty) {
        _localService.setHasPermission(true);
      } else {
        _youDontHavePermission = true;
        _localService.setHasPermission(false);
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
