import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/models/add_asset_registration.dart';

class SubScriptionService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;
  String token;

  SubScriptionService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
      token = await _localService.getToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<SubscriptionDashboardResult> getResultsFromSubscriptionApi() async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }

      SubscriptionDashboardResult dashboardResult =
          await MyApi().getClientEight().getSubscriptionDashboardResults(
                Urls.subscriptionResults +
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

  Future<SubscriptionDashboardDetailResult> getSubscriptionDevicesListData(
      {String fitler,
      int start,
      int limit,
      String name,
      int code,
      PLANTSUBSCRIPTIONFILTERTYPE filterType}) async {
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

      SubscriptionDashboardDetailResult dashboardResult =
          await MyApi().getClientEight().getSubscriptionDeviceResults(
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

  Future<SerialNumberResults> getDeviceModelNameBySerialNumber(
      {String serialNumber}) async {
    try {
      Map<String, String> queryMap = Map();

      if (accountSelected != null) {
        queryMap["oemName"] = "THC";
      }
      if (serialNumber != null) {
        queryMap["machineSerialNumber"] = serialNumber.toString();
      }

      SerialNumberResults serialNumberResults =
          await MyApi().getClientTen().getModelNameFromMachineSerialNumber(
                Urls.serialNumberSearch +
                    FilterUtils.constructQueryFromMap(queryMap),
              );
      if (serialNumberResults == null) {
        Logger().d('no data found');
      }

      return serialNumberResults;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  Future<AddAssetRegistrationData> postSingleAssetRegistration(
      List<AssetValues> data) async {
    data.map((e) {
      Logger().wtf(
          'values to be checked ${e.commissioningDate} ${e.customerCode} ${e.customerEmailID} ${e.customerName} ${e.dealerCode}${e.dealerEmailID}${e.dealerName}${e.deviceId}${e.hMR}${e.hMRDate}${e.machineModel}${e.machineSlNo}${e.plantCode}${e.plantEmailID}${e.plantName}${e.primaryIndustry}${e.secondaryIndustry}');
    });

    var body = AddAssetRegistrationData(
        source: "THC", version: "2.1", userID: 58839, asset: data);

    try {
      AddAssetRegistrationData addAssetRegistrationData = await MyApi()
          .getClientEleven()
          .getSingleAssetRegistrationData(Urls.singleAssetRegistration, body);
      return addAssetRegistrationData;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }
}
