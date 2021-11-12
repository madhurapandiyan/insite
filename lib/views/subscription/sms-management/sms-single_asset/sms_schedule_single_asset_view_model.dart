import 'package:dio/dio.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/smsManagementService.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SmsScheduleSingleAssetViewModel extends InsiteViewModel {
  Logger log;

  final _smsScheduleService = locator<SmsManagementService>();

  SmsScheduleSingleAssetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  List<SingleAssetSmsSchedule> listOfSingleAssetSmsSchedule = [];

  SingleAssetResponce _singleAssetResponce;
  SingleAssetResponce get singleAssetResponce => _singleAssetResponce;

  bool dummy = true;

  onSavingForm(
      String serialNo, String name, String mobileNo, String language) async {
    showLoadingDialog();
    try {
      SingleAssetSmsSchedule data = SingleAssetSmsSchedule(
          AssetSerial: serialNo,
          Name: name,
          Mobile: mobileNo,
          Language: language);
      Logger().d(data.toJson());
      listOfSingleAssetSmsSchedule.add(data);
      _singleAssetResponce = await _smsScheduleService
          .postSingleAssetResponce(listOfSingleAssetSmsSchedule);
      hideLoadingDialog();
      listOfSingleAssetSmsSchedule.clear();
      notifyListeners();
    } on DioError catch (e) {
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService.showCustomSnackBar(message: e.message);
    }
  }
}
