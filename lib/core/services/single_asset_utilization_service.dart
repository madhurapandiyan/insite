import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  SingleAssetUtilizationService() {
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

  Future<SingleAssetUtilization> getSingleAssetUtilizationResult(
      String assetUID, String endDate, String startDate) async {
    try {
      if (assetUID != null &&
          assetUID.isNotEmpty &&
          startDate != null &&
          startDate.isNotEmpty &&
          endDate != null &&
          endDate.isNotEmpty) {
        SingleAssetUtilization response = await MyApi()
            .getClient()
            .singleAssetUtilization(assetUID, endDate, startDate,
                '75ab4554-05f9-e311-8d69-d067e5fd4637');

        print('@@@ RES: ${response.message}');
        return response;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
