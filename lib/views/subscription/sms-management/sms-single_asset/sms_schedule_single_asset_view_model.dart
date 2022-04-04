import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Logger? log;

  final SmsManagementService? _smsScheduleService =
      locator<SmsManagementService>();

  SmsScheduleSingleAssetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  List<SingleAssetSmsSchedule> listOfSingleAssetSmsSchedule = [];

  SingleAssetResponce? _singleAssetResponce;
  SingleAssetResponce? get singleAssetResponce => _singleAssetResponce;

  set singleAssetModelResponceSetter(List<SingleAssetModelResponce> val) {
    singleAssetModelResponce = val;
  }

  TextEditingController? _serialNoController = TextEditingController();
  TextEditingController? get serialNoController => _serialNoController;

  TextEditingController? _nameController = TextEditingController();
  TextEditingController? get nameController => _nameController;

  TextEditingController? _mobileNoController = TextEditingController();
  TextEditingController? get mobileNoController => _mobileNoController;

  SavingSmsModel? _savingSmsModel;

  List<SavingSmsModel> listOSavingSmsModel = [];

  List<SingleAssetModelResponce>? singleAssetModelResponce = [];

  PageController controller = PageController();

  bool isShowingValidateWidget = false;

  String? name;
  String? mobileNo;
  String? language;
  String? serialNo;

  String? popUpMessage;

  // List<String> nameList = [];
  // List<String> mobileNoList = [];
  // List<String> languageList = [];
  // List<String> deviceId = [];
  // List<String> model = [];
  // List<String> date = [];

  onSavingForm(String? serialNumber, String? recipientName,
      String? recipientMobNo, String? lang) async {
    try {
      showLoadingDialog();
      SingleAssetSmsSchedule data;
      // nameList.add(recipientName);
      // mobileNoList.add(recipientMobNo);
      // languageList.add(lang);
      if (serialNumber == null ||
          recipientMobNo == null ||
          recipientName == null ||
          lang == null) {
        data = SingleAssetSmsSchedule(
            AssetSerial: serialNo,
            Name: name,
            Mobile: mobileNo,
            Language: language);
        listOfSingleAssetSmsSchedule.add(data);
      } else {
        language = lang;
        mobileNo = recipientMobNo;
        name = recipientName;
        serialNo = serialNumber;
        data = SingleAssetSmsSchedule(
            AssetSerial: serialNo,
            Name: name,
            Mobile: mobileNo,
            Language: language);
        listOfSingleAssetSmsSchedule.add(data);
      }
      _singleAssetResponce = await _smsScheduleService!
          .postSingleAssetResponce(listOfSingleAssetSmsSchedule);
      if (_singleAssetResponce!.result!.isEmpty) {
        hideLoadingDialog();
        clearingControllerValue();
        Fluttertoast.showToast(
            msg:
                "Please check the entered value, AssetSerialNumber not matching.");
        notifyListeners();
        return;
      } else {
        singleAssetModelResponce = _singleAssetResponce!.result;
        isShowingValidateWidget = true;
        listOfSingleAssetSmsSchedule.clear();
        controller.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        hideLoadingDialog();
      }

      // for (var item in singleAssetModelResponce) {
      //   deviceId.add(item.GPSDeviceID);
      //   model.add(item.Model);
      //   serialNo.add(item.SerialNumber);
      //   date.add(item.StartDate);
      // }

      notifyListeners();
    } on DioError catch (e) {
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService!.showCustomSnackBar(message: e.message);
      notifyListeners();
    }
  }

  onBackPressed() {
    _serialNoController!.text = serialNo!;
    _mobileNoController!.text = mobileNo!;
    _nameController!.text = name!;
    isShowingValidateWidget = false;
    controller.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    notifyListeners();
  }

  clearingControllerValue() {
    _serialNoController!.clear();
    _mobileNoController!.clear();
    _nameController!.clear();
  }

  Future<SavingSmsResponce?> onSavingSmsModel() async {
    try {
      for (var i = 0; i < singleAssetModelResponce!.length; i++) {
        _savingSmsModel = SavingSmsModel(
            AssetSerial: singleAssetModelResponce![i].SerialNumber,
            GPSDeviceID: singleAssetModelResponce![i].GPSDeviceID,
            Language: language,
            Mobile: mobileNo,
            Model: singleAssetModelResponce![i].Model,
            Name: name,
            StartDate: singleAssetModelResponce![i].StartDate);
        listOSavingSmsModel.add(_savingSmsModel!);
      }
      var data = await _smsScheduleService!.savingSms(listOSavingSmsModel);
      clearingControllerValue();
      hideLoadingDialog();
      listOSavingSmsModel.clear();
      singleAssetModelResponce!.clear();
      isShowingValidateWidget = false;
      notifyListeners();
      controller.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      return data;
    } on DioError catch (e) {
      listOSavingSmsModel.clear();
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService!.showSnackbar(message: error.message!);
      notifyListeners();
    }
  }
}
