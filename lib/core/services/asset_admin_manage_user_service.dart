import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class AssetAdminManagerUserService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;

  AssetAdminManagerUserService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
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
        queryMap["pageNumber: "] = pageNumber.toString();
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
}
