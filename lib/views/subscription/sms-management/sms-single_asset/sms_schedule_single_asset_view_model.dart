import 'package:dio/dio.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/subscription/sms-management/model/saving_sms_model.dart';
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

  set singleAssetModelResponceSetter(List<SingleAssetModelResponce> val) {
    singleAssetModelResponce = val;
  }

  SavingSmsModel _savingSmsModel;

  List<SavingSmsModel> listOSavingSmsModel = [];

  List<SingleAssetModelResponce> singleAssetModelResponce = [];

  bool isLoading = true;

  bool dummy = false;

  String name;
  String mobileNo;
  String language;

  List<String> nameList = [];
  List<String> mobileNoList = [];
  List<String> languageList = [];
  List<String> deviceId = [];
  List<String> model = [];
  List<String> date = [];
  List<String> serialNo = [];

 Future onSavingForm(String serialNumber, String recipientName, String recipientMobNo,
      String lang) async {
    try {
      showLoadingDialog();
      nameList.add(recipientName);
      mobileNoList.add(recipientMobNo);
      languageList.add(lang);
      SingleAssetSmsSchedule data = SingleAssetSmsSchedule(
          AssetSerial: serialNumber,
          Name: recipientName,
          Mobile: recipientMobNo,
          Language: lang);

      Logger().d(data.toJson());
      listOfSingleAssetSmsSchedule.add(data);
      _singleAssetResponce = await _smsScheduleService
          .postSingleAssetResponce(listOfSingleAssetSmsSchedule);
      singleAssetModelResponce = _singleAssetResponce.result;
      for (var item in singleAssetModelResponce) {
        deviceId.add(item.GPSDeviceID);
        model.add(item.Model);
        serialNo.add(item.SerialNumber);
        date.add(item.StartDate);
      }
      hideLoadingDialog();
      listOfSingleAssetSmsSchedule.clear();
   
      notifyListeners();
    } on DioError catch (e) {
  
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService.showCustomSnackBar(message: e.message);
      notifyListeners();
    }
  }

  onBackPressed() {
    showLoadingDialog();
    Future.delayed(Duration(seconds: 2), () {
      nameList.clear();
      mobileNoList.clear();
      languageList.clear();
      singleAssetModelResponce.clear();
      hideLoadingDialog();
      notifyListeners();
    });
  }



  onSavingSmsModel() async {
    try {
      showLoadingDialog();
      for (var i = 0; i < singleAssetModelResponce.length; i++) {
        _savingSmsModel = SavingSmsModel(
            AssetSerial: serialNo[i],
            GPSDeviceID: deviceId[i],
            Language: languageList[i],
            Mobile: mobileNoList[i],
            Model: model[i],
            Name: nameList[i],
            StartDate: date[i]);
        listOSavingSmsModel.add(_savingSmsModel);
      }

      Logger().d(_savingSmsModel.toJson());
      var data = await _smsScheduleService.savingSms(listOSavingSmsModel);
      hideLoadingDialog();
      dummy = false;
      listOSavingSmsModel.clear();
      notifyListeners();
    } on DioError catch (e) {
      listOSavingSmsModel.clear();
      hideLoadingDialog();
      dummy = false;
      final error = DioException.fromDioError(e);
      snackbarService.showSnackbar(message: error.message);
      notifyListeners();
    }
  }

}
