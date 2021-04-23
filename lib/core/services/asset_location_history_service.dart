import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class AssetLocationHistoryService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  AssetLocationHistoryService() {
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

  Future<AssetLocationHistory> getAssetLocationHistory() async {
    try {
      AssetLocationHistory locationHistoryResponse = await MyApi()
          .getClient()
          .assetLocationHistoryDetail('2021-04-21T23:59:59',
              '2021-04-19T00:00:00', 'd7ac4554-05f9-e311-8d69-d067e5fd4637');
      print('LOC: ${locationHistoryResponse.pagination.totalCount}');
      return locationHistoryResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
