import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/subscription/sms-management/model/saving_sms_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:insite/views/subscription/sms-management/sms-single_asset/sms_schedule_single_asset_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SmsScheduleMultiAssetViewModel extends InsiteViewModel {
  Logger log;

  SmsScheduleMultiAssetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  final _smsScheduleService = locator<SmsManagementService>();

  List<SingleAssetSmsSchedule> listOfSingleAssetSmsSchedule = [];

  SingleAssetResponce _singleAssetResponce;
  SingleAssetResponce get singleAssetResponce => _singleAssetResponce;

  List<SingleAssetModelResponce> singleAssetModelResponce = [];

  SavingSmsModel _savingSmsModel;

  List<SavingSmsModel> listOSavingSmsModel = [];

  ReceivePort port = ReceivePort();

  List<String> nameList = [];
  List<String> mobileNoList = [];
  List<String> languageList = [];
  List<String> deviceId = [];
  List<String> model = [];
  List<String> date = [];
  List<String> serialNo = [];

  onUpload() async {
    try {
      showLoadingDialog();
      listOfSingleAssetSmsSchedule.clear();
      final status = await permission.Permission.storage.request();
      if (status.isGranted) {
        File data = await file_picker.FilePicker.getFile(fileExtension: "xlsx");
        Logger().d(data.path);
        var bytes = File(data.path).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          for (var i = 0; i < excel.tables[table].rows.length; i++) {
            final excelData = excel.tables[table].rows[i];
            if (i == 0) {
              Logger().d("null");
            } else {
              double mobNo = excelData[2];
              SingleAssetSmsSchedule data = SingleAssetSmsSchedule(
                  AssetSerial: excelData[0].toString(),
                  Name: excelData[1].toString(),
                  Mobile: mobNo.toInt().toString(),
                  Language: excelData[3].toString());
              listOfSingleAssetSmsSchedule.add(data);
            }
          }
        }
        onGettingMultiSmsData();
      } else {
        snackbarService.showSnackbar(message: "Permission Denied");
        hideLoadingDialog();
      }
    } catch (e) {
      snackbarService.showSnackbar(
          message: "Permission Denied Only Read Files From External Storage");
      hideLoadingDialog();
    }
  }

  onSampleDownload() async {
    try {
      final status = await permission.Permission.storage.request();
      if (status.isGranted) {
        Directory baseStorage = await getExternalStorageDirectory();
        int initialIndex = baseStorage.path.indexOf("data/");
        String path = baseStorage.path
            .replaceRange(initialIndex, baseStorage.path.length, "excel");
        // baseStorage = Directory(path);
        // Logger().e(baseStorage.path);

        final data = await FlutterDownloader.enqueue(
            url:
                "https://docs.google.com/spreadsheets/d/1sriUTiniAgufje5WQjdW0_oy3Di8nzf6/edit?usp=sharing&ouid=111783955878329228306&rtpof=true&sd=true",
            savedDir: baseStorage.path,
            fileName: "Sample Documents",
            openFileFromNotification: true);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onGettingMultiSmsData() async {
    try {
      if (listOfSingleAssetSmsSchedule == null) {
        notifyListeners();
      } else {
        nameList.clear();
        mobileNoList.clear();
        languageList.clear();
        _singleAssetResponce = await _smsScheduleService
            .postSingleAssetResponce(listOfSingleAssetSmsSchedule);
        singleAssetModelResponce = _singleAssetResponce.result;

        for (var item in listOfSingleAssetSmsSchedule) {
          nameList.add(item.Name);
          mobileNoList.add(item.Mobile);
          languageList.add(item.Language);
        }
        for (var item in singleAssetModelResponce) {
          serialNo.add(item.SerialNumber);
        }
        notifyListeners();
        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());

      final errorMsg = DioException.fromDioError(e);
      snackbarService.showSnackbar(message: errorMsg.message);
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

  Future onSavingSmsModel() async {
    try {
      for (var i = 0; i < singleAssetModelResponce.length; i++) {
        _savingSmsModel = SavingSmsModel(
            AssetSerial: serialNo[i],
            GPSDeviceID: singleAssetModelResponce[i].GPSDeviceID,
            Language: languageList[i],
            Mobile: mobileNoList[i],
            Model: singleAssetModelResponce[i].Model,
            Name: nameList[i],
            StartDate: singleAssetModelResponce[i].StartDate);
        listOSavingSmsModel.add(_savingSmsModel);
      }
      Logger().d(_savingSmsModel.toJson());
      var data = await _smsScheduleService.savingSms(listOSavingSmsModel);

      listOSavingSmsModel.clear();
      notifyListeners();
    } on DioError catch (e) {
      listOSavingSmsModel.clear();
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService.showSnackbar(message: error.message);
      notifyListeners();
    }
  }
}
