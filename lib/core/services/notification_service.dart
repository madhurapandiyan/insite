import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_notification_payload.dart';

import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_notification.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/models/manage_notification_filter.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/models/notification_resolve.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/alert_config_edit.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/fault_code_type_search.dart';
import 'package:logger/logger.dart';
import '../../views/adminstration/notifications/add_new_notifications/model/zone.dart';

class NotificationService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService _graphqlSchemaService = locator<GraphqlSchemaService>();
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

  Future<FaultCodeTypeSearch?> getFaultCodeTypeSearch(String queryValue,
      int pageValue, String faultCodeType, String query) async {
    Map<String, String> queryMap = Map();

    if (faultCodeType.isNotEmpty) {
      queryMap["faultCodeType"] = faultCodeType;
    }
    if (queryValue.isNotEmpty) {
      queryMap["faultDescription"] = queryValue;
    }
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      FaultCodeTypeSearch notificationsData =
          FaultCodeTypeSearch.fromJson(data.data["getFaultCodeData"]);
      return notificationsData;
    }
    if (isVisionLink) {
      queryMap["lang"] = "en-US";
      queryMap["page"] = pageValue.toString();
      var data = await MyApi().getClientSeven()!.getFaultCodeTypeSearchVL(
          accountSelected!.CustomerUID,
          Urls.faultCodeSearchVL + FilterUtils.constructQueryFromMap(queryMap));
      return data;
    } else {
      var data = await MyApi().getClient()!.getFaultCodeTypeSearch(
          "in-alertmanager-api",
          accountSelected!.CustomerUID,
          Urls.faultCodeSearch + FilterUtils.constructQueryFromMap(queryMap));
      return data;
    }
  }

  Future<NotificationsData?> getNotificationsData(notificationUserStatus,
      notificationStatus, startDate, endDate, String query,dynamic payLoad) async {
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
            payLoad: payLoad
      );
      if (data.data["seeAllNotificationList"] != null) {
        NotificationsData? notificationsData =
            NotificationsData.fromJson(data.data["seeAllNotificationList"]);
        return notificationsData;
      } else {
        return null;
      }
    }
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

  Future<AlertConfigEdit?> alertConfigEdit(String uid, String query) async {
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      AlertConfigEdit? response =
          AlertConfigEdit.fromJson(data.data["getNotificationAlertConfigData"]);
      return response;
    }
    if (isVisionLink) {
    } else {
      var data = await MyApi().getClient()!.getAlertConfig(
          "in-alertmanager-api",
          accountSelected!.CustomerUID,
          Urls.saveNewNotificationData + "/$uid" + "/1");
      return data;
    }
  }

 
  Future<ManageNotificationsData?> getManageNotificationsData(
      int pageNumber, dynamic payLoad) async {
    try {
      if (enableGraphQl) {
      
        var data = await Network().getGraphqlData(
          query: _graphqlSchemaService.manageNotificationList(),
          userId: (await _localService?.getLoggedInUser())?.sub,
          customerId: accountSelected!.CustomerUID,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
              payLoad: payLoad
        );

        ManageNotificationsData manageNotificationResponse =
            ManageNotificationsData.fromJson(
                data.data['getConfiguredAlertsData']);
        return manageNotificationResponse;
      } else {
        if (isVisionLink) {
          ManageNotificationsData? response = await MyApi()
              .getClientSeven()!
              .manageNotificationsDataVL(
                  Urls.manageNotificationsDataVL, accountSelected!.CustomerUID);

          return response;
        } else {
          ManageNotificationsData? response = await MyApi()
              .getClient()!
              .manageNotificationsData(
                  "in-alertmanager-api",
                  Urls.manageNotificationsData + pageNumber.toString() + "/20",
                  accountSelected!.CustomerUID);

          return response;
        }
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

   Future<SingleFaultCodeTypeSearch?> getSingleFaultCodeDescription(
      String query) async {
    Map<String, String> queryMap = Map();
    var data = await Network().getGraphqlData(
      query: query,
      customerId: accountSelected?.CustomerUID,
      userId: (await _localService!.getLoggedInUser())!.sub,
      subId: customerSelected?.CustomerUID == null
          ? ""
          : customerSelected?.CustomerUID,
    );
    SingleFaultCodeTypeSearch notificationsData =
        SingleFaultCodeTypeSearch.fromJson(data.data["getSingleFaultConfig"]);
    return notificationsData;
  }

Future<ManageNotificationFilter?> getManageNotificationFilterData()async{
  try{
  if (enableGraphQl) {
      
      var data = await Network().getGraphqlData(
        query:_graphqlSchemaService.getNotificationFilter() ,
        userId: (await _localService?.getLoggedInUser())?.sub,
        customerId: accountSelected!.CustomerUID,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
  ManageNotificationFilter manageNotificationResponse =
          ManageNotificationFilter.fromJson(
              data.data);
              Logger().i(manageNotificationResponse.toJson());
    return manageNotificationResponse;
    }
  }catch(e){
  Logger().e(e.toString());
  }
  return null;
}

  Future<ManageNotificationsData?> getsearchNotificationsData(
      {String? searchText, dynamic payLoad}) async {
    if (enableGraphQl) {
    
      var data = await Network().getGraphqlData(
        query: await _graphqlSchemaService.manageNotificationList(),
        userId: (await _localService?.getLoggedInUser())?.sub,
        customerId: accountSelected!.CustomerUID,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
            payLoad: payLoad
      );

      ManageNotificationsData manageNotificationResponse =
          ManageNotificationsData.fromJson(
              data.data['getConfiguredAlertsData']);
      return manageNotificationResponse;
    } else {
      if (isVisionLink) {
        Map<String, String> queryMap = Map();

        queryMap["searchKey"] = searchText!;
        ManageNotificationsData? response = await MyApi()
            .getClientSeven()!
            .manageNotificationsDataVL(
                Urls.manageNotificationsData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);

        return response;
      } else {
        Map<String, String> queryMap = Map();

        queryMap["searchKey"] = searchText!;
        ManageNotificationsData? response = await MyApi()
            .getClient()!
            .manageNotificationsData(
                "in-alertmanager-api",
                Urls.manageNotificationsData +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID);

        return response;
      }
    }
  }

  Future<AlertTypes?> getNotificationTypes(String query) async {
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      AlertTypes? response =
          AlertTypes.fromJson(data.data["getNotificationTypeGroupsData"]);
      return response;
    }
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

  creatingZone(ZoneCreating zone) async {
    if (isVisionLink) {
    } else {
      var data = await MyApi().getClient()!.createZones(Urls.createZone,
          accountSelected!.CustomerUID, "in-alertmanager-api", zone);
      return data;
    }
  }

  Future<NotificationExist?> checkNotificationTitle(
      String? value, String query) async {
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      NotificationExist? response =
          NotificationExist.fromJson(data.data["getAlertTitleExistsData"]);
      return response;
    }
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
      Logger().e("map");
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
    AddNotificationPayLoad addNotificationPayLoad,
    String query,
  ) async {
    try {
      Logger().i(addNotificationPayLoad.toJson());
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          payLoad: addNotificationPayLoad.toJson(),
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        NotificationAdded? response =
            NotificationAdded.fromJson(data.data["createNotification"]);
        Logger().w(data);
        return response;
      }
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

Future<NotificationStatus?> getNotificationStatusData({dynamic payLoad})async{
  try{
  if (enableGraphQl) {
      
      var data = await Network().getGraphqlData(
        query:_graphqlSchemaService.createupdateNotification() ,
        userId: (await _localService?.getLoggedInUser())?.sub,
        customerId: accountSelected!.CustomerUID,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
            payLoad:payLoad 
      );
  NotificationStatus notificationStatus =
          NotificationStatus.fromJson(
              data.data["updateNotificationResolve"]);
              Logger().i(notificationStatus.toJson());
    return notificationStatus;
    }
  }catch(e){
  Logger().e(e.toString());
  }
  return null;
}

  Future<UpdateResponse?> deleteMainNotification(List<String> ids) async {
    try {
      if (isVisionLink) {
        Map<String, dynamic> notificationMap = {"notificationUID": ids};

        UpdateResponse updateResponse = await MyApi()
            .getClientFour()!
            .deleteMainNotification(Urls.deleteNotification, notificationMap,
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {}
    return null;
  }

  Future<NotificationStatus?> deleteNotification({dynamic payload}) async {
    try {
      
   var data = await Network().getGraphqlData(
        query:_graphqlSchemaService.deleNotification() ,
        userId: (await _localService?.getLoggedInUser())?.sub,
        customerId: accountSelected!.CustomerUID,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
            payLoad:payload
      );
        NotificationStatus notificationStatus =
          NotificationStatus.fromJson(
              data.data["deleteNotification"]);
              Logger().i(notificationStatus.toJson());
    return notificationStatus;
      
    } catch (e) {}
    return null;
  }

  Future<UpdateResponse?> deleteManageNotification(
      String? notificationId, String query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        UpdateResponse updateResponse = UpdateResponse(
            isDeleted: data.data["deleteNotificationAlertConfig"]["isDeleted"]);
        return updateResponse;
      }
      if (isVisionLink) {
        UpdateResponse updateResponse = await MyApi()
            .getClientSeven()!
            .deleteNotificationVL(
                Urls.deleteManageNotificationVL + notificationId!,
                accountSelected!.CustomerUID);
        return updateResponse;
      } else {
        UpdateResponse updateResponse = await MyApi()
            .getClient()!
            .deleteNotification(
                "in-alertmanager-api",
                Urls.deleteManageNotification + notificationId!,
                accountSelected!.CustomerUID);
        return updateResponse;
      }
    } catch (e) {}
    return null;
  }

  editNotification(
      AddNotificationPayLoad payload, String alertUid, String query) async {
    if (enableGraphQl) {
     
      var data = await Network().getGraphqlData(
        query: query,
        payLoad: payload.toJson(),
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      return data;
    }
    if (isVisionLink) {
    } else {
      var data = await MyApi().getClient()!.editNotificationSaveData(
          "in-alertmanager-api",
          Urls.saveNewNotificationData + "/$alertUid",
          payload,
          accountSelected!.CustomerUID);
      return data;
    }
  }

 Future<FilterNotification?> getNotificationStatusCount(
      {String? query,}) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        FilterNotification countData =
            FilterNotification.fromJson(data.data["seeAllNotificationCountByStatus"]);

        return countData;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
    return null;
  }

}
