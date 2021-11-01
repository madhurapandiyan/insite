import 'dart:math';

import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/estimated_cycle_volume_payload.dart';
import 'package:insite/core/models/role_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/models/asset_mileage_settings.dart';

class AssetAdminManagerUserService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;

  AssetAdminManagerUserService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AdminManageUser> getAdminManageUserListData(pageNumber) async {
    try {
      if (isVisionLink) {
        Map<String, String> queryMap = Map();
        queryMap["pageNumber"] = pageNumber.toString();
        queryMap["sort"] = "";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getAdminManagerUserListDataVL(
                Urls.adminManagerUserSumaryVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      } else {
        Map<String, String> queryMap = Map();
        queryMap["pageNumber"] = pageNumber.toString();
        // queryMap["sort"] = "";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClient()
            .getAdminManagerUserListData(
                Urls.adminManagerUserSumary +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID,
                "in-identitymanager-identitywebapi");
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<ManageUser> getUser(String userId) async {
    try {
      if (isVisionLink) {
        ManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getUser(Urls.adminManagerUserSumaryVL + "/" + userId,
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      } else {
        ManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getUser(Urls.adminManagerUserSumaryVL + "/" + userId,
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<ApplicationData> getApplicationsData() async {
    try {
      if (isVisionLink) {
        Map<String, String> queryMap = Map();
        if (accountSelected != null) {
          queryMap["CustomerUID"] = accountSelected.CustomerUID;
        }
        ApplicationData adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getApplicationsData(
                Urls.applicationsUrlVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      } else {
        Map<String, String> queryMap = Map();
        if (accountSelected != null) {
          queryMap["CustomerUID"] = accountSelected.CustomerUID;
        }
        ApplicationData adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getApplicationsData(
                Urls.applicationsUrl +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<UpdateResponse> getSaveUserData(
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
      userUid) async {
    try {
      Logger().d(
          "address ${AddressData(addressline1: address, state: state, country: country, zipcode: zipcode).toJson()}");
      Logger().d(
          "details ${Details(job_title: jobTitle, job_type: jobType, user_type: userType).toJson()}");
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .updateUserData(
                Urls.adminManagerUserSumaryVL + "/" + userUid,
                accountSelected.CustomerUID,
                UpdateUserData(
                    fname: firstName,
                    lname: lastName,
                    cwsEmail: email,
                    phone: phoneNumber,
                    sso_id: email,
                    isCatssoUserCreation: true,
                    src: "VisionLink",
                    company: "NYL",
                    language: "en-US",
                    address: AddressData(
                        addressline1: address,
                        addressline2: "",
                        state: state,
                        country: country,
                        zipcode: zipcode),
                    roles: roles,
                    details: Details(
                        job_title: jobTitle,
                        job_type: jobType,
                        user_type: userType)));

        return updateResponse;
      } else {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .updateUserData(
                Urls.adminManagerUserSumaryVL + "/" + userUid,
                accountSelected.CustomerUID,
                UpdateUserData(
                    fname: firstName,
                    lname: lastName,
                    cwsEmail: email,
                    sso_id: email,
                    phone: phoneNumber,
                    isCatssoUserCreation: true,
                    src: "VisionLink",
                    company: "NYL",
                    language: "en-US",
                    address: AddressData(
                        addressline1: address,
                        state: state,
                        addressline2: "",
                        country: country,
                        zipcode: zipcode),
                    roles: roles,
                    details: Details(
                        job_title: jobTitle,
                        job_type: jobType,
                        user_type: userType)));
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<RoleDataResponse> getRoles(String appName) async {
    try {
      if (isVisionLink) {
        var result = await MyApi().getClientSeven().roles(
              Urls.adminRolesVL + "/" + appName + "/roles",
              accountSelected.CustomerUID,
            );
        return result;
      } else {
        var result = await MyApi().getClientSeven().roles(
              Urls.adminRolesVL + "/" + appName + "/roles",
              accountSelected.CustomerUID,
            );
        return result;
      }
    } catch (e) {}
  }

  Future<AddUser> getAddUserData(
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
      roles) async {
    try {
      if (isVisionLink) {
        Logger().d(
            "address ${AddressData(addressline1: address, state: state, country: country, zipcode: zipcode).toJson()}");
        Logger().d(
            "details ${Details(job_title: jobTitle, job_type: jobType, user_type: userType).toJson()}");
        AddUser addUserResponse = await MyApi().getClientSeven().addUserData(
            Urls.addUserSummaryVL,
            accountSelected.CustomerUID,
            AddUserData(
                fname: firstName,
                lname: lastName,
                cwsEmail: email,
                sso_id: sso_id,
                phone: phoneNumber,
                isCATSSOUserCreation: true,
                src: "VisionLink",
                company: "NYL",
                language: "en-US",
                address: AddressData(
                    addressline1: address,
                    state: state,
                    addressline2: " ",
                    country: country,
                    zipcode: zipcode),
                roles: roles,
                details: Details(
                    job_title: jobTitle,
                    job_type: jobType,
                    user_type: userType)));
        return addUserResponse;
      } else {
        Logger().d(
            "address ${AddressData(addressline1: address, state: state, country: country, zipcode: zipcode).toJson()}");
        Logger().d(
            "details ${Details(job_title: jobTitle, job_type: jobType, user_type: userType).toJson()}");
        AddUser addUserResponse = await MyApi().getClientSeven().inviteUser(
            Urls.adminManagerUserSumary + "/Invite",
            AddUserDataIndStack(
                fname: firstName,
                customerUid: accountSelected.CustomerUID,
                lname: lastName,
                email: email,
                phone: phoneNumber,
                isAssetSecurityEnabled: true,
                src: "VisionLink",
                company: "NYL",
                language: "en-US",
                address: AddressData(
                    addressline1: address,
                    state: state,
                    addressline2: " ",
                    country: country,
                    zipcode: zipcode),
                roles: roles,
                details: Details(
                    job_title: jobTitle,
                    job_type: jobType,
                    user_type: "Standard")),
            accountSelected.CustomerUID,
            (await _localService.getLoggedInUser()).sub,
            "in-identitymanager-identitywebapi");
        return addUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<dynamic> deleteUsers(users) async {
    if (isVisionLink) {
      var result = await MyApi().getClientSeven().deleteUsersData(
          Urls.adminManagerUserSumaryVL,
          accountSelected.CustomerUID,
          DeleteUserData(users: users));
      return result;
    } else {
      var result = await MyApi().getClientSeven().deleteUsers(
          Urls.adminManagerUserSumary,
          DeleteUserDataIndStack(
            users: users,
            customerUid: accountSelected.CustomerUID,
          ),
          accountSelected.CustomerUID,
          (await _localService.getLoggedInUser()).sub,
          "in-identitymanager-identitywebapi");
      return result;
    }
  }

  Future<ManageAssetConfiguration> getAssetSettingData(
      pageSize, pageNumber) async {
    try {
      Map<String, String> queryMap = Map();
      if (isVisionLink) {
        queryMap["pageSize"] = pageSize.toString();
        queryMap["pageNumber"] = pageNumber.toString();
        queryMap["sortColumn"] = "assetId";
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSeven().getAssetSettingsListData(
                Urls.assetSettingsVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return manageAssetConfigurationResponse;
      } else {
        queryMap["pageSize"] = pageSize.toString();
        queryMap["pageNumber"] = pageNumber.toString();
        queryMap["sortColumn"] = "assetId";
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSeven().getAssetSettingsListData(
                Urls.assetSettingsVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return manageAssetConfigurationResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AddSettings> getFuelBurnRateSettingsData(
      idleValue, workingValue, assetUid) async {
    AssetFuelBurnRateSetting listBurnRateData = AssetFuelBurnRateSetting(
        idleTargetValue: idleValue,
        workTargetValue: workingValue,
        assetUIds: assetUid);
    Logger().i(listBurnRateData);

    try {
      if (isVisionLink) {
        Logger().i(listBurnRateData.toJson());
        AddSettings addSettings = await MyApi()
            .getClientSeven()
            .getassetSettingsFuelBurnRateData(Urls.assetSettingsFuelBurnrate,
                listBurnRateData, accountSelected.CustomerUID);

        return addSettings;
      } else {
        AddSettings addSettings = await MyApi()
            .getClientSeven()
            .getassetSettingsFuelBurnRateData(Urls.assetSettingsFuelBurnrate,
                listBurnRateData, accountSelected.CustomerType);

        return addSettings;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<EstimatedAssetSetting> getAssetTargetSettingsData(
      List<String> assetUid, startDate, endDate, idle, runTime) async {
    try {
      List<AssetTargetSettings> getAssetList = [];
      for (int i = 0; i < assetUid.length; i++) {
        getAssetList.add(
          AssetTargetSettings(
            assetUid: assetUid[i],
            startDate: startDate.toString(),
            endDate: endDate.toString(),
            idle: idle,
            runtime: runTime,
          ),
        );
      }

      EstimatedAssetSetting listSettingTargetData =
          EstimatedAssetSetting(assetTargetSettings: getAssetList);
      Logger().i(listSettingTargetData.toJson());
      Logger().i(assetUid);
      if (isVisionLink) {
        EstimatedAssetSetting result = await MyApi()
            .getClientSeven()
            .getAssetTargetSettingsData(Urls.assetSettingsTarget,
                listSettingTargetData, accountSelected.CustomerUID);
        return result;
      } else {
        EstimatedAssetSetting result = await MyApi()
            .getClientSeven()
            .getAssetTargetSettingsData(Urls.assetSettingsTarget,
                listSettingTargetData, accountSelected.CustomerUID);
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoad(
      List<String> assetUid,
      cycles,
      volumes,
      payload,
      startDate,
      endDate) async {
    try {
      List<AssetProductivitySettings> getAssetPayLoadList = [];
      for (int i = 0; i < assetUid.length; i++) {
        getAssetPayLoadList.add(AssetProductivitySettings(
            assetUid: assetUid[i],
            cycles: cycles,
            volumes: volumes,
            payload: payload,
            startDate: startDate,
            endDate: endDate)
            );
      }
      Logger().i("payLoad:$assetUid");
      EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoadListData =
          EstimatedCycleVolumePayLoad(assetProductivitySettings: getAssetPayLoadList);
      if (isVisionLink) {
        EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad = await MyApi()
            .getClientSeven()
            .getEstimatedCycleVolumePayLoadData(
                Urls.estimatedCycleVolumePayLoad,
                estimatedCycleVolumePayLoadListData,
                accountSelected.CustomerUID);
        return estimatedCycleVolumePayLoad;
      } else {
        EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad = await MyApi()
            .getClientSeven()
            .getEstimatedCycleVolumePayLoadData(
                Urls.estimatedCycleVolumePayLoad,
                estimatedCycleVolumePayLoadListData,
                accountSelected.CustomerUID);
        return estimatedCycleVolumePayLoad;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetMileageSettingData> getAssetMileageData(
      List<String> assetUid, targetValue) async {
    var mileageData =
        AssetMileageSettingData(assetUIds: assetUid, targetValue: targetValue);
    Logger().i(assetUid);
    try {
      if (isVisionLink) {
        AssetMileageSettingData assetMileageSettingData = await MyApi()
            .getClientSeven()
            .getMileageData(Urls.estimatedMileage, mileageData,
                accountSelected.CustomerUID);
        return assetMileageSettingData;
      } else {
        AssetMileageSettingData assetMileageSettingData = await MyApi()
            .getClientSeven()
            .getMileageData(Urls.estimatedMileage, mileageData,
                accountSelected.CustomerUID);
        return assetMileageSettingData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
