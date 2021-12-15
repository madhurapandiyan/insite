import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings_list_data.dart';
import 'package:insite/core/models/asset_mileage_settings_list_data.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/estimated_cycle_volume_payload.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/role_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/models/user.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/asset_icon_payload.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/models/asset_mileage_settings.dart';
import 'package:insite/core/models/device_type.dart';

class AssetAdminManagerUserService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;

  List<RoleData> roleData = [];

  AssetAdminManagerUserService() {
    setUp();
    roleData.add(RoleData(
        description: "Administrator",
        provider_id: "Frame-Fleet-IND",
        role_id: 2142,
        role_name: "Administrator"));
    roleData.add(RoleData(
        description: "Contributor",
        provider_id: "Frame-Fleet-IND",
        role_id: 2143,
        role_name: "Contributor"));
    roleData.add(RoleData(
        description: "Creator",
        provider_id: "Frame-Fleet-IND",
        role_id: 2144,
        role_name: "Creator"));
    roleData.add(RoleData(
        description: "Viewer",
        provider_id: "Frame-Fleet-IND",
        role_id: 2145,
        role_name: "Viewer"));

    roleData.add(RoleData(
        description: "Administrator",
        provider_id: "Frame-Administrator-IND",
        role_id: 2146,
        role_name: "Administrator"));
    roleData.add(RoleData(
        description: "AssetSecurity",
        provider_id: "Frame-Administrator-IND",
        role_id: 2147,
        role_name: "AssetSecurity"));
    roleData.add(RoleData(
        description: "Contributor",
        provider_id: "Frame-Administrator-IND",
        role_id: 2148,
        role_name: "Contributor"));
    roleData.add(RoleData(
        description: "Creator",
        provider_id: "Frame-Administrator-IND",
        role_id: 2149,
        role_name: "Creator"));
    roleData.add(RoleData(
        description: "Viewer",
        provider_id: "Frame-Administrator-IND",
        role_id: 2150,
        role_name: "Viewer"));

    roleData.add(RoleData(
        description: "Administrator",
        provider_id: "Frame-Service-IND",
        role_id: 2151,
        role_name: "Administrator"));
    roleData.add(RoleData(
        description: "Contributor",
        provider_id: "Frame-Service-IND",
        role_id: 2152,
        role_name: "Contributor"));
    roleData.add(RoleData(
        description: "Creator",
        provider_id: "Frame-Service-IND",
        role_id: 2153,
        role_name: "Creator"));
    roleData.add(RoleData(
        description: "Viewer",
        provider_id: "Frame-Service-IND",
        role_id: 2154,
        role_name: "Viewer"));
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AdminManageUser> getAdminManageUserListData(
      pageNumber, String searchKey, List<FilterData> appliedFilters) async {
    Logger().i(
        "getAdminManageUserListData $isVisionLink filters count ${appliedFilters.length}");
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      if (searchKey.isNotEmpty) {
        queryMap["searchKey"] = searchKey;
      }
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected.CustomerUID;
      }
      if (isVisionLink) {
        queryMap["sort"] = "";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getAdminManagerUserListDataVL(
                Urls.adminManagerUserSumaryVL +
                    FilterUtils.constructQueryFromMap(queryMap) +
                    FilterUtils.getUserFilterURL(appliedFilters),
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      } else {
        queryMap["sort"] = "Email";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClient()
            .getAdminManagerUserListData(
                Urls.adminManagerUserSumary +
                    "/List" +
                    FilterUtils.constructQueryFromMap(queryMap) +
                    FilterUtils.getUserFilterURL(appliedFilters),
                accountSelected.CustomerUID,
                Urls.userCountPrefix);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<ManageUser> getUser(String userId) async {
    Logger().i("getUser $isVisionLink");
    try {
      if (isVisionLink) {
        Map<String, String> queryMap = Map();
        if (customerSelected != null) {
          queryMap["customerUid"] = customerSelected.CustomerUID;
        }
        ManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getUser(
                Urls.adminManagerUserSumaryVL +
                    "/" +
                    userId +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return adminManageUserResponse;
      } else {
        Map<String, String> queryMap = Map();
        if (customerSelected != null) {
          queryMap["customerUid"] = customerSelected.CustomerUID;
        }
        ManageUser adminManageUserResponse = await MyApi().getClient().getUser(
            Urls.adminManagerUserSumary +
                "/" +
                userId +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected.CustomerUID);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<CheckUserResponse> checkUser(String mail) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["EmailID"] = mail;
      }
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected.CustomerUID;
      }
      if (isVisionLink) {
        CheckUserResponse response = await MyApi().getClientSeven().checkUserVL(
            Urls.adminManagerUserSumaryVL +
                "/List" +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected.CustomerUID);
        return response;
      } else {
        CheckUserResponse response = await MyApi().getClient().checkUser(
            Urls.adminManagerUserSumary +
                "/List" +
                FilterUtils.constructQueryFromMap(queryMap),
            Urls.userCountPrefix,
            accountSelected.CustomerUID);
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApplicationData> getApplicationsData() async {
    Logger().i("getApplicationsData");
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
        var application1 = Application(
            iconUrl:
                "https://visionlinkassets.myvisionlink.com/app-icons/v1/insitefleet/",
            name: "InSite Fleet",
            enabled: true,
            tpaasAppName: "Frame-Fleet-IND",
            appUID: "f03001b8-ea9f-11e5-88ba-0a4c287ff82f");
        var application2 = Application(
            iconUrl:
                "https://visionlinkassets.myvisionlink.com/app-icons/v1/insiteservice/",
            name: "InSite Service",
            enabled: true,
            tpaasAppName: "Frame-Service-IND",
            appUID: "b5fe5c50-9c5f-11e7-b46d-0645f4ae660c");
        var application3 = Application(
            iconUrl:
                "https://visionlinkassets.myvisionlink.com/app-icons/v1/insiteadministrator/",
            name: "InSite Administrator",
            enabled: true,
            tpaasAppName: "Frame-Administrator-IND",
            appUID: "006dfbee-b8f7-11e6-85f7-0a9e41c60d3d");
        List<Application> applications = [];
        applications.add(application1);
        applications.add(application2);
        applications.add(application3);
        return ApplicationData(applications: applications);
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
      return null;
    }
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
    Logger().i("getSaveUserData");
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
            .getClient()
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
      return null;
    }
  }

  Future<RoleDataResponse> getRoles(String appName) async {
    Logger().i("getRoles $appName");
    Logger().i("getRoles ${roleData.length}");
    try {
      if (isVisionLink) {
        var result = await MyApi().getClientSeven().roles(
              Urls.adminRolesVL + "/" + appName + "/roles",
              accountSelected.CustomerUID,
            );
        return result;
      } else {
        RoleDataResponse response = RoleDataResponse(
            role_list: roleData
                .where((element) => element.provider_id == appName)
                .toList());
        return response;
        // var result = await MyApi().getClientSeven().roles(
        //       Urls.adminRolesVL + "/" + appName + "/roles",
        //       accountSelected.CustomerUID,
        //     );
        // return result;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
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
    Logger().i("getAddUserData");
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
        AddUser addUserResponse = await MyApi().getClient().inviteUser(
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
      return null;
    }
  }

  Future<dynamic> deleteUsers(users) async {
    Logger().i("deleteUsers");
    try {
      if (isVisionLink) {
        var result = await MyApi().getClientSeven().deleteUsersData(
            Urls.adminManagerUserSumaryVL,
            accountSelected.CustomerUID,
            customerSelected != null
                ? DeleteUserDataIndStack(
                        users: users, customerUid: customerSelected.CustomerUID)
                    .toJson()
                : DeleteUserData(users: users).toJson());
        return result;
      } else {
        var result = await MyApi().getClient().deleteUsers(
            Urls.adminManagerUserSumary,
            customerSelected != null
                ? DeleteUserDataIndStack(
                        users: users, customerUid: customerSelected.CustomerUID)
                    .toJson()
                : DeleteUserData(users: users).toJson(),
            accountSelected.CustomerUID,
            (await _localService.getLoggedInUser()).sub,
            "in-identitymanager-identitywebapi");
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<ListDeviceTypeResponse> getDeviceTypes() async {
    try {
      DeviceTypeRequest request =
          DeviceTypeRequest(allAssets: true, assetUID: []);
      if (isVisionLink) {
        ListDeviceTypeResponse response = await MyApi()
            .getClientSeven()
            .getDeviceTypeVL(
                Urls.deviceTypeVL, request, accountSelected.CustomerUID);
        return response;
      } else {
        ListDeviceTypeResponse response =
            await MyApi().getClientSix().getDeviceType(
                  Urls.deviceTypes,
                  request,
                  Urls.assetSettingsPrefix,
                  accountSelected.CustomerUID,
                );
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ManageAssetConfiguration> getAssetSettingData(pageSize, pageNumber,
      String searchKeyword, String deviceTypeSelected) async {
    Logger().i("getAssetSettingData");
    try {
      Map<String, String> queryMap = Map();
      if (isVisionLink) {
        queryMap["pageSize"] = pageSize.toString();
        queryMap["pageNumber"] = pageNumber.toString();
        queryMap["sortColumn"] = "assetId";
        if (searchKeyword.isNotEmpty) {
          queryMap["filterName"] = "all";
          queryMap["filterValue"] = searchKeyword;
        }
        if (deviceTypeSelected.isNotEmpty && deviceTypeSelected != "ALL") {
          queryMap["deviceType"] = deviceTypeSelected;
        }
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSeven().getAssetSettingsListDataVL(
                Urls.assetSettingsVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID);
        return manageAssetConfigurationResponse;
      } else {
        queryMap["pageSize"] = pageSize.toString();
        queryMap["pageNumber"] = pageNumber.toString();
        queryMap["sortColumn"] = "assetId";
        if (searchKeyword.isNotEmpty) {
          queryMap["filterName"] = "all";
          queryMap["filterValue"] = searchKeyword;
        }
        if (deviceTypeSelected.isNotEmpty && deviceTypeSelected != "ALL") {
          queryMap["deviceType"] = deviceTypeSelected;
        }
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSix().getAssetSettingsListData(
                Urls.assetSettings +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return manageAssetConfigurationResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AddSettings> getFuelBurnRateSettingsData(
      idleValue, workingValue, assetUid) async {
    Logger().i("getFuelBurnRateSettingsData");
    AssetFuelBurnRateSetting listBurnRateData = AssetFuelBurnRateSetting(
        idleTargetValue: idleValue,
        workTargetValue: workingValue,
        assetUIds: assetUid);
    try {
      if (isVisionLink) {
        Logger().i(listBurnRateData.toJson());
        AddSettings addSettings = await MyApi()
            .getClientSeven()
            .getassetSettingsFuelBurnRateDataVL(
                Urls.assetSettingsFuelBurnrateVL,
                listBurnRateData,
                accountSelected.CustomerUID);
        return addSettings;
      } else {
        AddSettings addSettings = await MyApi()
            .getClientSix()
            .getassetSettingsFuelBurnRateData(
                Urls.assetSettingsFuelBurnrate,
                listBurnRateData,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return addSettings;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<dynamic> getAssetTargetSettingsData(
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

      if (isVisionLink) {
        var result = await MyApi()
            .getClientSeven()
            .getAssetTargetSettingsDataVL(Urls.assetSettingsTarget,
                listSettingTargetData, accountSelected.CustomerUID);
        Logger().i(result);

        return result;
      } else {
        EstimatedAssetSetting result = await MyApi()
            .getClientSix()
            .getAssetTargetSettingsData(
                Urls.assetSettingsTargetListData,
                listSettingTargetData,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
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
            endDate: endDate));
      }
      Logger().i("payLoad:$assetUid");
      EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoadListData =
          EstimatedCycleVolumePayLoad(
              assetProductivitySettings: getAssetPayLoadList);
      if (isVisionLink) {
        EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad = await MyApi()
            .getClientSeven()
            .getEstimatedCycleVolumePayLoadDataVL(
                Urls.estimatedCycleVolumePayLoad,
                estimatedCycleVolumePayLoadListData,
                accountSelected.CustomerUID);
        return estimatedCycleVolumePayLoad;
      } else {
        EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad = await MyApi()
            .getClient()
            .getEstimatedCycleVolumePayLoadData(
                Urls.assetProductivitySettings,
                estimatedCycleVolumePayLoadListData,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
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
            .getMileageDataVL(Urls.estimatedMileageVL, mileageData,
                accountSelected.CustomerUID);
        return assetMileageSettingData;
      } else {
        AssetMileageSettingData assetMileageSettingData = await MyApi()
            .getClientSix()
            .getMileageData(
                Urls.estimatedMileage,
                mileageData,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetMileageSettingData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<EstimatedAssetSetting> getEstimatedTargetSettingListData(
      List<String> assetUids) async {
    String startdate = Utils.getLastReportedDateFilterData(
        DateTime.utc(2021, DateTime.september, 12));
    String endDate = Utils.getLastReportedDateFilterData(
        DateTime.utc(2022, DateTime.february, 05));
    try {
      Map<String, String> queryMap = Map();
      queryMap["endDate"] = endDate;
      queryMap["startDate"] = startdate;

      if (isVisionLink) {
        EstimatedAssetSetting assetSettingsDataResponse = await MyApi()
            .getClientSeven()
            .getEstimatedTagetListData(
                Urls.getEstimatedAsetSettingTargetDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected.CustomerUID);

        return assetSettingsDataResponse;
      } else {
        EstimatedAssetSetting assetSettingsDataResponse = await MyApi()
            .getClientSix()
            .getEstimatedTagetListData(Urls.estimatedTargetSettingsData,
                assetUids, "in-vlmasterdata-api-vlmd-assetsettings");
        return assetSettingsDataResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadListData(
      List<String> assetUids) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["startDate"] = Utils.getLastReportedDateFilterData(
          DateTime.utc(2021, DateTime.september, 19));
      queryMap["endDate"] = Utils.getLastReportedDateFilterData(
          DateTime.utc(2022, DateTime.november, 15));
      if (isVisionLink) {
        EstimatedCycleVolumePayLoad assetSettingsData = await MyApi()
            .getClientSeven()
            .getEstimatedCyclePayLoadVoumeListData(
                Urls.getEstimatedCycleVoumePayLoadListDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected.CustomerUID);
        return assetSettingsData;
      } else {
        EstimatedCycleVolumePayLoad assetSettingsData = await MyApi()
            .getClient()
            .getEstimatedCyclePayLoadVoumeListData(
                Urls.getEstimatedCycleVoumePayLoadListDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected.CustomerUID);
        return assetSettingsData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  getAssetIconData(String actionUTC, String assetUID, int iconKey,
      int legacyAssetID, modelYear) async {
    try {
      if (isVisionLink) {
        var assetIconData = await MyApi().getClientSeven().getAssetIconDataVL(
            Urls.getAssetIconVL,
            AssetIconPayLoad(
                actionUTC: actionUTC,
                assetUID: assetUID,
                iconKey: iconKey,
                legacyAssetID: legacyAssetID,
                modelYear: modelYear),
            accountSelected.CustomerUID);
        return assetIconData;
      } else {
        var assetIconData = await MyApi().getClientSix().getAssetIconData(
            Urls.assetIconData,
            AssetIconPayLoad(
                actionUTC: actionUTC,
                assetUID: assetUID,
                iconKey: iconKey,
                legacyAssetID: legacyAssetID,
                modelYear: modelYear),
            accountSelected.CustomerUID,
            "in-vlmasterdata-api-vlmd-asset");

        return assetIconData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<AssetFuelBurnRateSettingsListData> getAssetFuelBurnRateListData(
      List<String> assetUId) async {
    try {
      if (isVisionLink) {
        AssetFuelBurnRateSettingsListData assetFuelBurnRateSettingsListData =
            await MyApi()
                .getClientSeven()
                .getAssetFuelBurnRateSettingsListDataVL(
                    Urls.getAssetFuelBurnRateListDataVL,
                    assetUId,
                    accountSelected.CustomerUID);
        return assetFuelBurnRateSettingsListData;
      } else {
        AssetFuelBurnRateSettingsListData assetFuelBurnRateSettingsListData =
            await MyApi().getClientSix().getAssetFuelBurnRateSettingsListData(
                Urls.estimatedfuelBurnRateData,
                assetUId,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetFuelBurnRateSettingsListData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetMileageSettingsListData> getAssetMileageSettingsListData(
      List<String> assetUid) async {
    try {
      if (isVisionLink) {
        AssetMileageSettingsListData assetMileageSettingsListData =
            await MyApi().getClientSeven().getAssetMileageSettingsListDataVL(
                Urls.getAssetMileageListDataVL,
                assetUid,
                accountSelected.CustomerUID);
        return assetMileageSettingsListData;
      } else {
        AssetMileageSettingsListData assetMileageSettingsListData =
            await MyApi().getClientSix().getAssetMileageSettingsListData(
                Urls.estimatedMileageData,
                assetUid,
                accountSelected.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetMileageSettingsListData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
