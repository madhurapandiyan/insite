import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'local_service.dart';

class FleetService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  Customer? accountSelected;
  Customer? customerSelected;
  FleetService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<FleetSummaryResponse?> getFleetSummaryList(
    startDate,
    endDate,
    pageSize,
    pageNumber,
    query,
    List<FilterData?>? appliedFilters,
  ) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
            query,
            accountSelected!.CustomerUID,
            (await _localService!.getLoggedInUser())!.sub);
        Logger().wtf(data.data!['fleetSummary']);
        FleetSummaryResponse fleetSummaryResponse =
            FleetSummaryResponse.fromJson(data.data!['fleetSummary']);
            Logger().w(fleetSummaryResponse.fleetRecords!.first.toJson());
        return fleetSummaryResponse;
      } else {
        if (isVisionLink) {
          FleetSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.fleetSummaryURLVL(
                      Urls.fleetSummaryVL +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected!.CustomerUID,
                              "assetid",
                              appliedFilters!,
                              ScreenType.FLEET),
                      accountSelected!.CustomerUID)
                  : await MyApi().getClient()!.fleetSummaryURLVL(
                        Urls.fleetSummaryVL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNumber,
                                pageSize,
                                null,
                                "assetid",
                                appliedFilters!,
                                ScreenType.FLEET),
                        accountSelected!.CustomerUID,
                      );
          Logger().wtf(accountSelected!.CustomerUID);
          return fleetSummaryResponse;
        } else {
          FleetSummaryResponse fleetSummaryResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.fleetSummaryURL(
                      Urls.fleetSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected!.CustomerUID,
                              "assetid",
                              appliedFilters!,
                              ScreenType.FLEET),
                      accountSelected!.CustomerUID,
                      "in-vfleet-uf-webapi")
                  : await MyApi().getClient()!.fleetSummaryURL(
                      Urls.fleetSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              "assetid",
                              appliedFilters!,
                              ScreenType.FLEET),
                      accountSelected!.CustomerUID,
                      "in-vfleet-uf-webapi");
          Logger().wtf(fleetSummaryResponse);
          return fleetSummaryResponse;
        }
      }
    } catch (e) {
      throw e;
      // return null;
    }
  }

  //sample url
  //https://unifiedfleet.myvisionlink.com/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2
  //?assetstatus=Asset+Off&deviceType=TAP76&endDateLocal=06%2F17%2F21&fuelLevelPercentLT=25&idleEfficiencyGT=25
  //&manufacturer=TATA+HITACHI&model=5T+WL&pageNumber=1&pageSize=50&productfamily=BACKHOE+LOADER&sort=assetid&startDateLocal=06%2F14%2F21&subscription=Basic
}
