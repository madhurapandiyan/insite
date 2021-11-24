import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/subscription/sms-management/model/delete_sms_management_schedule.dart';
import 'package:insite/views/subscription/sms-management/model/saving_sms_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_reportSummary_responce_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
import 'package:logger/logger.dart';

class SmsManagementService extends BaseService {
  Future<SingleAssetResponce> postSingleAssetResponce(
      List<SingleAssetSmsSchedule> modelData) async {
    SingleAssetResponce data;
    Logger().d(modelData.last.toJson());
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    Logger().w(Urls.smsManagementSingleAsset +
        FilterUtils.constructQueryFromMap(queryMap));
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine().postSingleAssetSmsSchedule(
          Urls.smsManagementSingleAsset +
              FilterUtils.constructQueryFromMap(queryMap),
          modelData);

      Logger().wtf(data.toJson());
    }
    return data;
  }

  Future<dynamic> savingSms(List<SavingSmsModel> model) async {
    Logger().wtf(model.first.toJson());
    if (isVisionLink) {
    } else {
      var data = MyApi().getClientNine().savingSms(Urls.savingSms, model);
    }
  }

  Future<SmsReportSummaryModel> getsmsReportSummaryModel(int startCount) async {
    SmsReportSummaryModel data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    queryMap["start"] = startCount.toString();
    queryMap["limit"] = "16";
    Logger().i(Urls.smsManagementScheduleReportSummary +
        FilterUtils.constructQueryFromMap(queryMap));
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine().gettingReportSummary(
          Urls.smsManagementScheduleReportSummary +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }

  Future<SmsReportSummaryModel> getScheduleReportData() async {
    SmsReportSummaryModel data;
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    if (isVisionLink) {
    } else {
      data = await MyApi().getClientNine().gettingScheduleReportSummary(
          Urls.getScheduleReportData +
              FilterUtils.constructQueryFromMap(queryMap));
    }
    return data;
  }

  Future<dynamic> deleteSmsScheduleReport(
      List<DeleteSmsReport> reportId) async {
    Map<String, String> queryMap = Map();
    queryMap["UserID"] = await locator<LocalService>().getUserId();
    if (isVisionLink) {
    } else {
      var data = await MyApi().getClientNine().deleteSmsSchedule(
          Urls.deleteSmsScheduleReport +
              FilterUtils.constructQueryFromMap(queryMap),
          reportId);
      return data;
    }
  }
}
