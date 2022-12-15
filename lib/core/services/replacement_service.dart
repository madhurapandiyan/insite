import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_details.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_status_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model_response.dart';
import 'package:insite/views/subscription/replacement/model/replace_deviceId_model.dart';
import 'package:insite/views/subscription/replacement/model/replacement_deviceId_download.dart';
import 'package:insite/views/subscription/replacement/model/replacement_model.dart';
import 'package:logger/logger.dart';

class ReplacementService extends BaseService {
  LocalService? _localService = locator<LocalService>();

  Customer? accountSelected;
  Customer? customerSelected;
  String? token;

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
      token = await _localService!.getToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  ReplacementService() {
    setUp();
  }

  Future<DeviceSearchModel?> getDeviceSearchModel(String searchWord) async {
    DeviceSearchModel? data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    queryMap["gSearch"] = "GPSDeviceID_Fleet_smartSearch";
    queryMap["contains"] = searchWord;
    queryMap["start"] = "0";
    queryMap["limit"] = "100";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine()!.getDeviceSearchModel(
          Urls.masterSearchDeviceId +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }

  Future<SubscriptionDeviceFleetList?> getSearchedDeviceDetails(
      String? query, dynamic payLoad) async {
    try {
      var data = await Network().getGraphqlPlantData(
          query: query,
          // customerId: accountSelected?.CustomerUID,
          // userId: (await _localService?.getLoggedInUser())?.sub,
          // subId: customerSelected?.CustomerUID == null
          //     ? ""
          //     : customerSelected?.CustomerUID,
          payLoad: payLoad);

      SubscriptionDeviceFleetList? deviceDetails =
          SubscriptionDeviceFleetList.fromJson(
              data.data["frameSubscription"]["subscriptionFleetList"]);

      Logger().wtf("dashboard:${deviceDetails.toJson()}");

      return deviceDetails;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DeviceSearchModelResponse?> getDeviceSearchModelResponse(
      String deviceId) async {
    DeviceSearchModelResponse? data;
    Map<String, String> queryMap = Map();
    queryMap["oemName"] = "THC";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine()!.getDeviceSearchModelResponse(
          Urls.getSearchModelResponse +
              "$deviceId/" +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }

  Future<ReplaceDeviceModel?> getReplaceDeviceModel(String searchWord) async {
    ReplaceDeviceModel? data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    queryMap["status"] = "inactive";
    queryMap["GPSDeviceID"] = searchWord;
    queryMap["start"] = "0";
    queryMap["limit"] = "100";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine()!.getReplaceDeviceModel(
          Urls.getReplaceDeviceIdModel +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }

  Future<dynamic> savingReplacement(
      ReplacementModel replacementModeldata, String? query) async {
    if (enableGraphQl) {
      var data = await Network().getGraphqlPlantData(
        query: query,
        // customerId: accountSelected?.CustomerUID,
        // userId: (await _localService?.getLoggedInUser())?.sub,
        // subId: customerSelected?.CustomerUID == null
        //     ? ""
        //     : customerSelected?.CustomerUID,
        payLoad: {
          "id": replacementModeldata.UserID,
          "gnacc": "",
          "request": ReplacementGraphqlModel(
                  source: "THC",
                  userID: replacementModeldata.UserID,
                  version: replacementModeldata.Version.toString(),
                  device: replacementModeldata.device
                      ?.map((e) => NewDeviceIdGrapgqlDetail(
                          newDeviceId: e.NewDeviceId,
                          oldDeviceId: e.OldDeviceId,
                          reason: e.Reason,
                          vin: e.VIN))
                      .toList())
              .toJson()
        },
      );
      if (data.data['assetOperation'] == null) {
        return {'status': 'success'};
      }
    }
    if (isVisionLink) {
    } else {
      var data = await MyApi()
          .getClientNine()!
          .postNewDeviceId(Urls.saveNewDeviceId, replacementModeldata);
      return data;
    }
  }

  Future<TotalDeviceReplacementStatusModel?>
      getTotalDeviceReplacementStatusModel(int startCount, String query) async {
    TotalDeviceReplacementStatusModel? data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    queryMap["start"] = startCount.toString();
    queryMap["limit"] = "16";
    if (enableGraphQl) {
      var data = await Network().getGraphqlPlantData(
        query: query,
      );

      TotalDeviceReplacementStatusModel? deviceDetails =
          TotalDeviceReplacementStatusModel.fromJson(data.data);

      Logger().wtf("response:$data");

      return deviceDetails;
    } else {
      data = await MyApi().getClientNine()!.getRepalcementDeviceStatus(
          Urls.getReportOfReplacement +
              FilterUtils.constructQueryFromMap(queryMap));
      Logger().wtf("data:$data");
      return data;
    }
  }

  Future<ReplacementDeviceIdDownload?> getReplacementDeviceIdDownload() async {
    ReplacementDeviceIdDownload? data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine()!.getReplacementDeviceIdDownload(
          Urls.downloadReplacementData +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }
}
