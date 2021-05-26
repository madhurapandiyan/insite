import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
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
      Logger().d("account selected " + accountSelected.CustomerUID);
      Logger().d("customer selected " + customerSelected.CustomerUID);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<UtilizationData>> getUtilizationData() async {
    try {
      UtilizationSummaryResponse utilizationSummaryResponse = await MyApi()
          .getClient()
          .utilLizationList('64be6463-d8c1-11e7-80fc-065f15eda309', "04/19/21",
              "04/21/21", "d7ac4554-05f9-e311-8d69-d067e5fd4637");
      return utilizationSummaryResponse.utilization;
    } catch (e) {
      Logger().e(e);
      return [];
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
        Utilization response =
            accountSelected != null && customerSelected != null
                ? await MyApi().getClient().utilizationCustomer(
                    startDate,
                    endDate,
                    pageNo,
                    pageCount,
                    sort,
                    customerSelected.CustomerUID,
                    accountSelected.CustomerUID)
                : await MyApi().getClient().utilization(startDate, endDate,
                    pageNo, pageCount, sort, accountSelected.CustomerUID);
        return response;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
