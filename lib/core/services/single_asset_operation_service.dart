import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class SingleAssetOperationService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  SingleAssetOperationService() {
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

  Future<SingleAssetOperation> getSingleAssetOperation(
      String startDate, String endDate, String assetUID) async {
    try {
      if (isVisionLink) {
        if (assetUID != null &&
            assetUID.isNotEmpty &&
            startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          Logger().d("single asset operation");
          SingleAssetOperation response = await MyApi()
              .getClient()
              .singleAssetOperationVL(
                  startDate, endDate, assetUID, accountSelected.CustomerUID);
          return response;
        }
      } else {
        if (assetUID != null &&
            assetUID.isNotEmpty &&
            startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          Logger().d("single asset operation");
          SingleAssetOperation response = await MyApi()
              .getClient()
              .singleAssetOperation(startDate, endDate, assetUID,
                  accountSelected.CustomerUID, "in-vutilization-utz-webapi");
          return response;
        }
      }
      return null;
    } catch (e) {
      print(e);
      Logger().e(e);
      return null;
    }
  }
}
