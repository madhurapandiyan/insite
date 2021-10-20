import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';
import 'package:insite/views/adminstration/addgeofense/addgeofense_view.dart';
import 'package:insite/views/adminstration/manage_user/manage_user_view.dart';

import 'package:logger/logger.dart';
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
      _navigationService.navigateWithTransition(
          AddNewUserView(
            isEdit: false,
            user: null,
          ),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MANAGEUSER) {
      _navigationService.navigateWithTransition(ManageUserView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.ADDNEWGEOFENCES) {
      _navigationService.navigateWithTransition(AddgeofenseView(),
          transition: "fade");
    }
  }
}
