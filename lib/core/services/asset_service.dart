import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

import '../locator.dart';

class AssetService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;

  AssetService() {
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

  Future<List<Asset>> getAssetSummaryList(startDate, endDate) async {
    try {
      AssetResponse assetResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClient().assetSummaryCI(
                  customerSelected.CustomerUID,
                  startDate,
                  endDate,
                  50,
                  1,
                  "assetid",
                  accountSelected.CustomerUID)
              : await MyApi().getClient().assetSummary(startDate, endDate, 50,
                  1, "assetid", accountSelected.CustomerUID);
      return assetResponse.assetOperations.assets;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
