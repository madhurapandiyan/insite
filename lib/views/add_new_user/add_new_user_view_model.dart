import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/role_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/models/user.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class AddNewUserViewModel extends InsiteViewModel {
  Logger? log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  List<ApplicationAccess>? selectedList;
  TextEditingController emailController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  List<ApplicationAccessData> _assetsData = [];
  List<ApplicationAccessData> get assetsData => _assetsData;

  List<ApplicationSelectedDropDown> _applicationSelectedDropDownList = [];
  List<ApplicationSelectedDropDown> get applicationSelectedDropDownList =>
      _applicationSelectedDropDownList;

  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;

  bool _enableAdd = false;
  bool get enableAdd => _enableAdd;

  bool _setDefaultPreferenceToUser = false;
  bool get setDefaultPreferenceToUser => _setDefaultPreferenceToUser;

  Users? user;
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

  String? jobTypeValue;

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

  String? jobTitleValue;
  String? languageTypeValue;

  int? lastApplicationAccessSelectedIndex;
  String? dropDownValue;

  AddNewUserViewModel(Users user, bool isEdit) {
    this.user = user;
    this._enableAdd = isEdit;
    if (user != null) {
      emailController.text = user.loginId!;
      firstNameController.text = user.first_name!;
      lastNameController.text = user.last_name!;
      phoneNumberController.text = user.phone!;
      addressController.text = user.address!.country!;
      pinCodeController.text = user.address!.zipcode!;
      selectedList = [];
    } else {
      emailController.text = "";
      firstNameController.text = "";
      lastNameController.text = "";
      phoneNumberController.text = "";
      addressController.text = "";
      pinCodeController.text = "";
      countryController.text = "";
      stateController.text = "";
      selectedList = [];
    }
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
      _assetsData[index].isSelected = !_assetsData[index].isSelected!;
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
      if (data.isSelected! && !data.isPermissionSelected!) {
        assetsData[i].isPermissionSelected = true;
        var applicationData = ApplicationSelectedDropDown(
            accessData: data,
            value: value,
            key: data.application!.appUID,
            applicationName: data.application!.tpaasAppName);
        applicationSelectedDropDownList.add(applicationData);
      }
    }
    notifyListeners();
  }

  onMaildIdCheckClicked() async {
    try {
      if (emailController.text.isEmpty) {
        snackbarService!.showSnackbar(message: "Email is empty");
        return;
      }
      showLoadingDialog();
      CheckUserResponse response =
          await _manageUserService.checkUser(emailController.text);
      if (response != null) {
        if (response.users != null && response.users!.isNotEmpty) {
          snackbarService!.showSnackbar(message: "User is already available");
          _enableAdd = false;
        } else {
          _enableAdd = true;
        }
        hideLoadingDialog();
      } else {
        _enableAdd = false;
        snackbarService!.showSnackbar(message: "Checking user details failed");
        hideLoadingDialog();
      }
    } on DioError catch (e) {
      Logger().e(e.type);
      hideLoadingDialog();
      if (e.type == DioErrorType.other) {
        _enableAdd = true;
      }
    }
    notifyListeners();
  }

  onPermissionRemoved(ApplicationSelectedDropDown value, int index) {
    try {
      Logger().i("onPermissionSelected ${value.value}  $index");
      for (var i = 0; i < assetsData.length; i++) {
        var data = assetsData[i];
        if (value.key == data.application!.appUID) {
          if (data.isPermissionSelected!) {
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
    ApplicationData? applicationData =
        await _manageUserService.getApplicationsData();
    if (applicationData != null && applicationData.applications!.isNotEmpty) {
      Logger().i("applications length ${applicationData.applications!.length}");
      for (var application in applicationData.applications!.take(4)) {
        if (application.enabled!) {
          _assetsData.add(ApplicationAccessData(
              application: application, isSelected: false));
        }
      }
    }
    notifyListeners();
  }

  getUser() async {
    Logger().i("getUser ");
    ManageUser? result = await _manageUserService.getUser(user!.userUid);
    try {
      if (result != null) {
        this.user = result.user!;
        jobTypeValue = result.user!.job_type!;
        jobTitleValue = result.user!.job_title!;
        Logger().i("getUser ${result.user!.application_access!.length}");
        for (var applicationAccess in result.user!.application_access!) {
          for (int i = 0; i < assetsData.length; i++) {
            var data = assetsData[i];
            if (data.application!.tpaasAppName ==
                applicationAccess.applicationName) {
              assetsData[i].isSelected = true;
              assetsData[i].isPermissionSelected = true;
              Logger().i("getUser ${applicationAccess.role_name}");
              var applicationData = ApplicationSelectedDropDown(
                  accessData: data,
                  applicationName: data.application!.tpaasAppName,
                  value: applicationAccess.role_name,
                  key: data.application!.appUID);
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
    address,
    state,
    country,
    zipcode,
  ) async {
    if (!validate()) {
      return;
    }
    showLoadingDialog();
    try {
      List<Role> roles = [];
      for (int i = 0; i < applicationSelectedDropDownList.length; i++) {
        var data = applicationSelectedDropDownList[i];
        RoleDataResponse? roleDataResponse =
            await _manageUserService.getRoles(data.applicationName);
        for (int j = 0; j < roleDataResponse!.role_list!.length; j++) {
          RoleData roleData = roleDataResponse.role_list![j];
          if (data.value == roleData.role_name) {
            roles.add(Role(
                role_id: roleData.role_id,
                application_name: data.applicationName));
            break;
          }
        }
      }
      for (var role in roles) {
        Logger().d("role ${role.toJson()}");
      }
      UpdateResponse? updateResponse = await _manageUserService.getSaveUserData(
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
          roles,
          user!.userUid);
      hideLoadingDialog();
      if (updateResponse != null) {
        snackbarService!.showSnackbar(message: "Updated successfully");
      } else {
        snackbarService!.showSnackbar(message: "Updating user failed");
      }
    } catch (e) {
      hideLoadingDialog();
    }
  }

  onParticularItemSelected(String value) {
    for (int i = 0; i < assetsData.length; i++) {
      var data = assetsData[i];
      if (!data.isPermissionSelected! && data.isSelected!) {
        assetsData[i].isPermissionSelected = true;
      }
    }
    notifyListeners();
  }

  onDefaultPreferenceClicked() {
    _setDefaultPreferenceToUser = !_setDefaultPreferenceToUser;
    notifyListeners();
  }

  allowAccessToSecurityClicked() {
    _allowAccessToSecurity = !_allowAccessToSecurity;
    notifyListeners();
  }

  getAddUserData(
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
  ) async {
    try {
      if (!validate()) {
        return;
      }
      showLoadingDialog();
      List<Role> roles = [];
      for (int i = 0; i < applicationSelectedDropDownList.length; i++) {
        var data = applicationSelectedDropDownList[i];
        RoleDataResponse? roleDataResponse =
            await _manageUserService.getRoles(data.applicationName);
        for (int j = 0; j < roleDataResponse!.role_list!.length; j++) {
          RoleData roleData = roleDataResponse.role_list![j];
          if (data.value == roleData.role_name) {
            roles.add(Role(
                role_id: roleData.role_id,
                application_name: data.applicationName));
            break;
          }
        }
      }
      for (var role in roles) {
        Logger().d("role ${role.toJson()}");
      }
      AddUser? result = await _manageUserService.getAddUserData(
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
          roles);
      if (result != null) {
        snackbarService!.showSnackbar(message: "Added successfully");
      } else {
        snackbarService!.showSnackbar(message: "Adding user failed");
      }
      hideLoadingDialog();
    } catch (e) {
      Logger().e(e);
    }
  }

  bool validate() {
    if (emailController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Email is empty");
      return false;
    }

    if (firstNameController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "First name is empty");
      return false;
    }

    if (lastNameController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Last name is empty");
      return false;
    }

    if (phoneNumberController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Phone number is empty");
      return false;
    }

    if (addressController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Address is empty");
      return false;
    }

    if (countryController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Country is empty");
      return false;
    }

    if (stateController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "State is empty");
      return false;
    }

    if (pinCodeController.text.isEmpty) {
      snackbarService!.showSnackbar(message: "Pincode is empty");
      return false;
    }

    if (applicationSelectedDropDownList.isEmpty) {
      snackbarService!.showSnackbar(message: "Roles not selected");
      return false;
    }

    if (jobTypeValue == null || jobTypeValue!.isEmpty) {
      snackbarService!.showSnackbar(message: "Job type not selected");
      return false;
    }

    if (jobTitleValue == null || jobTitleValue!.isEmpty) {
      snackbarService!.showSnackbar(message: "Job title not selected");
      return false;
    }

    if (languageTypeValue == null || languageTypeValue!.isEmpty) {
      snackbarService!.showSnackbar(message: "language not selected");
      return false;
    }
    return true;
  }
}
