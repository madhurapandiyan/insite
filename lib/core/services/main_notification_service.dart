import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class MainNotificationService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  Customer? accountSelected;
  Customer? customerSelected;

  MainNotificationService() {
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

  Future<NotificationsData?> getNotificationsData(
    notificationUserStatus,
    notificationStatus,
    startDate,
    endDate,
  ) async {
    try {
      Map<String, String> queryMap = Map();

      queryMap["notificationStatus"] = notificationStatus;
      queryMap["notificationUserStatus"] = notificationUserStatus;
      queryMap["fromDate"] =
          Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate);
      queryMap["toDate"] = Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate);

      NotificationsData? notificationsData = await MyApi()
          .getClientEleven()!
          .mainNotificationsData(
              Urls.mainNotificationUrl +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID);

      return notificationsData;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<Fleet?> getNotificationDetails(String assetUid) async {
    try {
      Map<String, String> queryMap = Map();

      queryMap["assetUID"] = assetUid;
      Fleet? fleetData = await MyApi().getClientThree()!.notificationsDetails(
          Urls.notificationDetails +
              FilterUtils.constructQueryFromMap(queryMap),
          accountSelected!.CustomerUID);

      return fleetData;
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
