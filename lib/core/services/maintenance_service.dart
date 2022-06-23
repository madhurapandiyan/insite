import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/complete.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_asset_india_stack.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/models/maintenance_dashboard_count.dart';
import 'package:insite/core/models/maintenance_list_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/maintenance_refine.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class MaintenanceService extends BaseService {
  LocalService? _localService = locator<LocalService>();
  Customer? accountSelected;
  Customer? customerSelected;

  MaintenanceService() {
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

  Future<MaintenanceViewData?> getMaintenanceData(
      {String? startTime, String? endTime, int? limit, int? page}) async {
    try {
      if (isVisionLink) {
        Map<String, dynamic> queryContent = {
          "queryContent": {
            "startDateTime": startTime,
            "endDateTime": endTime,
            "langDesc": "en-US",
            "limit": limit,
            "page": page,
          },
          "headers": {
            "X-Introspect": true,
          }
        };

        MaintenanceViewData updateResponse = await MyApi()
            .getClientThree()!
            .getMaintenanceViewServicesVL(Urls.getMaintenanceViewDataVL,
                queryContent, accountSelected!.CustomerUID);

        Logger().wtf(updateResponse.toJson());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceListData?> getMaintenanceListData(
      {String? startTime,
      String? endTime,
      int? limit,
      int? page,
      String? query}) async {
    try {
      if (enableGraphQl) {
        // print(await _localService!.getToken());
        // Logger().i(await _localService!.getStaggedToken());
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        MaintenanceListData mainListData =
            MaintenanceListData.fromJson(data.data["maintenanceList"]);
        return mainListData;
      }
      if (!isVisionLink) {
        Map<String, String> queryMap = Map();

        if (startTime != null) {
          queryMap["fromDate"] =
              Utils.getDateInFormatyyyyMMddTHHmmss(startTime.toString());
        }
        if (endTime != null) {
          queryMap["toDate"] =
              Utils.getDateInFormatyyyyMMddTHHmmss(endTime.toString());
        }
        if (limit != null) {
          queryMap["limit"] = limit.toString();
        }
        if (page != null) {
          queryMap["pageNumber"] = page.toString();
        }

        queryMap["history"] = "true";

        MaintenanceListData? maintenanceListData = await MyApi()
            .getClientSix()!
            .getMaintenanceListData(
                Urls.getMaintenanceList +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                "in-maintenance-ew-api");

        Logger().wtf("maitenanceListData : ${maintenanceListData.toJson()}");
        return maintenanceListData;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceAssetList?> getMaintenanceAssetList(
      {String? startTime,
      String? endTime,
      int? limit,
      int? page,
      String? query}) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        MaintenanceAssetList mainListData =
            MaintenanceAssetList.fromJson(data.data["maintenanceAssetList"]);
        return mainListData;
      }
      if (!isVisionLink) {
        Map<String, String> queryMap = Map();

        if (startTime != null) {
          queryMap["fromDate"] =
              Utils.getDateInFormatyyyyMMddTHHmmss(startTime.toString());
        }
        if (endTime != null) {
          queryMap["toDate"] =
              Utils.getDateInFormatyyyyMMddTHHmmss(endTime.toString());
        }
        if (limit != null) {
          queryMap["limit"] = limit.toString();
        }
        if (page != null) {
          queryMap["pageNumber"] = page.toString();
        }

        MaintenanceAssetList? maintenanceAssetList = await MyApi()
            .getClientSix()!
            .getMaintenanceAssetListData(
                Urls.getMaintenanceAssetList +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                "in-maintenance-ew-api");

        Logger()
            .wtf("maitenanceAssetListData : ${maintenanceAssetList.toJson()}");
        return maintenanceAssetList;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceAsset?> getMaintenanceAssetData(
      String? endDateTime, limit, page, startDateTime) async {
    try {
      if (isVisionLink) {
        MaintenanceAsset updateResponse = await MyApi()
            .getClientThree()!
            .getMaintenanceAssetData(
                endDateTime!,
                'en-US',
                limit,
                page,
                startDateTime,
                accountSelected!.CustomerUID,
                Urls.getMaintenanceAssetData);

        Logger().wtf(updateResponse.toJson());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceListService?> getMaintenanceServiceList(
      String? assetId, endDateTime, limit, page, startDateTime) async {
    try {
      MaintenanceListService updateResponse = await MyApi()
          .getClientThree()!
          .getMaintenanceListServiceData(
              assetId!,
              endDateTime!,
              'en-US',
              limit,
              page,
              startDateTime,
              accountSelected!.CustomerUID,
              Urls.getMaintenaceServiceData);

      Logger().wtf(updateResponse.services!.first.toJson());
      return updateResponse;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceCheckListModel?> getMaintenanceServiceItemCheckList(
      {String? query}) async {
    if (enableGraphQl) {
      var data = await Network().getStaggedGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      MaintenanceCheckListModel mainListData =
          MaintenanceCheckListModel.fromJson(data.data["maintenanceCheckList"]);
      Logger().w(mainListData.toJson());
      return mainListData;
    }
  }

  Future<ServiceItem?> getServiceItemCheckList(
    num? serviceId,
  ) async {
    try {
      if (isVisionLink) {
        ServiceItem? updateResponse = await MyApi()
            .getClientThree()!
            .getServiceCheckListData(serviceId!, accountSelected!.CustomerUID,
                Urls.getServiceCheckListData);

        Logger().wtf(updateResponse!.toJson());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<Complete?> complete({
    String? serviceDate,
    String? performedBy,
    String? serviceNotes,
    String? workOrder,
    int? hourMeter,
    int? serviceId,
    int? occurenceId,
    String? assetUid,
    String? assetId,
    String? serialNumber,
    String? makecode,
    String? model,
    bool? isComplete,
    String? checkListName,
    num? checkListId,
  }) async {
    try {
      if (isVisionLink) {
        Map<String, dynamic> queryContent = {
          "complete": {
            "servicedDate": serviceDate,
            "hourMeter": hourMeter,
            "performedBy": performedBy,
            "serviceNotes": serviceNotes,
            "workOrder": workOrder,
            "serviceId": serviceId,
            "occurrenceId": occurenceId,
            "checklist": {
              "checklistName": checkListName,
              "checklistId": checkListId,
              "isChecked": true
            },
          },
          "timezone": "Central America Standard Time",
          "assetUID": assetUid,
          "assetID": assetId,
          "assetSerialNumber": serialNumber,
          "makeCode": makecode,
          "model": model,
          "isCompleted": isComplete
        };
        Logger().i(queryContent);
        Complete? updateResponse = await MyApi()
            .getClientThree()!
            .completeResponse(Urls.getCompleteData, queryContent,
                "application/json;charset=UTF-8", accountSelected!.CustomerUID);

        Logger().wtf(updateResponse.toJson());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future onCompletion(String? query) async {
    if (enableGraphQl) {
      var maintenancepostData = await Network().getStaggedGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );

      return maintenancepostData;
    }
  }

  Future<MaintenanceRefineData?> getRefineData({String? query}) async {
    if (enableGraphQl) {
      var maintenancepostData = await Network().getStaggedGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      MaintenanceRefineData data =
          MaintenanceRefineData.fromJson(maintenancepostData.data);
      return data;
    }
  }

  Future<MaintenanceDashboardCount?> getMaintenanceDashboardCount(
      {String? query}) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        MaintenanceDashboardCount countData =
            MaintenanceDashboardCount.fromJson(data.data);
        Logger().w(countData.maintenanceDashboard?.toJson());
        return countData;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<MaintenanceIntervals?> getMaintenanceIntervals(String query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        MaintenanceIntervals countData =
            MaintenanceIntervals.fromJson(data.data["maintenanceIntervals"]);
        return countData;
      }
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  Future<dynamic> addMaintenanceIntervals(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return data.data["createMaintenanceIntervals"];
      }
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  Future<dynamic> updateMaintenanceIntervals(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return data.data["updateMaintenanceIntervals"];
      }
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  Future<dynamic> deletMaintenanceIntervals(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getStaggedGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        return data.data["maintenanceIntervalsDelete"];
      }
    } catch (e) {
      Logger().w(e.toString());
    }
  }
}
