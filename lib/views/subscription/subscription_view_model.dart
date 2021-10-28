import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_registration/sub_registration_view.dart';
import 'package:insite/views/subscription/options/view_dashboard/subscription_dashboard_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:insite/core/models/subscription_dashboard.dart';

class SubscriptionViewModel extends InsiteViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();
  var _subscriptionService = locator<SubScriptionService>();

  SubscriptionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.VIEWDASHBOARD) {
      _navigationService.navigateWithTransition(View(), transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWREGISTRATION) {
      navigationService.navigateWithTransition(SubRegistrationView(),
          transition: "fade");
    }
  }

  getSubscriptionDashboardData() async {
    Logger().i("getApplicationAccessData");
    DashboardResult result =
        await _subscriptionService.getResultsFromSubscriptionApi();
    if (result != null) {
      Logger().d('no results found');
    }
    Logger().d('$result');
    notifyListeners();
  }
}
