import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
import 'package:logger/logger.dart';

class SmsManagementService extends BaseService {
  Future<SingleAssetResponce> postSingleAssetResponce(
      List<SingleAssetSmsSchedule> modelData) async {
    Map<String, String> queryMap = Map();
    queryMap["OEM"] = "VEhD";
    Logger().w(Urls.smsManagementSingleAsset +
        FilterUtils.constructQueryFromMap(queryMap));
    if (isVisionLink) {
    } else {
      SingleAssetResponce data = await MyApi()
          .getClientTen()
          .postSingleAssetSmsSchedule(
              Urls.smsManagementSingleAsset +
                  FilterUtils.constructQueryFromMap(queryMap),
              modelData);

      Logger().wtf(data.toJson());
      return data;
    }
  }
}
