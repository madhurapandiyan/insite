import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class AssetUtilizationService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  AssetUtilizationService() {
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

  Future<AssetUtilization> getAssetUtilGraphDate(
      String assetUID, String date) async {
    try {
      if (assetUID != null &&
          assetUID.isNotEmpty &&
          date != null &&
          date.isNotEmpty) {
        AssetUtilization result = await MyApi()
            .getClient()
            .assetUtilGraphData(assetUID, date, accountSelected.CustomerUID);
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<Utilization> getUtilizationResult(String startDate, String endDate,
      String sort, int pageNo, int pageCount) async {
    try {
      if (startDate != null &&
          startDate.isNotEmpty &&
          endDate != null &&
          endDate.isNotEmpty) {
        Utilization response = await MyApi().getClient().utilization(startDate,
            endDate, pageNo, pageCount, sort, accountSelected.CustomerUID);
        return response;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
