import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddNewUserViewModel extends BaseViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  List<ApplicationAccess> _assetsData = [];

  List<ApplicationAccess> get assetData => _assetsData;

  List <DropDownModelClass> listDropDownValue = [];
  List< DropDownModelClass> get listDropDownValues => listDropDownValue;

  AddNewUserViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    getApplicationAccessData();
  }
  getApplicationAccessData() async {
    int pageNumber = 1;
    AdminManageUser result =
        await _manageUserService.getAdminManageUserListData(pageNumber);
    for (var data in result.users) {
      _assetsData.clear();
      _assetsData.addAll(data.application_access);
    }
    notifyListeners();
  }
  
}
