import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/model_class/application_name_model.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:load/load.dart';
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

  List<ApplicationName> tPassName = [];
  List<ApplicationName> get tPassNameData => tPassName;

  Users user;
  List<String> dropDownlist = [
    "Administrator",
    "Contributor",
    "Creator",
    "Viewer"
  ];

  List<String> jobTypeList = [
    "Employee",
    "Non Employee",
  ];

  List<String> jobTitleList = [
    "Equipment Manager",
    "Maintenance Manager",
    "Project Manager",
    "Machine Operator",
    "Maintenance Technician",
    "Others"
  ];

  List<String> languageTypeValueList = ["Tamil", "English"];

  String jobTypeValue;

  onJobTypeSelected(value) {
    jobTypeValue = value;
    notifyListeners();
  }

  onJobTitleSelected(value) {
    jobTitleValue = value;
    notifyListeners();
  }

  onlanguageTypeValueSelected(value) {
    languageTypeValue = value;
    notifyListeners();
  }

  String jobTitleValue;
  String languageTypeValue;

  int lastApplicationAccessSelectedIndex;
  String dropDownValue;

  AddNewUserViewModel(Users user) {
    this.user = user;
    _manageUserService.setUp();
    this.log = getLogger(this.runtimeType.toString());
    showLoadingDialog();
    Future.delayed(Duration(seconds: 1), () {
      getData();
    });
  }

  getData() async {
    await getApplicationAccessData();
    if (user != null) {
      await getUser();
    }
    hideLoadingDialog();
  }

  onApplicationAccessSelection(int index) {
    Logger().i("onApplicationAccessSelection $index");
    try {
      _assetsData[index].isSelected = !_assetsData[index].isSelected;
      lastApplicationAccessSelectedIndex = index;
      print("lastApplicationAccessSelectedIndex:$index");
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
        var applicationData = ApplicationSelectedDropDown(
            accessData: data, value: value, key: data.application.appUID);
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
        if (value.key == data.application.appUID) {
          if (data.isPermissionSelected) {
            assetsData[i].isSelected = false;
            assetsData[i].isPermissionSelected = false;
          }
        }
      }
      applicationSelectedDropDownList.removeAt(index);
    } catch (e) {}
    notifyListeners();
  }

  getApplicationAccessData() async {
    Logger().i("getApplicationAccessData");
    ApplicationData applicationData =
        await _manageUserService.getApplicationsData();
    if (applicationData != null) {
      for (var application in applicationData.applications.take(4)) {
        if (application.enabled) {
          _assetsData.add(ApplicationAccessData(
              application: application, isSelected: false));
        }
      }
    }
    notifyListeners();
  }

  getUser() async {
    Logger().i("getUser ");
    ManageUser result = await _manageUserService.getUser(user.userUid);
    try {
      if (result != null) {
        this.user = result.user;
        jobTypeValue = result.user.job_type;
        jobTitleValue = result.user.job_title;
        Logger().i("getUser ${result.user.application_access.length}");
        for (var applicationAccess in result.user.application_access) {
          for (int i = 0; i < assetsData.length; i++) {
            var data = assetsData[i];
            if (data.application.tpaasAppName ==
                applicationAccess.applicationName) {
              assetsData[i].isSelected = true;
              assetsData[i].isPermissionSelected = true;
              Logger().i("getUser ${applicationAccess.role_name}");
              var applicationData = ApplicationSelectedDropDown(
                  accessData: data,
                  value: applicationAccess.role_name,
                  key: data.application.appUID);
              applicationSelectedDropDownList.add(applicationData);
            }
          }
        }
        Logger().i("getUser ${applicationSelectedDropDownList.length}");
      }
    } catch (e) {}
    notifyListeners();
  }

  getEditUserData(
    firstName,
    lastName,
    email,
    jobTitle,
    phoneNumber,
    jobType,
    userType,
    applicationName,
    address,
    state,
    country,
    zipcode,
  ) async {
    showLoadingDialog();
    try {
      UpdateResponse updateResponse = await _manageUserService.getSaveUserData(
        firstName,
        lastName,
        email,
        phoneNumber,
        jobTitle,
        jobType,
        userType,
        applicationName,
        address,
        state,
        country,
        zipcode,
      );
      print("updateResponse:${updateResponse.isUpdated}");
      print("role:$this.applicationName");
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  onParticularItemSelected(String value) {
    for (int i = 0; i < assetsData.length; i++) {
      var data = assetsData[i];
      if (!data.isPermissionSelected && data.isSelected) {
        assetsData[i].isPermissionSelected = true;
        tPassName
            .add(ApplicationName(tPassname: data.application.tpaasAppName));
      }
    }
    notifyListeners();
  }

  getAddUserData(
      firstName,
      lastName,
      email,
      jobTitle,
      phoneNumber,
      jobType,
      sso_id,
      userType,
      applicationName,
      address,
      state,
      country,
      zipcode) async {
    try {
      showLoadingDialog();
      AddUser result = await _manageUserService.getAddUserData(
          firstName,
          lastName,
          email,
          phoneNumber,
          jobTitle,
          jobType,
          address,
          state,
          country,
          zipcode,
          userType,
          sso_id,
          applicationName);
      hideLoadingDialog();
      print("result:$result");
      print("@@@:$applicationName");
    } catch (e) {
      Logger().e(e);
    }
  }
}
