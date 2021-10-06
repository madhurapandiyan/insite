import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddNewUserViewModel extends BaseViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  List<ApplicationAccessData> _assetsData = [];
  List<ApplicationAccessData> get assetsData => _assetsData;

  List<Application> _applicationListData = [];
  List<Application> get applicationListData => _applicationListData;

  List<ApplicationSelectedDropDown> _applicationSelectedDropDownList = [];
  List<ApplicationSelectedDropDown> get applicationSelectedDropDownList =>
      _applicationSelectedDropDownList;

  Users user;
  List<String> dropDownlist = [
    "Administrator",
    "Contributor",
    "Creator",
    "Viewer"
  ];
  int lastApplicationAccessSelectedIndex;
  String dropDownValue;

  AddNewUserViewModel(Users user) {
    this.user = user;
    _manageUserService.setUp();
    this.log = getLogger(this.runtimeType.toString());
    if (user != null) {
      Future.delayed(Duration(seconds: 1), () {
        getApplicationAccessData();
      });
    }
  }

  onApplicationAccessSelection(int index) {
    Logger().i("onApplicationAccessSelection $index");
    try {
      _assetsData[index].isSelected = true;
      lastApplicationAccessSelectedIndex = index;
      notifyListeners();
    } catch (e) {}
  }

  onPermissionSelected(value) {
    Logger().i("onPermissionSelected $value");
    dropDownValue = value;
    for (var i = 0; i < assetsData.length; i++) {
      var data = assetsData[i];
      if (data.isSelected && !data.isPermissionSelected) {
        assetsData[i].isPermissionSelected = true;
        var applicationData =
            ApplicationSelectedDropDown(accessData: data, value: value);
        applicationSelectedDropDownList.add(applicationData);
      }
    }
    notifyListeners();
  }

  onPermissionRemoved(ApplicationSelectedDropDown value, int index) {
    try {
      Logger().i("onPermissionSelected ${value.value}  $index");
      for (var i = 0; i < assetsData.length; i++) {
        var data = assetsData[i];
        if (data.isPermissionSelected) {
          assetsData[i].isSelected = false;
          assetsData[i].isPermissionSelected = false;
        }
      }
      applicationSelectedDropDownList.removeAt(index);
    } catch (e) {}
    notifyListeners();
  }

  getApplicationAccessData() async {
    Logger().i("getApplicationAccessData");
    int pageNumber = 1;
    // ApplicationData applicationData =
    //     await _manageUserService.getApplicationsData();
    // if (applicationData != null) {
    //   for (var application in applicationData.applications) {
    //     if (application.enabled) {
    //       _assetsData.add(ApplicationAccessData(
    //           application: application, isSelected: false));
    //     }
    //   }
    // }

    ManageUser result = await _manageUserService.getUser(user.userUid);
    if (result != null) {
      _assetsData.clear();
      for (var asset in result.user.application_access) {
        Logger().i("data application access $asset");
        _assetsData
            .add(ApplicationAccessData(application: asset, isSelected: false));
      }
    }
    notifyListeners();
  }
}
