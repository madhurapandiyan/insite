// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_intervals/add_intervals_view.dart' as view49;

import 'package:insite/views/adminstration/add_group/add_group_view.dart'
    as view37;
import 'package:insite/views/adminstration/add_report/add_report_view.dart'
    as view42;
import 'package:insite/views/adminstration/addgeofense/addgeofense_view.dart'
    as view15;
import 'package:insite/views/adminstration/adminstration_view.dart' as view13;
import 'package:insite/views/adminstration/asset_settings_configure/asset_settings_configure_view.dart'
    as view30;
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view.dart'
    as view16;
import 'package:insite/views/adminstration/manage_group/manage_group_view.dart'
    as view38;
import 'package:insite/views/adminstration/manage_report/manage_report_view.dart'
    as view43;
import 'package:insite/views/adminstration/manage_user/manage_user_view.dart'
    as view14;
import 'package:insite/views/adminstration/notifications/add_new_notifications/add_new_notifications_view.dart'
    as view39;
import 'package:insite/views/adminstration/notifications/manage_notifications/manage_notifications_view.dart'
    as view40;
import 'package:insite/views/detail/tabs/maintenance_tab/maintenance_tab_view.dart'
    as view48;
import 'package:insite/views/maintenance/asset/asset/detail_popup/detail_popup_view.dart'
    as view47;
import 'package:insite/views/maintenance/asset/asset_view.dart' as view45;
import 'package:insite/views/maintenance/main/main_detail_popup/main_detail_popup_view.dart'
    as view46;
import 'package:insite/views/maintenance/main/main_view.dart' as view46;
import 'package:insite/views/maintenance/maintenance_view.dart' as view44;
import 'package:insite/views/manage_account/manage_account_view.dart';
import 'package:insite/views/notification/notification_view.dart' as view37;

import 'package:insite/views/plant/dashboard/plant_dashboard_view.dart'
    as view25;
import 'package:insite/views/plant/plant_asset_creation/plant_asset_creation_view.dart'
    as view31;
import 'package:insite/views/preference/preference_view.dart' as view50;
import 'package:insite/views/splash/splash_view.dart' as view0;
import 'package:insite/views/account_selection/account_selection_view.dart'
    as view1;
import 'package:insite/views/adminstration/manage_user/manage_user_view.dart'
    as view15;
import 'package:insite/views/asset_operation/asset_operation_view.dart'
    as view8;

import 'package:insite/views/plant/plant_view.dart' as view24;

import 'package:insite/views/home/home_view.dart' as view2;
import 'package:insite/views/fleet/fleet_view.dart' as view3;
import 'package:insite/views/login/login_view.dart' as view4;
import 'package:insite/views/logout/logout_view.dart' as view5;
import 'package:insite/views/global_search/global_search_view.dart' as view6;
import 'package:insite/views/dashboard/dashboard_view.dart' as view7;

import 'package:insite/views/detail/asset_detail_view.dart' as view9;
import 'package:insite/views/location/location_view.dart' as view10;
import 'package:insite/views/health/health_view.dart' as view11;
import 'package:insite/views/login/login_page.dart' as view12;

import 'package:insite/views/add_new_user/add_new_user_view.dart' as view14;
import 'package:insite/views/subscription/options/sub_dash_board_details/subscription_dashboard_details_view.dart'
    as view18;
import 'package:insite/views/subscription/options/sub_registration/multiple_asset_reg/multiple_asset_registration_view.dart'
    as view22;
import 'package:insite/views/subscription/options/sub_registration/multiple_asset_transfer/multiple_asset_transfer_view.dart'
    as view23;
import 'package:insite/views/subscription/options/sub_registration/reusable_autocomplete_search/reusable_autocomplete_search_view.dart'
    as view34;
import 'package:insite/views/subscription/options/sub_registration/single_asset_reg/single_asset_registration_view.dart'
    as view20;
import 'package:insite/views/subscription/options/sub_registration/single_asset_transfer/single_asset_transfer_view.dart'
    as view21;
import 'package:insite/views/subscription/options/sub_registration/sub_registration_view.dart'
    as view19;

import 'package:insite/views/subscription/options/view_dashboard/subscription_dashboard_view.dart'
    as view17;
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_view.dart'
    as view32;
import 'package:insite/views/subscription/replacement/device_replacement_status/device_replacement_status_view.dart'
    as view31;
import 'package:insite/views/subscription/replacement/replacement_view.dart'
    as view33;
import 'package:insite/views/subscription/sms-management/report_summary/report_summary_view.dart'
    as view29;
import 'package:insite/views/subscription/sms-management/sms-multi_asset/sms_schedule_multi_asset_view.dart'
    as view28;
import 'package:insite/views/subscription/sms-management/sms-single_asset/sms_schedule_single_asset_view.dart'
    as view27;
import 'package:insite/views/subscription/sms-management/sms_management_view.dart'
    as view26;
import 'package:insite/views/subscription/subscription_view.dart' as view16;

import 'package:insite/views/subscription/fleetstatus/fleet_status_view.dart'
    as view35;
import 'package:insite/views/subscription/transferhistory/transfer_history_view.dart'
    as view36;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case customerSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => view1.AccountSelectionView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view2.HomeView());
      case fleetViewRoute:
        return MaterialPageRoute(builder: (_) => view3.FleetView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view4.LoginView());
      case logoutViewRoute:
        return MaterialPageRoute(builder: (_) => view5.LogoutView());
      case globalSearchViewRoute:
        return MaterialPageRoute(builder: (_) => view6.GlobalSearchView());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view7.DashboardView());
      case assetViewRoute:
        return MaterialPageRoute(builder: (_) => view8.AssetOperationView());
      case assetDetailViewRoute:
        var fleetArgs = settings.arguments as view9.DetailArguments;
        return MaterialPageRoute(
            builder: (_) => view9.AssetDetailView(
                  fleet: fleetArgs.fleet,
                  tabIndex: fleetArgs.index,
                  type: fleetArgs.type,
                ));

      case locationViewRoute:
        return MaterialPageRoute(builder: (_) => view10.LocationView());
      case healthViewRoute:
        return MaterialPageRoute(builder: (_) => view11.HealthView());
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => view12.LoginPage());
      case administrationViewPageRoute:
        return MaterialPageRoute(builder: (_) => view13.AdminstrationView());
      case manageUserViewRoute:
        return MaterialPageRoute(builder: (_) => view14.ManageUserView());
      case addgeofenseViewRoute:
        return MaterialPageRoute(builder: (_) => view15.AddgeofenseView());
      case manageGeofenceViewRoute:
        return MaterialPageRoute(builder: (_) => view16.ManageGeofenceView());
      case addNewUserViewRoute:
        return MaterialPageRoute(builder: (_) => view14.AddNewUserView());
      case manageUserViewRoute:
        return MaterialPageRoute(builder: (_) => view15.ManageUserView());
      case subscriptionViewRoute:
        return MaterialPageRoute(builder: (_) => view16.SubscriptionView());
      case viewDashboardViewRoute:
        return MaterialPageRoute(
            builder: (_) => view17.SubscriptionDashboardView());
      case subDashBoardDetailsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view18.SubDashBoardDetailsView());
      case subRegistrationViewRoute:
        return MaterialPageRoute(builder: (_) => view19.SubRegistrationView());
      case singleAssetRegViewRoute:
        return MaterialPageRoute(
          builder: (_) => view20.SingleAssetRegistrationView(
              filterKey: "total",
              filterType: PLANTSUBSCRIPTIONFILTERTYPE.STATUS),
        );
      case singleAssetTransferViewRoute:
        return MaterialPageRoute(
            builder: (_) => view21.SingleAssetTransferView());
      case multipleAssetRegViewRoute:
        return MaterialPageRoute(
            builder: (_) => view22.MultipleAssetRegistrationView());
      case multipleAssetTransferViewRoute:
        return MaterialPageRoute(
            builder: (_) => view23.MultipleAssetTransferView());
      case plantViewRoute:
        return MaterialPageRoute(builder: (_) => view24.PlantView());
      case plantDashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view25.PlantDashboardView());
      case smsManagementViewRoute:
        return MaterialPageRoute(builder: (_) => view26.SmsManagementView());
      case smsScheduleSingleAssetViewRoute:
        return MaterialPageRoute(
            builder: (_) => view27.SmsScheduleSingleAssetView());
      case smsScheduleMultiAssetViewRoute:
        return MaterialPageRoute(
            builder: (_) => view28.SmsScheduleMultiAssetView());
      case reportSummaryViewRoute:
        return MaterialPageRoute(builder: (_) => view29.ReportSummaryView());
      case assetSettingsConfigureViewRoute:
        return MaterialPageRoute(
            builder: (_) => view30.AssetSettingsConfigureView());
      case reusableAutocompleteSearchViewRoute:
        return MaterialPageRoute(
            builder: (_) => view34.ReusableAutocompleteSearchView());
      case deviceReplacementStatusView:
        return MaterialPageRoute(
            builder: (_) => view31.DeviceReplacementStatusView());
      case deviceReplacementView:
        return MaterialPageRoute(
            builder: (_) => view32.DeviceReplacementView());
      case replacementView:
        return MaterialPageRoute(builder: (_) => view33.ReplacementView());
      case fleetStatusView:
        return MaterialPageRoute(builder: (_) => view35.FleetStatusView());
      case transferHistoryView:
        return MaterialPageRoute(builder: (_) => view36.TransferHistoryView());
      case plantAssetCreationViewRoute:
        return MaterialPageRoute(
            builder: (_) => view31.PlantAssetCreationView());
      case notificationViewRoute:
        return MaterialPageRoute(builder: (_) => view37.NotificationView());
      case addGroupViewRoute:
        return MaterialPageRoute(builder: (_) => view37.AddGroupView());
      case manageGroupViewRoute:
        return MaterialPageRoute(builder: (_) => view38.ManageGroupView());
      case addNewNotificationsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view39.AddNewNotificationsView());
      case manageNotificationsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view40.ManageNotificationsView());
      case addReportViewRoute:
        return MaterialPageRoute(builder: (_) => view42.AddReportView());
      case manageReportViewRoute:
        return MaterialPageRoute(builder: (_) => view43.ManageReportView());
      case maintenanceViewRoute:
        return MaterialPageRoute(builder: (_) => view44.MaintenanceView());
      case assetViewRoute0:
        return MaterialPageRoute(builder: (_) => view45.AssetMaintenanceView());
      case mainViewRoute:
        return MaterialPageRoute(builder: (_) => view46.MainView());
      case detailPopupViewRoute:
        return MaterialPageRoute(builder: (_) => view47.DetailPopupView());

      case mainDetailPopupViewRoute:
        return MaterialPageRoute(builder: (_) => view46.MainDetailPopupView());

      case maintenanceTabViewRoute:
        return MaterialPageRoute(builder: (_) => view48.MaintenanceTabView());
      case addIntervalsViewRoute:
        return MaterialPageRoute(builder: (_) => view49.AddIntervalsView());
      case preferenceViewRoute:
        return MaterialPageRoute(builder: (_) => view50.PreferencesView());
      case manageAccountViewRoute:
        return MaterialPageRoute(builder: (_) => ManageAccountView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
