import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/view_dashboard/view_dashboard_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SubscriptionViewModel extends InsiteViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();

  SubscriptionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.VIEWDASHBOARD) {
      _navigationService.navigateWithTransition(View(), transition: "fade");
    }
  }
}
