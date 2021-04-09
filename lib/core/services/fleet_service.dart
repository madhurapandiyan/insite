import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';
import 'local_service.dart';

class FleetService extends BaseService {
  var _localService = locator<LocalService>();
  Customer accountSelected;
  Customer customerSelected;
  FleetService() {
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

  Future<List<Fleet>> getFleetSummaryList() async {
    try {
      FleetSummaryResponse fleetSummaryResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClient().fleetSummaryCI(
                  customerSelected.CustomerUID,
                  1,
                  500,
                  "assetid",
                  accountSelected.CustomerUID)
              : await MyApi()
                  .getClient()
                  .fleetSummary(1, 500, "assetid", accountSelected.CustomerUID);
      return fleetSummaryResponse.fleetRecords;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
