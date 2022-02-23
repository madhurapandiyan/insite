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
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/fault_code_type_search.dart';
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

  Future<FaultCodeTypeSearch?> getFaultCodeTypeSearch(
      String queryValue, int pageValue, String faultCodeType) async {
    Map<String, String> queryMap = Map();
    queryMap["lang"] = "en-US";
    queryMap["page"] = pageValue.toString();
    if (faultCodeType.isNotEmpty) {
      queryMap["faultCodeType"] = faultCodeType;
    }
    if (queryValue.isNotEmpty) {
      queryMap["faultDescription"] = queryValue;
    }
    if (isVisionLink) {
      var data = MyApi().getClientSeven()!.getFaultCodeTypeSearchVL(
          accountSelected!.CustomerUID,
          Urls.faultCodeSearch + FilterUtils.constructQueryFromMap(queryMap));
      return data;
    } else {}
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
      if (isVisionLink) {
        ManageNotificationsData? response = await MyApi()
            .getClientSeven()!
            .manageNotificationsDataVL(
                Urls.manageNotificationsDataVL, accountSelected!.CustomerUID);

        return response;
      } else {
        ManageNotificationsData? response = await MyApi()
            .getClient()!
            .manageNotificationsData("in-alertmanager-api",
                Urls.manageNotificationsData, accountSelected!.CustomerUID);

        return response;
      }
    } catch (e) {}
  }

  Future<ManageNotificationsData?> getsearchNotificationsData(
      String? searchText) async {
    if (isVisionLink) {
      try {
        Map<String, String> queryMap = Map();

        queryMap["searchKey"] = searchText!;
        ManageNotificationsData? response = await MyApi()
            .getClientSeven()!
            .manageNotificationsDataVL(
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
      AlertTypes? response = await MyApi()
          .getClientSeven()!
          .getNotificationTypesDataVL(
              Urls.getNotificationTypesVL, accountSelected!.CustomerUID);

      return response;
    } else {
      AlertTypes? response = await MyApi()
          .getClient()!
          .getNotificationTypesData("in-alertmanager-api",
              Urls.getNotificationTypes, accountSelected!.CustomerUID);

      return response;
    }
  }

  Future<ZoneValues?> getInclusionExclusionZones() async {
    try {
      if (isVisionLink) {
        ZoneValues? response = await MyApi()
            .getClientSeven()!
            .getCustomerInclusionExclusionVL(
                Urls.getCustomerZonesVL, accountSelected!.CustomerUID);

        return response;
      } else {
        ZoneValues? response = await MyApi()
            .getClient()!
            .getCustomerInclusionExclusion("in-alertmanager-api",
                Urls.getCustomerZones, accountSelected!.CustomerUID);

        return response;
      }
    } catch (e) {}
  }

  Future<dynamic> creatingZone(ZoneCreating zone){
    if (isVisionLink) {
      
    }else{
      var data=MyApi().getClient()!.createZones(Urls.createZone, customerId, service, zone)
    }
  }

  Future<NotificationExist?> checkNotificationTitle(String? value) async {
    if (isVisionLink) {
      Map<String, String> queryMap = Map();

      queryMap["alertTitle"] = value!;
      NotificationExist? response = await MyApi()
          .getClientSeven()!
          .checkNotificationExistVL(
              Urls.checkIfNotificationNameExistsVL +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID);

      return response;
    } else {
      Map<String, String> queryMap = Map();

      queryMap["alertTitle"] = value!;
      NotificationExist? response = await MyApi()
          .getClient()!
          .checkNotificationExist(
              "in-alertmanager-api",
              Urls.checkIfNotificationNameExists +
                  FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID);

      return response;
    }
  }

  Future<NotificationAdded?> addNewNotification(
      AddNotificationPayLoad addNotificationPayLoad) async {
    try {
      if (isVisionLink) {
        NotificationAdded? response = await MyApi()
            .getClientSeven()!
            .addNotificationSaveDataVL(Urls.saveNewNotificationDataVL,
                addNotificationPayLoad, accountSelected!.CustomerUID);

        return response;
      } else {
        NotificationAdded? response = await MyApi()
            .getClient()!
            .addNotificationSaveData(
                "in-alertmanager-api",
                Urls.saveNewNotificationData,
                addNotificationPayLoad,
                accountSelected!.CustomerUID);

        return response;
      }
    } catch (e) {}
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
