import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_registration/sub_registration_view.dart';
import 'package:insite/views/subscription/options/view_dashboard/subscription_dashboard_view.dart';
import 'package:insite/views/subscription/replacement/replacement_view.dart';
import 'package:insite/views/subscription/sms-management/sms_management_view.dart';
import 'package:insite/views/subscription/transferhistory/transfer_history_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'fleetstatus/fleet_status_view.dart';

class SubscriptionViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();
  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  SubscriptionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.VIEWDASHBOARD) {
      _navigationService!.navigateWithTransition(SubscriptionDashboardView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWSMSMANAGEMENT) {
      navigationService!.navigateWithTransition(SmsManagementView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWREGISTRATION) {
      navigationService!.navigateWithTransition(SubRegistrationView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWREPLACEMENT) {
      navigationService!.navigateWithTransition(ReplacementView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWFLEETSTATUS) {
      navigationService!.navigateWithTransition(FleetStatusView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWTRANSFERHISTORY) {
      navigationService!.navigateWithTransition(TransferHistoryView(),
          transition: "fade");
    }
  }
}
