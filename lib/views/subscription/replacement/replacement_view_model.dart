import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_view.dart';
import 'package:insite/views/subscription/replacement/device_replacement_status/device_replacement_status_view.dart';
import 'package:insite/views/subscription/sms-management/sms-single_asset/sms_schedule_single_asset_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ReplacementViewModel extends InsiteViewModel {
  Logger log;
  final _navigationService = locator<NavigationService>();

  ReplacementViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.REPLACEMENTSTATUS) {
      _navigationService.navigateWithTransition(DeviceReplacementStatusView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.DEVICEREPLACEMENT) {
      _navigationService.navigateWithTransition(DeviceReplacementView(),
          transition: "fade");
    }
  }
}
