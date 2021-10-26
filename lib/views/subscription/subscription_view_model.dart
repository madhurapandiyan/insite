import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
<<<<<<< HEAD
import 'package:insite/core/services/subscription_service.dart';
=======
>>>>>>> f0ebaa9e7731ed5688bbda93b2a081d7cc3076da
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/view_dashboard/view_dashboard_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
<<<<<<< HEAD
import 'package:insite/core/models/subscription_dashboard.dart';
=======
>>>>>>> f0ebaa9e7731ed5688bbda93b2a081d7cc3076da

class SubscriptionViewModel extends InsiteViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();
<<<<<<< HEAD
  var _subscriptionService = locator<SubScriptionService>();
=======
>>>>>>> f0ebaa9e7731ed5688bbda93b2a081d7cc3076da

  SubscriptionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.VIEWDASHBOARD) {
      _navigationService.navigateWithTransition(View(), transition: "fade");
    }
  }
<<<<<<< HEAD

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
=======
>>>>>>> f0ebaa9e7731ed5688bbda93b2a081d7cc3076da
}
