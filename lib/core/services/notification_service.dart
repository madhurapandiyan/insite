import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_notification_payload.dart';

import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/update_user_data.dart';
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
    if (isVisionLink) {
      try {
        ManageNotificationsData? response = await MyApi()
            .getClientSeven()!
            .manageNotificationsData(
                Urls.manageNotificationsData, accountSelected!.CustomerUID);

        return response;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<ManageNotificationsData?> getsearchNotificationsData(
      String? searchText) async {
    if (isVisionLink) {
      try {
        Map<String, String> queryMap = Map();

        queryMap["searchKey"] = searchText!;
        ManageNotificationsData? response = await MyApi()
            .getClientSeven()!
            .manageNotificationsData(
                Urls.manageNotificationsData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);

        return response;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<AlertTypes?> getNotificationTypes() async {
    if (isVisionLink) {
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

  Future<ZoneValues?> getInclusionExclusionZones() async {
    if (isVisionLink) {
      try {
        ZoneValues? response = await MyApi()
            .getClientSeven()!
            .getCustomerInclusionExclusion(
                Urls.getCustomerZones, accountSelected!.CustomerUID);

        return response;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<NotificationExist?> checkNotificationTitle(String? value) async {
    if (isVisionLink) {
      try {
        Map<String, String> queryMap = Map();

        queryMap["alertTitle"] = value!;
        NotificationExist? response = await MyApi()
            .getClientSeven()!
            .checkNotificationExist(
                Urls.checkIfNotificationNameExists +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);

        return response;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<NotificationAdded?> addNewNotification(
      AddNotificationPayLoad addNotificationPayLoad) async {
    if (isVisionLink) {
      try {
        NotificationAdded? response = await MyApi()
            .getClientSeven()!
            .addNotificationSaveData(Urls.saveNewNotificationData,
                addNotificationPayLoad, accountSelected!.CustomerUID);

        return response;
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  Future<UpdateResponse?> getDeleteNotification(String notificationId) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["notificationUID"] = notificationId;
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientFour()!
            .deleteNotification(
                Urls.deleteNotification +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {}
    return null;
  }
}
