import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_status_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model_response.dart';
import 'package:insite/views/subscription/replacement/model/replace_deviceId_model.dart';
import 'package:insite/views/subscription/replacement/model/replacement_deviceId_download.dart';
import 'package:insite/views/subscription/replacement/model/replacement_model.dart';
import 'package:logger/logger.dart';

class ReplacementService extends BaseService {
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
      ReplacementModel replacementModeldata) async {
    if (isVisionLink) {
    } else {
      var data = await MyApi()
          .getClientNine()!
          .postNewDeviceId(Urls.saveNewDeviceId, replacementModeldata);
      return data;
    }
  }

  Future<TotalDeviceReplacementStatusModel?>
      getTotalDeviceReplacementStatusModel(int startCount) async {
    TotalDeviceReplacementStatusModel? data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    queryMap["start"] = startCount.toString();
    queryMap["limit"] = "16";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine()!.getRepalcementDeviceStatus(
          Urls.getReportOfReplacement +
              FilterUtils.constructQueryFromMap(queryMap));
      return data;
    }
    return data;
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
