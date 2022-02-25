import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/adminstration_view.dart';
import 'package:insite/views/asset_operation/asset_operation_view.dart';
import 'package:insite/views/dashboard/dashboard_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/health/health_view.dart';
import 'package:insite/views/location/location_view.dart';
import 'package:insite/views/maintenance/maintenance_view.dart';
import 'package:insite/views/notification/notification_view.dart';
import 'package:insite/views/plant/plant_view.dart';
import 'package:insite/views/subscription/subscription_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart' as service;

class HomeViewModel extends InsiteViewModel {
  Logger? log;
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();
  LoginService? _loginService = locator<LoginService>();
  LocalService? _localService = locator<LocalService>();
  bool? isLoggedIn;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  openRespectivePage(ScreenType type) {
    if (type == ScreenType.DASHBOARD) {
      _navigationService!
          .navigateWithTransition(DashboardView(), transition: "fade");
    } else if (type == ScreenType.FLEET) {
      _navigationService!
          .navigateWithTransition(FleetView(), transition: "fade");
    } else if (type == ScreenType.ASSET_OPERATION) {
      _navigationService!
          .navigateWithTransition(AssetOperationView(), transition: "fade");
    } else if (type == ScreenType.UTILIZATION) {
      _navigationService!
          .navigateWithTransition(UtilLizationView(), transition: "fade");
    } else if (type == ScreenType.LOCATION) {
      _navigationService!
          .navigateWithTransition(LocationView(), transition: "fade");
    } else if (type == ScreenType.HEALTH) {
      _navigationService!
          .navigateWithTransition(HealthView(), transition: "fade");
    } else if (type == ScreenType.ADMINISTRATION) {
      _navigationService!
          .navigateWithTransition(AdminstrationView(), transition: "fade");
    } else if (type == ScreenType.SUBSCRIPTION) {
      _navigationService!
          .navigateWithTransition(SubscriptionView(), transition: "fade");
    } else if (type == ScreenType.PLANT) {
      _navigationService!
          .navigateWithTransition(PlantView(), transition: "fade");
    } else if (type == ScreenType.NOTIFICATIONS) {
      _navigationService!
          .navigateWithTransition(NotificationView(), transition: "fade");
    } else if (type == ScreenType.MAINTENANCE) {
      _navigationService!
          .navigateWithTransition(MaintenanceView(), transition: "fade");
    }
  }

  checkPermission() async {
    try {
      List<Permission>? list = await _loginService!.getPermissions();
      if (list!.isNotEmpty) {
        _localService!.setHasPermission(true);
      } else {
        youDontHavePermission = true;
        _localService!.setHasPermission(false);
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
