import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';
import 'package:insite/views/adminstration/add_group/add_group_view.dart';
import 'package:insite/views/adminstration/add_report/add_report_view.dart';
import 'package:insite/views/adminstration/addgeofense/addgeofense_view.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_view.dart';
import 'package:insite/views/adminstration/manage_group/manage_group_view.dart';
import 'package:insite/views/adminstration/manage_report/manage_report_view.dart';
import 'package:insite/views/adminstration/manage_user/manage_user_view.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/add_new_notifications_view.dart';
import 'package:insite/views/adminstration/notifications/manage_notifications/manage_notifications_view.dart';

import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminstrationViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();

  AdminstrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  onRespectiveButtonClicked(AdminAssetsButtonType value) {
    Logger().d("selectedValue:$value");
    if (value == AdminAssetsButtonType.ADDNEWUSER) {
      print("button is tapped");
      _navigationService!.navigateWithTransition(
          AddNewUserView(
            isEdit: false,
            user: null,
          ),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGEUSER) {
      _navigationService!
          .navigateWithTransition(ManageUserView(), transition: "fade");
    } else if (value == AdminAssetsButtonType.ADDNEWGEOFENCES) {
      _navigationService!
          .navigateWithTransition(AddgeofenseView(), transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGEGEOFENCES) {
      _navigationService!
          .navigateWithTransition(ManageGeofenceView(), transition: "fade");
    } else if (value == AdminAssetsButtonType.ADDNEWNOTIFICATION) {
      _navigationService!.navigateWithTransition(AddNewNotificationsView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGENOTIFICATION) {
      _navigationService!.navigateWithTransition(ManageNotificationsView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.ADDNEWGROUPS) {
      _navigationService!.navigateWithTransition(
          AddGroupView(
            isEdit: false,
            groups: null,
          ),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGEGROUPS) {
      _navigationService!
          .navigateWithTransition(ManageGroupView(), transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGEREPORTS) {
      _navigationService!
          .navigateWithTransition(ManageReportView(), transition: "fade");
    } else if (value == AdminAssetsButtonType.ADDNEWREPORT) {
      _navigationService!
          .navigateWithTransition(AddReportView(
            isEdit: false,
            scheduledReports: null,
          ), transition: "fade");
    }
  }

  onAssetSettingStateButtonClicked() {
    _navigationService!
        .navigateWithTransition(AssetSettingsView(), transition: "fade");
  }
}
