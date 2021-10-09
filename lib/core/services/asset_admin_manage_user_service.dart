import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

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
                "Bearer" + " " + await _localService.getToken(),
                (await _localService.getLoggedInUser()).sub);
        return adminManageUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
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
      applicationName) async {
    try {
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .updateUserData(
                Urls.adminManagerUserSumaryVL,
                accountSelected.CustomerUID,
                UpdateUserData(
                    fname: firstName,
                    lname: lastName,
                    email: email,
                    phone: phoneNumber,
                    isCatssoUserCreation: false,
                    src: "VisionLink",
                    address:
                        AddressData(
                            address: address,
                            state: state,
                            country: country,
                            zipcode: zipcode),
                    roles: [
                      Role(role_id: 86, application_name: applicationName)
                    ],
                    details: Details(
                        job_title: jobTitle,
                        job_type: jobType,
                        user_type: userType)));

        return updateResponse;
      } else {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .updateUserData(
                Urls.adminManagerUserSumaryVL,
                accountSelected.CustomerUID,
                UpdateUserData(
                    fname: firstName,
                    lname: lastName,
                    email: email,
                    phone: phoneNumber,
                    isCatssoUserCreation: false,
                    src: "VisionLink",
                    address:
                        AddressData(
                            address: address,
                            state: state,
                            country: country,
                            zipcode: zipcode),
                    roles: [
                      Role(role_id: 86, application_name: applicationName)
                    ],
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
      applicationName) async {
    try {
      if (isVisionLink) {
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
                    address: address,
                    state: state,
                    country: country,
                    zipcode: zipcode),
                roles: [Role(role_id: 86, application_name: applicationName)],
                details: Details(
                    job_title: jobTitle,
                    job_type: jobType,
                    user_type: userType)));
        return addUserResponse;
      } else {
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
                    address: address,
                    state: state,
                    country: country,
                    zipcode: zipcode),
                roles: [Role(role_id: 86, application_name: applicationName)],
                details: Details(
                    job_title: jobTitle,
                    job_type: jobType,
                    user_type: userType)));
        return addUserResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<dynamic> deleteUsers(users) async {
    var result = await MyApi().getClientSeven().deleteUsersData(
        Urls.adminManagerUserSumaryVL,
        accountSelected.CustomerUID,
        DeleteUserData(users: users));
    return result;
  }
}