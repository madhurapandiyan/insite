import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/home/home_view.dart';
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

  Future<FleetSummaryResponse> getFleetSummaryList(
    pageSize,
    pageNumber,
    List<FilterData> appliedFilters,
  ) async {
    try {
      FleetSummaryResponse fleetSummaryResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClient().fleetSummaryURL(
                  Urls.fleetSummary +
                      FilterUtils.getFilterURL(
                          null,
                          null,
                          pageNumber,
                          pageSize,
                          customerSelected.CustomerUID,
                          "assetid",
                          appliedFilters,
                          ScreenType.FLEET),
                  accountSelected.CustomerUID)
              : await MyApi().getClient().fleetSummaryURL(
                  Urls.fleetSummary +
                      FilterUtils.getFilterURL(null, null, pageNumber, pageSize,
                          null, "assetid", appliedFilters, ScreenType.FLEET),
                  accountSelected.CustomerUID);
      return fleetSummaryResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //sample url
  //https://unifiedfleet.myvisionlink.com/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2
  //?assetstatus=Asset+Off&deviceType=TAP76&endDateLocal=06%2F17%2F21&fuelLevelPercentLT=25&idleEfficiencyGT=25
  //&manufacturer=TATA+HITACHI&model=5T+WL&pageNumber=1&pageSize=50&productfamily=BACKHOE+LOADER&sort=assetid&startDateLocal=06%2F14%2F21&subscription=Basic
}
