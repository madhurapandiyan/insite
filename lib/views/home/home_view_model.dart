import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/dashboard.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
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
import 'package:insite/views/utilization/tabs/list/utilization_list_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked_services/stacked_services.dart' as service;

class HomeViewModel extends InsiteViewModel {
  Logger? log;
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();
  LoginService? _loginService = locator<LoginService>();
  LocalService? _localService = locator<LocalService>();
  service.SnackbarService? showSnackBar = locator<service.SnackbarService>();
  bool? isLoggedIn;
  Customer? customer;
  bool? isTataHitachiAccount = false;
  bool isLoading = true;
  AppUpdateInfo? updateInfo;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  PackageInfo ?packageInfoData;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration.zero, () async {
      await checkForUpdate();
      customer = await _localService!.getAccountInfo();
      Logger().w(
          "Tata Hitachi Account Selected ${customer!.isTataHitachiSelected}");
      if (customer != null) if (customer!.CustomerUID ==
          "1857723c-ada1-11eb-8529-0242ac130003") {
        isTataHitachiAccount = true;
      }
      showsCategoryBasedOnAccountSelection(isTataHitachiAccount!);
      isLoading = false;
      notifyListeners();
    });
    // Future.delayed(Duration.zero, () async {
    //   var data = await _localService!.getTokenInfo();
    // });
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
          .navigateWithTransition(UtilizationListView(), transition: "fade");
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

  checkForUpdate() async {
    try {
      Logger().w("checking for update ....");
      Logger().e( "Update Available Version:-2."+" 1 ." +" " +"${updateInfo?.availableVersionCode.toString()}");

      var info = await InAppUpdate.checkForUpdate();
      var packageInfo=await PackageInfo.fromPlatform();
      packageInfoData=packageInfo;

      updateInfo = info;

      Logger().wtf(packageInfoData!.version);

      // if(packageInfoData!=null){
      //   Utils.removeVersionName(packageInfoData!.version.toString());
      // }

      if (updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {

        snackbarService?.showSnackbar(
            duration: Duration(seconds: 10),
            mainButtonTitle: "Update",
            onMainButtonTapped: updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                ? () {
                    InAppUpdate.startFlexibleUpdate()
                        .then((_) {})
                        .catchError((e) {
                      snackbarService?.showSnackbar(message: e.toString());
                    });
                  }
                : null,
            message:
                "Update Available Version:-${Utils.removeVersionName(packageInfoData!.version.toString())}");
      }

      // scaffoldKey.currentState!.showSnackBar(SnackBar(
      //     content: Row(
      //   children: [
      //     InsiteText(
      //       text:
      //           "Update Available Vesion:-${updateInfo?.availableVersionCode.toString()}",
      //     ),
      //     Row(
      //       children: [
      //         InsiteButton(
      //           title: "Cancel",
      //           bgColor: white.withOpacity(.5),
      //         ),
      //         InsiteButton(
      //           title: "Update",
      //           bgColor: white.withOpacity(.5),
      //           onTap: updateInfo?.updateAvailability ==
      //                   UpdateAvailability.updateAvailable
      //               ? () {
      //                   InAppUpdate.startFlexibleUpdate()
      //                       .then((_) {})
      //                       .catchError((e) {
      //                     snackbarService!.showSnackbar(message: e.toString());
      //                   });
      //                 }
      //               : null,
      //         ),
      //       ],
      //     )
      //   ],
      // )));
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
