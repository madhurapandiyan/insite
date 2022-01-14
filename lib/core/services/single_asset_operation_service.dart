import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class SingleAssetOperationService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  String? notificationId;

  SingleAssetOperationService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
      notificationId = await _localService!.getNotificationId();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<SingleAssetOperation?> getSingleAssetOperation(
      String? startDate, String? endDate, String? assetUID) async {
    try {
      Map<String, String> queryMap = Map();
      if (assetUID != null && assetUID.isNotEmpty) {
        queryMap["assetUid"] = assetUID;
      } else {
        queryMap["assetUid"] = notificationId!;
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryMap["endDate"] = endDate;
      }
      if (startDate != null && startDate.isNotEmpty) {
        queryMap["startDate"] = startDate;
      }
      if (isVisionLink) {
        Logger().d("single asset operation vl");
        SingleAssetOperation response = await MyApi()
            .getClient()!
            .singleAssetOperationVL(
                Urls.assetoperationsegmentsVL +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return response;
      } else {
        Logger().d("single asset operation ind");
        SingleAssetOperation response = await MyApi()
            .getClient()!
            .singleAssetOperation(
                Urls.assetoperationsegments +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                "in-vutilization-utz-webapi");
        return response;
      }
    } catch (e) {
      print(e);
      Logger().e(e);
      return null;
    }
  }
}
