import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/device_details_graphql.dart';
import 'package:insite/core/models/device_details_per_id.dart';
import 'package:insite/core/models/get_asset_details_by_serial_no.dart';
import 'package:insite/core/models/get_single_transfer_deviceId_graphql.dart';
import 'package:insite/core/models/get_single_transfer_device_id.dart';
import 'package:insite/core/models/hierachy_graphql.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/industry_list_data.dart';
import 'package:insite/core/models/prefill_customer_details.dart';

import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_dashboard_graphql.dart';
import 'package:insite/core/models/subscription_fleet_graphql.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class SubScriptionService extends BaseService {
  LocalService? _localService = locator<LocalService>();

  Customer? accountSelected;
  Customer? customerSelected;
  String? token;

  SubScriptionService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
      token = await _localService!.getToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<DashboardData?> getGraphQlApiFromSubscription(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlPlantData(
          query: query,
          // customerId: accountSelected?.CustomerUID,
          // userId: (await _localService?.getLoggedInUser())?.sub,
          // subId: customerSelected?.CustomerUID == null
          //     ? ""
          //     : customerSelected?.CustomerUID,
        );

        DashboardData? dashboardResult = DashboardData.fromJson(
            data.data["frameSubscription"]["plantDispatchSummary"]);

        Logger().wtf("dashboard:${dashboardResult.toJson()}");

        return dashboardResult;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SubscriptionDashboardResult?> getResultsFromSubscriptionApi(
      String query) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (enableGraphQl) {
        var data = await Network().getGraphqlPlantData(
          query: query,
          // customerId: "THC",
          // userId: (await _localService!.getLoggedInUser())!.sub,
          // subId: customerSelected?.CustomerUID == null
          //     ? ""
          //     : customerSelected?.CustomerUID,
        );
        Logger().w(data.data["frameSubscription"]);
        SubscriptionDashboardResult subscriptionDashboardResult =
            SubscriptionDashboardResult.fromJson(
                data.data["frameSubscription"]);
        Logger().i(subscriptionDashboardResult.plantDispatchSummary?.toJson());
        return subscriptionDashboardResult;
      } else {
        SubscriptionDashboardResult dashboardResult =
            await MyApi().getClientNine()!.getSubscriptionDashboardResults(
                  Urls.subscriptionResults +
                      FilterUtils.constructQueryFromMap(queryMap),
                );
        if (dashboardResult == null) {
          Logger().d('no data found');
        }

        Logger().d('subscription result: ${dashboardResult.toJson()}');
        return dashboardResult;
      }

    
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SubscriptionFleetList?> getDeviceDetailsFromGraphql(
      String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService?.getLoggedInUser())?.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        SubscriptionFleetList? deviceDetails = SubscriptionFleetList.fromJson(
            data.data["frameSubscription"]["subscriptionFleetList"]);

        Logger().wtf("dashboard:${deviceDetails.toJson()}");

        return deviceDetails;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SubscriptionDashboardDetailResult?> getSubscriptionDeviceListData(
      {String? filter,
      int? start,
      int? limit,
      String? name,
      int? code,
      PLANTSUBSCRIPTIONFILTERTYPE? filterType,
      query}) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (filter != null) {
        if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.DATE) {
          queryMap["calender"] = filter;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.MODEL) {
          queryMap["model"] = filter;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE) {
          queryMap["type"] = filter;
        } else {
          queryMap["status"] = filter;
        }
      }
      if (name != null) {
        queryMap["GPSDeviceID"] = name.toString();
      }
      if (code != null) {
        queryMap["Code"] = code.toString();
      }
      if (start != null) {
        queryMap["start"] = start.toString();
      }
      if (limit != null) {
        queryMap["limit"] = limit.toString();
      }
      if (enableGraphQl) {
        if (filter == "CUSTOMER" ||
            filter == "asset" ||
            filter == "PLANT" ||
            filter == "DEALER") {
          var data = await Network().getGraphqlPlantData(
            query: query,
            // customerId: "THC",
            // userId: (await _localService!.getLoggedInUser())!.sub,
            // subId: customerSelected?.CustomerUID == null
            //     ? ""
            //     : customerSelected?.CustomerUID,
          );
          //Logger().i(data.data);
          return SubscriptionDashboardDetailResult.fromJson(data.data);
        } else if (filter == "active" ||
            filter == "total" ||
            filter == "inactive" ||
            filter == "subscriptionendasset" ||
            filter == "subscriptionendingasset_month" ||
            filter == "plantasset" ||
            filter == "5T WL") {
          var data = await Network().getGraphqlPlantData(
            query: query,
            // customerId: "THC",
            // userId: (await _localService!.getLoggedInUser())!.sub,
            // subId: customerSelected?.CustomerUID == null
            //     ? ""
            //     : customerSelected?.CustomerUID,
          );
          //Logger().i(data.data);
          return SubscriptionDashboardDetailResult.fromJson(
              data.data["frameSubscription"]);
        } else {
          var data = await Network().getGraphqlPlantData(query: query);
          return SubscriptionDashboardDetailResult.fromJson(
              data.data["frameSubscription"]);
        }
      } else {
        SubscriptionDashboardDetailResult dashboardResult =
            await MyApi().getClientNine()!.getSubcriptionDeviceListData(
                  filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE
                      ? Urls.plantHierarchyAssetsResult +
                          FilterUtils.constructQueryFromMap(queryMap)
                      : Urls.subscriptionResults +
                          FilterUtils.constructQueryFromMap(queryMap),
                );
        if (dashboardResult == null) {
          Logger().d('no data found');
        }
        Logger().d('subscription result: $dashboardResult');
        return dashboardResult;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DeviceDataValues?>? getSubscriptionDevicesFromGraphQl(
      String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService?.getLoggedInUser())?.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        DeviceDataValues? deviceDetails = DeviceDataValues.fromJson(data.data);

        Logger().wtf("dashboard:${deviceDetails.toJson()}");

        return deviceDetails;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  Future<SingleAssetRegistrationSearchModel?> getSubscriptionDevicesListData(
      {String? fitler,
      int? start,
      int? limit,
      String? name,
      dynamic code,
      PLANTSUBSCRIPTIONFILTERTYPE? filterType}) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (fitler != null) {
        if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.DATE) {
          queryMap["calender"] = fitler;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.MODEL) {
          queryMap["model"] = fitler;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE) {
          queryMap["type"] = fitler;
        } else {
          queryMap["status"] = fitler;
        }
      }
      if (name != null) {
        queryMap["Name"] = name.toString();
      }
      if (code != null) {
        queryMap["Code"] = code.toString();
      }
      if (start != null) {
        queryMap["start"] = start.toString();
      }
      if (limit != null) {
        queryMap["limit"] = limit.toString();
      }

      SingleAssetRegistrationSearchModel dashboardResult =
          await MyApi().getClientNine()!.getSubscriptionDeviceResults(
                filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE
                    ? Urls.plantHierarchyAssetsResult +
                        FilterUtils.constructQueryFromMap(queryMap)
                    : Urls.subscriptionResults +
                        FilterUtils.constructQueryFromMap(queryMap),
              );
      if (dashboardResult == null) {
        Logger().d('no data found');
      }
      Logger().d('subscription result: $dashboardResult');
      return dashboardResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> getDeviceModelNameBySerialNumber(
      {String? serialNumber, String? query}) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService?.getLoggedInUser())?.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        ModelResult? deviceDetails =
            ModelResult.fromJson(data.data["assetModelByMachineSerialNumber"]);

        Logger().wtf("dashboard:${deviceDetails.toJson()}");

        return deviceDetails;
      } else {
        Map<String, String> queryMap = Map();

        if (accountSelected != null) {
          queryMap["oemName"] = "THC";
        }
        if (serialNumber != null) {
          queryMap["machineSerialNumber"] = serialNumber.toString();
        }

        SerialNumberResults serialNumberResults =
            await MyApi().getClientNine()!.getModelNameFromMachineSerialNumber(
                  Urls.serialNumberSearch +
                      FilterUtils.constructQueryFromMap(queryMap),
                );
        if (serialNumberResults == null) {
          Logger().d('no data found');
        }

        return serialNumberResults;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<AssetTransferData?> postSingleTransferRegistration(
      {List<Transfer>? transferData}) async {
    var userId = await _localService!.getUserId();
    var body = AssetTransferData(
        source: "THC",
        version: "2.1",
        userID: int.parse(userId!),
        transfer: transferData);

    try {
      AssetTransferData addAssetRegistrationData = await MyApi()
          .getClientNine()!
          .getSingleAssetTransferData(Urls.singleAssetRegistration, body);

      return addAssetRegistrationData;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AddAssetRegistrationData?> postSingleAssetTransferRegistration(
      AssetTransfer assetData) async {
    var data = await MyApi()
        .getClientNine()!
        .postSingleAssetTransferRegistration(
            Urls.singleAssetRegistration, assetData);
    return data;
  }

  Future<AddAssetRegistrationData?> postSingleAssetRegistration(
      {List<AssetValues>? data}) async {
    var userId = await _localService!.getUserId();
    var body = AddAssetRegistrationData(
      Source: "THC",
      Version: "2.1",
      UserID: int.parse(userId!),
      asset: data,
    );
    try {
      AddAssetRegistrationData addAssetRegistrationData = await MyApi()
          .getClientNine()!
          .getSingleAssetRegistrationData(Urls.singleAssetRegistration, body);
      return addAssetRegistrationData;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<SubscriptionFleetGraph?> getFleetDataGraphql(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlPlantData(
          query: query,
          // customerId: accountSelected?.CustomerUID,
          // userId: (await _localService?.getLoggedInUser())?.sub,
          // subId: customerSelected?.CustomerUID == null
          //     ? ""
          //     : customerSelected?.CustomerUID,
        );

        SubscriptionFleetGraph? deviceDetails =
            SubscriptionFleetGraph.fromJson(data.data);

        // Logger().wtf(data.data);

        return deviceDetails;
      } else {}
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SubscriptionDashboardDetailResult?> getFleetStatusData({
    int? start,
    int? limit,
  }) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (start != null) {
        queryMap["start"] = start.toString();
      }
      if (limit != null) {
        queryMap["limit"] = limit.toString();
      }

      SubscriptionDashboardDetailResult dashboardResult = await MyApi()
          .getClientNine()!
          .getFleetStatusData(Urls.subscriptionResult +
              FilterUtils.constructQueryFromMap(queryMap));
      if (dashboardResult == null) {
        Logger().d('no data found');
      }
      Logger().d('subscription result: $dashboardResult');
      return dashboardResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SubscriptionDashboardDetailResult?> getTransferHistoryViewData({
    int? start,
    int? limit,
  }) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["oemName"] = "THC";
      }
      if (start != null) {
        queryMap["start"] = start.toString();
      }
      if (limit != null) {
        queryMap["limit"] = limit.toString();
      }

      SubscriptionDashboardDetailResult dashboardResult = await MyApi()
          .getClientNine()!
          .getFleetStatusData(Urls.transferHistoryResult +
              FilterUtils.constructQueryFromMap(queryMap));
      if (dashboardResult == null) {
        Logger().d('no data found');
      }
      Logger().d('subscription result: $dashboardResult');
      return dashboardResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SelectedDevice?> getDeviceDetailsbyIdGraphql(String? query) async {
    try {
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService?.getLoggedInUser())?.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      SelectedDevice? deviceDetails = SelectedDevice.fromJson(data.data);

      Logger().wtf("dashboard:${deviceDetails.toJson()}");

      return deviceDetails;
    } catch (e) {
      throw e;
    }
  }

  Future<DeviceDetailsPerId?> getDeviceDetailsPerDeviceId(
      String controllerValue) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (accountSelected != null) {
        queryMap["gSearch"] = "GPSDeviceID_Fleet";
      }
      if (controllerValue != null) {
        queryMap["contains"] = controllerValue.toString();
      }

      DeviceDetailsPerId deviceDetailsPerId = await MyApi()
          .getClientNine()!
          .getDeviceDetailsPerDeviceId(Urls.singleAssetSearchDeviceIdData +
              FilterUtils.constructQueryFromMap(queryMap));

      return deviceDetailsPerId;
    } catch (e) {
      Logger().e(e.toString());

      return null;
    }
  }

  Future<DeviceIdValues?> getAssetTransferDeviceIds(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService?.getLoggedInUser())?.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        DeviceIdValues? deviceDetails = DeviceIdValues.fromJson(data.data);

        Logger().wtf("dashboard:${deviceDetails.toJson()}");

        return deviceDetails;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SingleTransferDeviceId?> getSingleTransferDeviceId({
    String? filter,
    PLANTSUBSCRIPTIONFILTERTYPE? filterType,
    String? controllerValue,
    int? start,
    int? limit,
    String? searchBy,
  }) async {
    try {
      Map<String, String?> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }
      if (accountSelected!.CustomerUID != null) {
        queryMap["UserUID"] = accountSelected!.CustomerUID;
      }
      if (filter != null) {
        if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.DATE) {
          queryMap["calender"] = filter;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.MODEL) {
          queryMap["model"] = filter;
        } else if (filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE) {
          queryMap["type"] = filter;
        } else {
          queryMap["status"] = filter;
        }
      }
      if (accountSelected != null) {
        queryMap["searchBy"] = searchBy;
      }
      if (controllerValue != null) {
        queryMap["contains"] = controllerValue.toString();
      }
      if (start != null) {
        queryMap["start"] = start.toString();
      }
      if (limit != null) {
        queryMap["limit"] = limit.toString();
      }
      SingleTransferDeviceId singleTransferDeviceIds =
          await MyApi().getClientNine()!.getSingleAssetTransfersDeviceIds(
                Urls.singleAssetTransferDeviceId +
                    FilterUtils.constructQueryFromMap(queryMap),
              );

      return singleTransferDeviceIds;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<CustomerDetails?> getCustomerDetails(String deviceID) async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["oemName"] = "THC";
      }
      CustomerDetails customerDetails = await MyApi()
          .getClientNine()!
          .getExitingCustomerDetails(Urls.getExistingCustomerDetails +
              deviceID +
              FilterUtils.constructQueryFromMap(queryMap));

      return customerDetails;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AssetDetailsBySerialNo?> getDeviceAssetDetailsBySerialNo(
      String text) async {
    try {
      Map<String, String> queryMap = Map();

      if (text != null) {
        queryMap["machineSerialNumber"] = text;
      }
      if (accountSelected != null) {
        queryMap["oemName"] = "THC";
      }

      AssetDetailsBySerialNo assetDetailsBySerialNo = await MyApi()
          .getClientNine()!
          .getDeviceDetailsPerSerialNo(Urls.singleAssetSerchBySerialNo +
              FilterUtils.constructQueryFromMap(queryMap));
      return assetDetailsBySerialNo;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<IndustryListData?> getIndustryTransferData(String? query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlPlantData(
          query: query,
          // customerId: accountSelected?.CustomerUID,
          // userId: (await _localService?.getLoggedInUser())?.sub,
          // subId: customerSelected?.CustomerUID == null
          //     ? ""
          //     : customerSelected?.CustomerUID,
        );
        return IndustryListData.fromJson(data.data);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
