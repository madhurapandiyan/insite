// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';

import 'package:insite/views/splash/splash_view.dart' as view0;
import 'package:insite/views/customer_selection/customer_selection_view.dart' as view1;
import 'package:insite/views/home/home_view.dart' as view2;
import 'package:insite/views/fleet/fleet_view.dart' as view3;
import 'package:insite/views/login/login_view.dart' as view4;
import 'package:insite/views/logout/logout_view.dart' as view5;
import 'package:insite/views/global_search/global_search_view.dart' as view6;
import 'package:insite/views/dashboard/dashboard_view.dart' as view7;
import 'package:insite/views/asset/asset_view.dart' as view8;
import 'package:insite/views/detail/asset_detail_view.dart' as view9;
import 'package:insite/views/location/location_view.dart' as view10;
import 'package:insite/views/health/health_view.dart' as view11;
import 'package:insite/views/login/login_page.dart' as view12;
import 'package:insite/views/administration/administration_view.dart' as view13;
import 'package:insite/views/add_new_user/add_new_user_view.dart' as view14;
import 'package:insite/views/manage_user/manage_user_view.dart' as view15;
import 'package:insite/views/subscription/subscription_view.dart' as view16;
import 'package:insite/views/view_dashboard/view_dashboard_view.dart' as view17;
import 'package:insite/views/sub_dash_board_details/sub_dash_board_details_view.dart' as view18;
import 'package:insite/views/sub_registration/sub_registration_view.dart' as view19;
import 'package:insite/views/single_asset_reg/single_asset_reg_view.dart' as view20;
import 'package:insite/views/single_asset_transfer/single_asset_transfer_view.dart' as view21;
import 'package:insite/views/multiple_asset_reg/multiple_asset_reg_view.dart' as view22;
import 'package:insite/views/multiple_asset_transfer/multiple_asset_transfer_view.dart' as view23;
import 'package:insite/views/plant/plant_view.dart' as view24;
import 'package:insite/views/plant/plant_dashboard_view.dart' as view25;
import 'package:insite/views/plant_hierachy/plant_hierachy_view.dart' as view26;
import 'package:insite/views/sms_management/sms_management_view.dart' as view27;
import 'package:insite/views/sms_schedule_single_asset/sms_schedule_single_asset_view.dart' as view28;
import 'package:insite/views/sms_schedule_multi_asset/sms_schedule_multi_asset_view.dart' as view29;
import 'package:insite/views/report_summary/report_summary_view.dart' as view30;
import 'package:insite/views/asset_settings_configure/asset_settings_configure_view.dart' as view31;
import 'package:insite/views/reusable_autocomplete_search/reusable_autocomplete_search_view.dart' as view32;
import 'package:insite/views/subscription/fleetstatus/fleet_status_view.dart' as view33;
import 'package:insite/views/subscription/transferhistory/transfer_history_view.dart' as view34;
import 'package:insite/views/palnt_asset_creation/palnt_asset_creation_view.dart' as view35;
import 'package:insite/views/notification/notification_view.dart' as view36;
import 'package:insite/views/add_group/add_group_view.dart' as view37;
import 'package:insite/views/manage_group/manage_group_view.dart' as view38;
import 'package:insite/views/add_new_notifications/add_new_notifications_view.dart' as view39;
import 'package:insite/views/manage_notifications/manage_notifications_view.dart' as view40;
import 'package:insite/views/manage_report/manage_report_view.dart' as view41;
import 'package:insite/views/add_report/add_report_view.dart' as view42;
import 'package:insite/views/maintenance/maintenance_view.dart' as view43;
import 'package:insite/views/asset_selection_widget/asset_selection_widget_view.dart' as view44;
import 'package:insite/views/asset/asset_view.dart' as view45;
import 'package:insite/views/main/main_view.dart' as view46;
import 'package:insite/views/detail_popup/detail_popup_view.dart' as view47;
import 'package:insite/views/main_detail_popup/main_detail_popup_view.dart' as view48;
import 'package:insite/views/maintenance_tab/maintenance_tab_view.dart' as view49;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case customerSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => view1.CustomerSelectionView());
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
        return MaterialPageRoute(builder: (_) => view8.AssetView());
      case assetDetailViewRoute:
        return MaterialPageRoute(builder: (_) => view9.AssetDetailView());
      case locationViewRoute:
        return MaterialPageRoute(builder: (_) => view10.LocationView());
      case healthViewRoute:
        return MaterialPageRoute(builder: (_) => view11.HealthView());
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => view12.LoginPage());
      case administrationViewPageRoute:
        return MaterialPageRoute(builder: (_) => view13.AdminstrationView());
      case addNewUserViewRoute:
        return MaterialPageRoute(builder: (_) => view14.AddNewUserView());
      case manageUserViewRoute:
        return MaterialPageRoute(builder: (_) => view15.ManageUserView());
      case subscriptionViewRoute:
        return MaterialPageRoute(builder: (_) => view16.SubscriptionView());
      case viewDashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view17.ViewDashboardView());
      case subDashBoardDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view18.SubDashBoardDetailsView());
      case subRegistrationViewRoute:
        return MaterialPageRoute(builder: (_) => view19.SubRegistrationView());
      case singleAssetRegViewRoute:
        return MaterialPageRoute(builder: (_) => view20.SingleAssetRegView());
      case singleAssetTransferViewRoute:
        return MaterialPageRoute(builder: (_) => view21.SingleAssetTransferView());
      case multipleAssetRegViewRoute:
        return MaterialPageRoute(builder: (_) => view22.MultipleAssetRegView());
      case multipleAssetTransferViewRoute:
        return MaterialPageRoute(builder: (_) => view23.MultipleAssetTransferView());
      case plantViewRoute:
        return MaterialPageRoute(builder: (_) => view24.PlantView());
      case plantDashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view25.PlantDashboardView());
      case plantHierachyViewRoute:
        return MaterialPageRoute(builder: (_) => view26.PlantHierachyView());
      case smsManagementViewRoute:
        return MaterialPageRoute(builder: (_) => view27.SmsManagementView());
      case smsScheduleSingleAssetViewRoute:
        return MaterialPageRoute(builder: (_) => view28.SmsScheduleSingleAssetView());
      case smsScheduleMultiAssetViewRoute:
        return MaterialPageRoute(builder: (_) => view29.SmsScheduleMultiAssetView());
      case reportSummaryViewRoute:
        return MaterialPageRoute(builder: (_) => view30.ReportSummaryView());
      case assetSettingsConfigureViewRoute:
        return MaterialPageRoute(builder: (_) => view31.AssetSettingsConfigureView());
      case reusableAutocompleteSearchViewRoute:
        return MaterialPageRoute(builder: (_) => view32.ReusableAutocompleteSearchView());
      case fleetStatusViewRoute:
        return MaterialPageRoute(builder: (_) => view33.FleetStatusView());
      case transferHistoryViewRoute:
        return MaterialPageRoute(builder: (_) => view34.TransferHistoryView());
      case palntAssetCreationViewRoute:
        return MaterialPageRoute(builder: (_) => view35.PalntAssetCreationView());
      case notificationViewRoute:
        return MaterialPageRoute(builder: (_) => view36.NotificationView());
      case addGroupViewRoute:
        return MaterialPageRoute(builder: (_) => view37.AddGroupView());
      case manageGroupViewRoute:
        return MaterialPageRoute(builder: (_) => view38.ManageGroupView());
      case addNewNotificationsViewRoute:
        return MaterialPageRoute(builder: (_) => view39.AddNewNotificationsView());
      case manageNotificationsViewRoute:
        return MaterialPageRoute(builder: (_) => view40.ManageNotificationsView());
      case manageReportViewRoute:
        return MaterialPageRoute(builder: (_) => view41.ManageReportView());
      case addReportViewRoute:
        return MaterialPageRoute(builder: (_) => view42.AddReportView());
      case maintenanceViewRoute:
        return MaterialPageRoute(builder: (_) => view43.MaintenanceView());
      case assetSelectionWidgetViewRoute:
        return MaterialPageRoute(builder: (_) => view44.AssetSelectionWidgetView());
      case assetViewRoute0:
        return MaterialPageRoute(builder: (_) => view45.AssetView());
      case mainViewRoute:
        return MaterialPageRoute(builder: (_) => view46.MainView());
      case detailPopupViewRoute:
        return MaterialPageRoute(builder: (_) => view47.DetailPopupView());
      case mainDetailPopupViewRoute:
        return MaterialPageRoute(builder: (_) => view48.MainDetailPopupView());
      case maintenanceTabViewRoute:
        return MaterialPageRoute(builder: (_) => view49.MaintenanceTabView());
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