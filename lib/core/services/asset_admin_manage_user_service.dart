import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_group_data_response.dart';
import 'package:insite/core/models/edit_group_payload.dart';
import 'package:insite/core/models/add_group_payload.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings_list_data.dart';
import 'package:insite/core/models/asset_mileage_settings_list_data.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/estimated_cycle_volume_payload.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/favorite_payload.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/role_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/models/user.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/asset_icon_payload.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/models/asset_mileage_settings.dart';
import 'package:insite/core/models/device_type.dart';

class AssetAdminManagerUserService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();

  Customer? accountSelected;
  Customer? customerSelected;

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
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AdminManageUser?> getAdminManageUserListData(pageNumber,
      String searchKey, List<FilterData?>? appliedFilters, String query) async {
    Logger().i(
        "getAdminManageUserListData $isVisionLink filters count ${appliedFilters!.length}");
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      if (searchKey.isNotEmpty) {
        queryMap["searchKey"] = searchKey;
      }
      if (customerSelected != null) {
        queryMap["customerUid"] = customerSelected!.CustomerUID!;
      }
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            query,
            accountSelected?.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);
        AdminManageUser adminManageUserResponse =
            AdminManageUser.fromJson(data.data["userManagementUserList"]);
        return adminManageUserResponse;
      }
      if (isVisionLink) {
        queryMap["sort"] = "";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()!
            .getAdminManagerUserListDataVL(
                Urls.adminManagerUserSumaryVL +
                    FilterUtils.constructQueryFromMap(queryMap) +
                    FilterUtils.getUserFilterURL(appliedFilters),
                accountSelected!.CustomerUID);
        return adminManageUserResponse;
      } else {
        queryMap["sort"] = "Email";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClient()!
            .getAdminManagerUserListData(
                Urls.adminManagerUserSumary +
                    "/List" +
                    FilterUtils.constructQueryFromMap(queryMap) +
                    FilterUtils.getUserFilterURL(appliedFilters),
                accountSelected!.CustomerUID,
                Urls.userCountPrefix);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<ManageUser?> getUser(String? userId) async {
    Logger().i("getUser $isVisionLink");
    try {
      if (isVisionLink) {
        Map<String, String?> queryMap = Map();
        if (customerSelected != null) {
          queryMap["customerUid"] = customerSelected!.CustomerUID;
        }
        ManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()!
            .getUser(
                Urls.adminManagerUserSumaryVL +
                    "/" +
                    userId! +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return adminManageUserResponse;
      } else {
        Map<String, String?> queryMap = Map();
        if (customerSelected != null) {
          queryMap["customerUid"] = customerSelected!.CustomerUID;
        }
        ManageUser adminManageUserResponse = await MyApi().getClient()!.getUser(
            Urls.adminManagerUserSumary +
                "/" +
                userId! +
                FilterUtils.constructQueryFromMap(queryMap),
            accountSelected!.CustomerUID);
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
        queryMap["customerUid"] = customerSelected!.CustomerUID!;
      }
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            graphqlSchemaService!.checkUserMailId(mail),
            accountSelected?.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);
        Logger().w(data.data);
        CheckUserResponse responce =
            CheckUserResponse.fromJson(data.data["userEmail"]);
        return responce;
      }
      if (isVisionLink) {
        CheckUserResponse response = await MyApi()
            .getClientSeven()!
            .checkUserVL(
                Urls.adminManagerUserSumaryVL +
                    "/List" +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return response;
      } else {
        CheckUserResponse response = await MyApi().getClient()!.checkUser(
            Urls.adminManagerUserSumary +
                "/List" +
                FilterUtils.constructQueryFromMap(queryMap),
            Urls.userCountPrefix,
            accountSelected!.CustomerUID);
        return response;
      }
    } catch (e) {
      Logger().e(e.toString());
      return CheckUserResponse(users: []);
    }
  }

  Future<ApplicationData?> getApplicationsData() async {
    Logger().i("getApplicationsData");
    try {
      if (isVisionLink) {
        Map<String, String?> queryMap = Map();
        if (accountSelected != null) {
          queryMap["CustomerUID"] = accountSelected!.CustomerUID;
        }
        ApplicationData adminManageUserResponse = await MyApi()
            .getClientSeven()!
            .getApplicationsData(
                Urls.applicationsUrlVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
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
        Map<String, String?> queryMap = Map();
        if (accountSelected != null) {
          queryMap["CustomerUID"] = accountSelected!.CustomerUID;
        }
        ApplicationData adminManageUserResponse = await MyApi()
            .getClientSeven()!
            .getApplicationsData(
                Urls.applicationsUrl +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<UpdateResponse?> getSaveUserData(
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
            .getClientSeven()!
            .updateUserData(
                Urls.adminManagerUserSumaryVL + "/" + userUid,
                accountSelected!.CustomerUID,
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
            .getClient()!
            .updateUserData(
                Urls.adminManagerUserSumaryVL + "/" + userUid,
                accountSelected!.CustomerUID,
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

  Future<RoleDataResponse?> getRoles(String? appName) async {
    Logger().i("getRoles $appName");
    Logger().i("getRoles ${roleData.length}");
    try {
      if (isVisionLink) {
        var result = await MyApi().getClientSeven()!.roles(
              Urls.adminRolesVL + "/" + appName! + "/roles",
              accountSelected!.CustomerUID,
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

  Future<AddUser?> getAddUserData(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? jobTitle,
      int? jobType,
      String? address,
      String? state,
      String? country,
      String? zipcode,
      String? userType,
      String? sso_id,
      roles}) async {
    Logger().i("getAddUserData");
    try {
      if (enableGraphQl) {
        String doubleQuote = "\"";
        Logger().w(
          customerSelected != null
              ? customerSelected!.CustomerUID
              : accountSelected!.CustomerUID,
        );
        var data = await Network().getGraphqlData(
            graphqlSchemaService!.addUser(
                firstName: firstName,
                jobType: jobType,
                lastName: lastName,
                customerUid: customerSelected != null
                    ? customerSelected!.CustomerUID
                    : accountSelected!.CustomerUID,
                emailId: email,
                phoneNo: phoneNumber == null ? "" : phoneNumber,
                role: roles,
                addressData: AddressData(
                    addressline1: doubleQuote +
                        "${address == null ? "" : address}" +
                        doubleQuote,
                    state: doubleQuote +
                        "${state == null ? "" : state}" +
                        doubleQuote,
                    addressline2: "\"\"",
                    country: doubleQuote +
                        "${country == null ? "" : country}" +
                        doubleQuote,
                    zipcode: doubleQuote +
                        "${zipcode == null ? "" : zipcode}" +
                        doubleQuote),
                details:
                    Details(user_type: doubleQuote + "Standard" + doubleQuote)),
            accountSelected?.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);
        Logger().i(data);
        return AddUser.fromJson(data.data["userManagementCreateUser"]);
      }
      if (isVisionLink) {
        Logger().d(
            "address ${AddressData(addressline1: address, state: state, country: country, zipcode: zipcode).toJson()}");
        Logger().d(
            "details ${Details(job_title: jobTitle, job_type: jobType.toString(), user_type: userType).toJson()}");
        AddUser addUserResponse = await MyApi().getClientSeven()!.addUserData(
            Urls.addUserSummaryVL,
            accountSelected!.CustomerUID,
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
                    job_type: jobType.toString(),
                    user_type: userType)));
        return addUserResponse;
      } else {
        Logger().d(
            "address ${AddressData(addressline1: address, state: state, country: country, zipcode: zipcode).toJson()}");
        Logger().d(
            "details ${Details(job_title: jobTitle, job_type: jobType.toString(), user_type: userType).toJson()}");
        Logger().w(AddUserDataIndStack(
                fname: firstName,
                customerUid: customerSelected != null
                    ? customerSelected!.CustomerUID
                    : accountSelected!.CustomerUID,
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
                    job_type: jobType.toString(),
                    user_type: "Standard"))
            .toJson());
        AddUser addUserResponse = await MyApi().getClient()!.inviteUser(
            Urls.adminManagerUserSumary + "/Invite",
            AddUserDataIndStack(
                fname: firstName,
                customerUid: customerSelected != null
                    ? customerSelected!.CustomerUID
                    : accountSelected!.CustomerUID,
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
                    job_type: jobType.toString(),
                    user_type: "Standard")),
            accountSelected!.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub,
            "in-identitymanager-identitywebapi");
        return addUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<dynamic> deleteUsers(List<String> users) async {
    Logger().i("deleteUsers");
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            graphqlSchemaService!
                .deleteUser(users, accountSelected!.CustomerUID!),
            accountSelected!.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);
        Logger().e(data);
        return data;
      }
      if (isVisionLink) {
        var result = await MyApi().getClientSeven()!.deleteUsersData(
            Urls.adminManagerUserSumaryVL,
            accountSelected!.CustomerUID,
            customerSelected != null
                ? DeleteUserDataIndStack(
                        users: users,
                        customerUid: customerSelected!.CustomerUID)
                    .toJson()
                : DeleteUserData(users: users).toJson());
        return result;
      } else {
        var result = await MyApi().getClient()!.deleteUsers(
            Urls.adminManagerUserSumary,
            customerSelected != null
                ? DeleteUserDataIndStack(
                        users: users,
                        customerUid: customerSelected!.CustomerUID)
                    .toJson()
                : DeleteUserData(users: users).toJson(),
            accountSelected!.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub,
            "in-identitymanager-identitywebapi");
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<ListDeviceTypeResponse?> getDeviceTypes() async {
    try {
      DeviceTypeRequest request =
          DeviceTypeRequest(allAssets: true, assetUID: []);
      if (isVisionLink) {
        ListDeviceTypeResponse response = await MyApi()
            .getClientSeven()!
            .getDeviceTypeVL(
                Urls.deviceTypeVL, request, accountSelected!.CustomerUID);
        return response;
      } else {
        ListDeviceTypeResponse response =
            await MyApi().getClientSix()!.getDeviceType(
                  Urls.deviceTypes,
                  request,
                  Urls.assetSettingsPrefix,
                  accountSelected!.CustomerUID,
                );
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ManageAssetConfiguration?> getAssetSettingData(pageSize, pageNumber,
      String searchKeyword, String deviceTypeSelected) async {
    Logger().i("getAssetSettingData");
    try {
      Map<String, String> queryMap = Map();
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
      if (customerSelected != null) {
        queryMap["subAccountCustomerUid"] = customerSelected!.CustomerUID!;
      }
      if (isVisionLink) {
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSeven()!.getAssetSettingsListDataVL(
                Urls.assetSettingsVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return manageAssetConfigurationResponse;
      } else {
        ManageAssetConfiguration manageAssetConfigurationResponse =
            await MyApi().getClientSix()!.getAssetSettingsListData(
                Urls.assetSettings +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return manageAssetConfigurationResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AddSettings?> getFuelBurnRateSettingsData(
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
            .getClientSeven()!
            .getassetSettingsFuelBurnRateDataVL(
                Urls.assetSettingsFuelBurnrateVL,
                listBurnRateData,
                accountSelected!.CustomerUID);
        return addSettings;
      } else {
        AddSettings addSettings = await MyApi()
            .getClientSix()!
            .getassetSettingsFuelBurnRateData(
                Urls.assetSettingsFuelBurnrate,
                listBurnRateData,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return addSettings;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<dynamic> getAssetTargetSettingsData(
      List<String?> assetUid, startDate, endDate, idle, runTime) async {
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
            .getClientSeven()!
            .getAssetTargetSettingsDataVL(Urls.assetSettingsTarget,
                listSettingTargetData, accountSelected!.CustomerUID);
        Logger().i(result);

        return result;
      } else {
        EstimatedAssetSetting result = await MyApi()
            .getClientSix()!
            .getAssetTargetSettingsData(
                Urls.assetSettingsTargetListData,
                listSettingTargetData,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<EstimatedCycleVolumePayLoad?> getEstimatedCycleVolumePayLoad(
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
            .getClientSeven()!
            .getEstimatedCycleVolumePayLoadDataVL(
                Urls.estimatedCycleVolumePayLoad,
                estimatedCycleVolumePayLoadListData,
                accountSelected!.CustomerUID);
        return estimatedCycleVolumePayLoad;
      } else {
        EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad = await MyApi()
            .getClient()!
            .getEstimatedCycleVolumePayLoadData(
                Urls.assetProductivitySettings,
                estimatedCycleVolumePayLoadListData,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return estimatedCycleVolumePayLoad;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetMileageSettingData?> getAssetMileageData(
      List<String?>? assetUid, targetValue) async {
    var mileageData =
        AssetMileageSettingData(assetUIds: assetUid, targetValue: targetValue);
    Logger().i(assetUid);
    try {
      if (isVisionLink) {
        AssetMileageSettingData assetMileageSettingData = await MyApi()
            .getClientSeven()!
            .getMileageDataVL(Urls.estimatedMileageVL, mileageData,
                accountSelected!.CustomerUID);
        return assetMileageSettingData;
      } else {
        AssetMileageSettingData assetMileageSettingData = await MyApi()
            .getClientSix()!
            .getMileageData(
                Urls.estimatedMileage,
                mileageData,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetMileageSettingData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<EstimatedAssetSetting?> getEstimatedTargetSettingListData(
      List<String?>? assetUids) async {
    String? startdate = Utils.getLastReportedDateFilterData(
        DateTime.utc(2021, DateTime.september, 12));
    String? endDate = Utils.getLastReportedDateFilterData(
        DateTime.utc(2022, DateTime.february, 05));
    try {
      Map<String, String?> queryMap = Map();
      queryMap["endDate"] = endDate;
      queryMap["startDate"] = startdate;

      if (isVisionLink) {
        EstimatedAssetSetting assetSettingsDataResponse = await MyApi()
            .getClientSeven()!
            .getEstimatedTagetListData(
                Urls.getEstimatedAsetSettingTargetDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected!.CustomerUID);

        return assetSettingsDataResponse;
      } else {
        EstimatedAssetSetting assetSettingsDataResponse = await MyApi()
            .getClientSix()!
            .getEstimatedTagetListData(Urls.estimatedTargetSettingsData,
                assetUids, "in-vlmasterdata-api-vlmd-assetsettings");
        return assetSettingsDataResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<EstimatedCycleVolumePayLoad?> getEstimatedCycleVolumePayLoadListData(
      List<String>? assetUids) async {
    try {
      Map<String, String?> queryMap = Map();
      queryMap["startDate"] = Utils.getLastReportedDateFilterData(
          DateTime.utc(2021, DateTime.september, 19));
      queryMap["endDate"] = Utils.getLastReportedDateFilterData(
          DateTime.utc(2022, DateTime.november, 15));
      if (isVisionLink) {
        EstimatedCycleVolumePayLoad assetSettingsData = await MyApi()
            .getClientSeven()!
            .getEstimatedCyclePayLoadVoumeListData(
                Urls.getEstimatedCycleVoumePayLoadListDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected!.CustomerUID);
        return assetSettingsData;
      } else {
        EstimatedCycleVolumePayLoad assetSettingsData = await MyApi()
            .getClient()!
            .getEstimatedCyclePayLoadVoumeListData(
                Urls.getEstimatedCycleVoumePayLoadListDataVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                assetUids,
                accountSelected!.CustomerUID);
        return assetSettingsData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  getAssetIconData(String actionUTC, String? assetUID, int iconKey,
      int legacyAssetID, modelYear) async {
    try {
      if (isVisionLink) {
        var assetIconData = await MyApi().getClientSeven()!.getAssetIconDataVL(
            Urls.getAssetIconVL,
            AssetIconPayLoad(
                actionUTC: actionUTC,
                assetUID: assetUID,
                iconKey: iconKey,
                legacyAssetID: legacyAssetID,
                modelYear: modelYear),
            accountSelected!.CustomerUID);
        return assetIconData;
      } else {
        var assetIconData = await MyApi().getClientSix()!.getAssetIconData(
            Urls.assetIconData,
            AssetIconPayLoad(
                actionUTC: actionUTC,
                assetUID: assetUID,
                iconKey: iconKey,
                legacyAssetID: legacyAssetID,
                modelYear: modelYear),
            accountSelected!.CustomerUID,
            "in-vlmasterdata-api-vlmd-asset");

        return assetIconData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<AssetFuelBurnRateSettingsListData?> getAssetFuelBurnRateListData(
      List<String?>? assetUId) async {
    try {
      if (isVisionLink) {
        AssetFuelBurnRateSettingsListData assetFuelBurnRateSettingsListData =
            await MyApi()
                .getClientSeven()!
                .getAssetFuelBurnRateSettingsListDataVL(
                    Urls.getAssetFuelBurnRateListDataVL,
                    assetUId,
                    accountSelected!.CustomerUID);
        return assetFuelBurnRateSettingsListData;
      } else {
        AssetFuelBurnRateSettingsListData assetFuelBurnRateSettingsListData =
            await MyApi().getClientSix()!.getAssetFuelBurnRateSettingsListData(
                Urls.estimatedfuelBurnRateData,
                assetUId,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetFuelBurnRateSettingsListData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetMileageSettingsListData?> getAssetMileageSettingsListData(
      List<String?>? assetUid) async {
    try {
      if (isVisionLink) {
        AssetMileageSettingsListData assetMileageSettingsListData =
            await MyApi().getClientSeven()!.getAssetMileageSettingsListDataVL(
                Urls.getAssetMileageListDataVL,
                assetUid,
                accountSelected!.CustomerUID);
        return assetMileageSettingsListData;
      } else {
        AssetMileageSettingsListData assetMileageSettingsListData =
            await MyApi().getClientSix()!.getAssetMileageSettingsListData(
                Urls.estimatedMileageData,
                assetUid,
                accountSelected!.CustomerUID,
                "in-vlmasterdata-api-vlmd-assetsettings");
        return assetMileageSettingsListData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetGroupSummaryResponse?> getGroupListData() async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = "1";
      queryMap["pageSize"] = "99999";
      queryMap["minimalFields"] = "true";
      // if (customerSelected != null) {
      //   queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
      //   Logger().wtf(customerSelected!.CustomerUID);
      // }

      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getGroupListData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetCount?> getGeofenceCountData() async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["grouping"] = "geofence";
      if (isVisionLink) {
        AssetCount assetCountResponse = await MyApi()
            .getClientSeven()!
            .getGeoFenceCountData(
                Urls.getGeoFenceData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return assetCountResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<ManageGroupSummaryResponse?> getManageGroupSummaryResponseListData(
      pageNumber, searckKey) async {
    try {
      Map<String, String?> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["Sort"] = "";
      queryMap["SearchKey"] = "GroupName";
      queryMap["SearchValue"] = searckKey.toString();

      if (isVisionLink) {
        ManageGroupSummaryResponse manageGroupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getManageGroupSummaryListData(
                Urls.getManageGroupData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return manageGroupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }

    return null;
  }

  Future<UpdateResponse?> getFavoriteGroupData(
      List<String> groupId, isFavourite) async {
    try {
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()!
            .getGroupFavoriteData(
                Urls.getManageGroupData + "/Favourite",
                FavoritePayLoad(groupUID: groupId, isFavourite: isFavourite),
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<UpdateResponse?> getDeleteFavoriteData(String groupId) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["GroupUID"] = groupId;
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()!
            .getDeleteFavoriteData(
                Urls.getManageGroupData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {}
    return null;
  }

  Future<AssetGroupSummaryResponse?> getAdminProductFamilyFilterData(
      pageNumber, pageSize, String productFamilyKey) async {
    try {
      // Logger().e(productFamilyKey);
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["pageSize"] = pageSize.toString();
      queryMap["minimalFields"] = "true";

      queryMap["productfamily"] = productFamilyKey.toString();
      if (customerSelected != null) {
        queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
        Logger().wtf(customerSelected!.CustomerUID);
      }

      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getAdminProductFamilyFilterData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetGroupSummaryResponse?> getManafactureFilterData(
      int? pageNumber, int? pageSize, String? productFamilyKey) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["pageSize"] = pageSize.toString();
      queryMap["minimalFields"] = "true";
      if (productFamilyKey != null) {
        queryMap["manufacturer"] = productFamilyKey;
      }
      if (customerSelected != null) {
        queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
        Logger().wtf(customerSelected!.CustomerUID);
      }
      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getManufacturerFilterData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetGroupSummaryResponse?> getModelFilterData(
      int? pageNumber, int? pageSize, String? productFamilyKey) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["pageSize"] = pageSize.toString();
      queryMap["minimalFields"] = "true";
      if (productFamilyKey != null) {
        queryMap["model"] = productFamilyKey;
      }
      if (customerSelected != null) {
        queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
        Logger().wtf(customerSelected!.CustomerUID);
      }
      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getManufacturerFilterData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {}
    return null;
  }

  Future<AssetGroupSummaryResponse?> getDeviceTypeData(
      int? pageNumber, int? pageSize, String? productFamilyKey) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["pageSize"] = pageSize.toString();
      queryMap["minimalFields"] = "true";
      queryMap["deviceType"] = productFamilyKey!;
      if (customerSelected != null) {
        queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
        Logger().wtf(customerSelected!.CustomerUID);
      }
      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getAdminProductFamilyFilterData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetGroupSummaryResponse?> getAccountSelectionData(
      int pageNumber, int pageSize, String productFamilyKey) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["pageNumber"] = pageNumber.toString();
      queryMap["pageSize"] = pageSize.toString();
      queryMap["minimalFields"] = "true";
      queryMap["customerIdentifier"] = productFamilyKey;
      if (customerSelected != null) {
        queryMap["customerIdentifier"] = customerSelected!.CustomerUID!;
        Logger().wtf(customerSelected!.CustomerUID);
      }
      if (isVisionLink) {
        AssetGroupSummaryResponse groupSummaryResponse = await MyApi()
            .getClientSeven()!
            .getAdminProductFamilyFilterData(
                Urls.getGroupListData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return groupSummaryResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AddGroupDataResponse?> getAddGroupSaveData(
      AddGroupPayLoad addGroupPayLoad) async {
    try {
      if (isVisionLink) {
        AddGroupDataResponse addGroupDataResponse = await MyApi()
            .getClientSeven()!
            .getAddGroupSaveData(Urls.getAddGroupSaveData, addGroupPayLoad,
                accountSelected!.CustomerUID);
        return addGroupDataResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<EditGroupResponse?> getEditGroupData(String groupId) async {
    try {
      Logger().w(groupId);
      if (isVisionLink) {
        EditGroupResponse editGroupResponse = await MyApi()
            .getClientSeven()!
            .getEditGroupResponseData(
                Urls.getEditGroupData + groupId, accountSelected!.CustomerUID);
        return editGroupResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<UpdateResponse?> getAddGroupEditPayLoad(
      EditGroupPayLoad addGroupEditPayload) async {
    try {
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()!
            .getAddGroupEditData(Urls.getEditGroupData, addGroupEditPayload,
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
