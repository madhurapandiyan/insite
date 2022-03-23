import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/complete.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
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
            .getMaintenanceViewServices(Urls.getMaintenanceViewData,
                queryContent, accountSelected!.CustomerUID);

        Logger().wtf(updateResponse.toJson());
        return updateResponse;
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

  Future<ServiceItem?> getServiceItemCheckList(num? serviceId) async {
    try {
      ServiceItem? updateResponse = await MyApi()
          .getClientThree()!
          .getServiceCheckListData(serviceId!, accountSelected!.CustomerUID,
              Urls.getServiceCheckListData);

      Logger().wtf(updateResponse!.toJson());
      return updateResponse;
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
            "checklist": []
          },
          "timezone": "Central America Standard Time",
          "assetUID": assetUid,
          "assetID": assetId,
          "assetSerialNumber": serialNumber,
          "makeCode": makecode,
          "model": model,
          "isCompleted": true
        };
        Logger().i(queryContent);
        Complete? updateResponse = await MyApi()
            .getClientThree()!
            .completeResponse(Urls.getCompleteData, queryContent,"application/json;charset=UTF-8"
                accountSelected!.CustomerUID);

        Logger().wtf(updateResponse.toJson());
        return updateResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }
}
