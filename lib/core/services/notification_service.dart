import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class NotificationService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  Customer? accountSelected;
  Customer? customerSelected;

  NotificationService() {
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
    if (isVisionLink) {
      try {
        Map<String, String> queryMap = Map();

        queryMap["notificationStatus"] = notificationStatus;
        queryMap["notificationUserStatus"] = notificationUserStatus;
        queryMap["fromDate"] =
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate);
        queryMap["toDate"] = Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate);

        NotificationsData? notificationsData = await MyApi()
            .getClientThree()!
            .mainNotificationsDataVL(
                Urls.mainNotificationUrl +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);

        return notificationsData;
      } catch (e) {
        Logger().e(e.toString());
      }
    } else {
      try {
        Map<String, String> queryMap = Map();

        queryMap["notificationStatus"] = notificationStatus;
        queryMap["notificationUserStatus"] = notificationUserStatus;
        queryMap["fromDate"] =
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate);
        queryMap["toDate"] = Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate);

        NotificationsData? notificationsData = await MyApi()
            .getClient()!
            .mainNotificationsData(
                Urls.indiaStackMainNotificationUrl +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.notificationPrefix);

        return notificationsData;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<ManageNotificationsData?> getManageNotificationsData() async {
    try {
      ManageNotificationsData? response = await MyApi()
          .getClientSeven()!
          .manageNotificationsData(
              Urls.manageNotificationsData, accountSelected?.CustomerUID);

      return response;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<AlertTypes?> getNotificationTypes() async {
    try {
      AlertTypes? response = await MyApi()
          .getClientSeven()!
          .getNotificationTypesData(
              Urls.getNotificationTypes, accountSelected!.CustomerUID);

      return response;
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
