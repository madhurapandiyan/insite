import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/manage_user/manage_user_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminstrationViewModel extends InsiteViewModel {
  Logger log;
  var _navigationService = locator<NavigationService>();

  AdminstrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  onRespectiveButtonClicked(AdminAssetsButtonType value) {
    Logger().d("selectedValue:$value");
    if (value == AdminAssetsButtonType.ADDNEWUSER) {
      print("button is tapped");
    } else if (value == AdminAssetsButtonType.MANAGEUSER) {
      _navigationService.navigateWithTransition(ManageUserView(),
          transition: "fade");
    }
  }
}
