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

  Future<AssetLocationHistory> getAssetLocationHistory(
      String endTimeLocal, String startTimeLocal) async {
    try {
      AssetLocationHistory locationHistoryResponse = await MyApi()
          .getClient()
          .assetLocationHistoryDetail(
              endTimeLocal, startTimeLocal, accountSelected.CustomerUID);
      return locationHistoryResponse != null ? locationHistoryResponse : null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
