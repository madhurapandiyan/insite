import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

import 'graphql_schemas_service.dart';

class AssetLocationHistoryService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();
  AssetLocationHistoryService() {
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

  Future<AssetLocationHistory?> getAssetLocationHistory(
    String? startTimeLocal,
    String? endTimeLocal,
    String? assetUid,
  ) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          _graphqlSchemaService!.singleAssetDetailLocation(),
          accountSelected?.CustomerUID,
          (await _localService!.getLoggedInUser())!.sub,
        );
        AssetLocationHistory locationHistoryResponse =
            AssetLocationHistory.fromJson(
                data.data["singleAssetLocationDetails"]);
        return locationHistoryResponse;
      }
      if (isVisionLink) {
        AssetLocationHistory locationHistoryResponse =
            await MyApi().getClient()!.assetLocationHistoryVL(
                  Urls.locationHistoryVL +
                      assetUid! +
                      "/v2" +
                      getLocationHistoryUrl(startTimeLocal, endTimeLocal),
                  accountSelected!.CustomerUID,
                );
        return locationHistoryResponse != null ? locationHistoryResponse : null;
      } else {
        AssetLocationHistory locationHistoryResponse = await MyApi()
            .getClient()!
            .assetLocationHistory(
                Urls.locationHistory +
                    assetUid! +
                    "/v2" +
                    getLocationHistoryUrl(startTimeLocal, endTimeLocal),
                accountSelected!.CustomerUID,
                Urls.fleetMapPrefix);
        return locationHistoryResponse != null ? locationHistoryResponse : null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  String getLocationHistoryUrl(startTimeLocal, endTimeLocal) {
    try {
      StringBuffer value = StringBuffer();
      value.write(
          constructQuery("startTimeLocal", startTimeLocal + 'T00:00:00', true));
      value.write(
          constructQuery("endTimeLocal", endTimeLocal + 'T23:59:59', false));
      value.write(constructQuery("pageNumber", "1", false));
      value.write(constructQuery("pageSize", "100", false));
      value.write(constructQuery("lastReported", false.toString(), false));
      return value.toString();
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
