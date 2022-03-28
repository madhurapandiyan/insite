import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/permission.dart';
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
    Future.delayed(Duration.zero, () async {
      var data = (await _localService!.getLoggedInUser())!.sub;
      print(data);
    });

    // _localService?.saveToken(
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjQ4MTEyOTMxLCJuYmYiOjE2NDgxMDkzMzEsImlhdCI6MTY0ODEwOTMzMSwianRpIjoiZTFmYzI5M2UyZDNhNDU5NGJjODgxNTljYmM4YjJkZGEiLCJqd3RfdmVyIjoyLCJzdWIiOiIyMTgxODg1Ny01MTU1LTRjNmYtYTc0YS01NzRkYmU3NDE2NzUiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2NDgxMDU0NDMsImF6cCI6IjBmYzcyYTcxLWU0ZTUtNGFjMS05YzdiLWU5NjYwNTAxNTRjOSIsImF1ZCI6WyIwZmM3MmE3MS1lNGU1LTRhYzEtOWM3Yi1lOTY2MDUwMTU0YzkiXSwic2NvcGUiOiJGcmFtZS1BZG1pbmlzdHJhdG9yLUlORCJ9.Rr8Am6r1BvpJQ5uEBE0aY1ZaTuWeJL46YvqT8rpS9w0MAPRt16YMb-NXlbzlWrwHVXcOjmfYXR1bt1uDMVdMusKRcJjqxASCvCFdTEiMbu7A0FUcqRSUC7jj3CF60ocHZLv6hjoBiB_dkRGuqDWpmXlIXAh3tgaRW5AOZtM8Azy0vDDaKzz1EbX6jOnbGmA3o07hNNN2U9_rZgsW_puZgQ-pAOr8nYxYiix1qAQf3Ovrw8mP5clPWsOHzW-is_H4EJ46UI2dmQ3wfrVj40NdFJ8-TX9T5tZHWJSEa8C5hkHg12YK3S3Y5aoEGINPSPdM0YJX-DnlvMkWjH7FE06gWA");
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
