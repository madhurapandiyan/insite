import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class AssetLocationHistoryService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  String? notificationId;

  AssetLocationHistoryService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
      notificationId = await _localService!.getNotificationId();
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
      if (isVisionLink) {
        AssetLocationHistory locationHistoryResponse =
            await MyApi().getClient()!.assetLocationHistoryVL(
                  Urls.locationHistoryVL + assetUid! == null
                      ? notificationId!
                      : assetUid +
                          "/v2" +
                          getLocationHistoryUrl(startTimeLocal, endTimeLocal),
                  accountSelected!.CustomerUID,
                );
        return locationHistoryResponse != null ? locationHistoryResponse : null;
      } else {
        AssetLocationHistory locationHistoryResponse = await MyApi()
            .getClient()!
            .assetLocationHistory(
                Urls.locationHistory + assetUid! == null
                    ? notificationId!
                    : assetUid +
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
