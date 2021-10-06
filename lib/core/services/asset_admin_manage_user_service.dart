import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
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
        queryMap["sort"] = "";
        AdminManageUser adminManageUserResponse = await MyApi()
            .getClientSeven()
            .getAdminManagerUserListDataVL(
                Urls.adminManagerUserSumaryVL +
                    FilterUtils.constructQueryFromMap(queryMap),
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
                Urls.applicationsUrlVL +
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
      firstName, lastName, email, jobTitle, jobType, userType) async {
    try {
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .getSaveUserData(
                Urls.adminManagerUserSumaryVL,
                accountSelected.CustomerUID,
                UpdateUserData(
                    fname: firstName,
                    lname: lastName,
                    email: email,
                    isCatssoUserCreation: false,
                    src: "VisionLink",
                    roles: [
                      Role(roleId: 86, applicationName: "Prod-VLUnifiedFleet")
                    ],
                    // address: Address(),
                    details: Details(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        userType: userType)));

        return updateResponse;
      } else {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()
            .getSaveUserData(Urls.adminManagerUserSumaryVL,
                accountSelected.CustomerUID, UpdateUserData());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
