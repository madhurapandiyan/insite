import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/subscription/sms-management/model/saving_sms_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class SmsScheduleMultiAssetViewModel extends InsiteViewModel {
  Logger? log;

  SmsScheduleMultiAssetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  final SmsManagementService? _smsScheduleService =
      locator<SmsManagementService>();

  List<SingleAssetSmsSchedule> listOfSingleAssetSmsSchedule = [];

  SingleAssetResponce? _singleAssetResponce;
  SingleAssetResponce? get singleAssetResponce => _singleAssetResponce;

  List<SingleAssetModelResponce>? singleAssetModelResponce = [];

  SavingSmsModel? _savingSmsModel;

  List<SavingSmsModel> listOSavingSmsModel = [];

  SavingSmsResponce? savingData;

  ReceivePort port = ReceivePort();

  List<String?> nameList = [];
  List<String?> mobileNoList = [];
  List<String?> languageList = [];
  List<String> deviceId = [];
  List<String> model = [];
  List<String> date = [];
  List<String?> serialNo = [];

  onUpload() async {
    try {
      SingleAssetSmsSchedule? SingleAssetSmsScheduleData;
      List<String> extractedData = [];
      showLoadingDialog();
      listOfSingleAssetSmsSchedule.clear();
      final status = await Permission.storage.request();
      if (status.isGranted) {
        file_picker.FilePickerResult? data =
            await file_picker.FilePicker.platform.pickFiles(
                allowedExtensions: ["xlsx"], type: file_picker.FileType.custom);

        var bytes = File(data!.paths.first!)..createSync(recursive: true);
        var excel = Excel.decodeBytes(bytes.readAsBytesSync());
        for (var table in excel.tables.keys) {
          // Logger().w(excel.tables[table]!.rows);
          for (var i = 0; i < excel.tables[table]!.rows.length; i++) {
            var data = excel.tables[table]!.rows[i];
            if (i == 0) {
            } else {
              data.forEach((element) {
                extractedData.add(element!.value.toString());
              });
              for (var i = 0; i < extractedData.length; i++) {
                SingleAssetSmsScheduleData = SingleAssetSmsSchedule(
                    AssetSerial: extractedData[0],
                    Name: extractedData[1],
                    Mobile: double.parse(extractedData[2]).toInt().toString(),
                    Language: extractedData[3]);
              }
              listOfSingleAssetSmsSchedule.add(SingleAssetSmsScheduleData!);
              extractedData.clear();
            }
          }
        }

        listOfSingleAssetSmsSchedule.forEach((element) {
          Logger().i(element.toJson());
        });

        // for (var table in excel.tables.keys) {
        //   Logger().w(excel.tables[table]!.rows);
        //   for (var i = 0; i < excel.tables[table]!.rows.length; i++) {
        //     for (List<Data?> data in excel.tables[table]!.rows) {
        //       data.forEach((element) {
        //         print(element!.value);
        //       });
        //     }
        //     // Logger().e(excel.tables[table]!.rows.length);
        //     final excelData = excel.tables[table]!;
        //     //Logger().e(excelData.rows.first.first);

        //     if (i == 0) {
        //       Logger().d("null");
        //     } else {
        //       // double mobNo = excelData[2];
        //       // SingleAssetSmsSchedule data = SingleAssetSmsSchedule(
        //       //     AssetSerial: excelData[0].toString(),
        //       //     Name: excelData[1].toString(),
        //       //     Mobile: mobNo.toInt().toString(),
        //       //     Language: excelData[3].toString());
        //       // listOfSingleAssetSmsSchedule.add(data);
        //       //  excelData.clear();
        //     }
        //   }
        // }
        onGettingMultiSmsData();
      } else {
        snackbarService!.showSnackbar(message: "Permission Denied");
        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());
      snackbarService!.showSnackbar(
          message: "Permission Denied Only Read Files From External Storage");
      hideLoadingDialog();
    }
  }

  onSampleDownload() async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        Directory? baseStorage = await getExternalStorageDirectory();
        int initialIndex = baseStorage!.path.indexOf("data/");
        String path = baseStorage.path
            .replaceRange(initialIndex, baseStorage.path.length, "excel");
        // baseStorage = Directory(path);
        // Logger().e(baseStorage.path);

        // final data = await FlutterDownloader.enqueue(
        //   url:
        //       "https://docs.google.com/spreadsheets/d/1sriUTiniAgufje5WQjdW0_oy3Di8nzf6/edit?usp=sharing&ouid=111783955878329228306&rtpof=true&sd=true",
        //   savedDir: baseStorage.path,
        //   fileName: "Sample_Documents",
        // );
        Logger().e("${baseStorage.path}/Sample_Documents.bin");
       // OpenFile.open("${baseStorage.path}/Sample_Documents.BIN");
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onGettingMultiSmsData() async {
    try {
      if (listOfSingleAssetSmsSchedule.isEmpty) {
        notifyListeners();
      } else {
        nameList.clear();
        mobileNoList.clear();
        languageList.clear();
        _singleAssetResponce = await _smsScheduleService!
            .postSingleAssetResponce(listOfSingleAssetSmsSchedule);
        singleAssetModelResponce = _singleAssetResponce!.result;

        for (var item in listOfSingleAssetSmsSchedule) {
          if (singleAssetModelResponce!
              .any((element) => element.SerialNumber == item.AssetSerial)) {
            nameList.add(item.Name);
            mobileNoList.add(item.Mobile);
            languageList.add(item.Language);
          }
        }
        for (var item in singleAssetModelResponce!) {
          serialNo.add(item.SerialNumber);
        }
        notifyListeners();
        hideLoadingDialog();
      }
    } on DioError catch (e) {
      Logger().e(e.toString());

      final errorMsg = DioException.fromDioError(e);
      snackbarService!.showSnackbar(message: errorMsg.message!);
    }
  }

  onBackPressed() {
    showLoadingDialog();
    Future.delayed(Duration(seconds: 2), () {
      nameList.clear();
      mobileNoList.clear();
      languageList.clear();
      singleAssetModelResponce!.clear();
      hideLoadingDialog();
      notifyListeners();
    });
  }

  Future<bool?> onSavingSmsModel() async {
    try {
      for (var i = 0; i < singleAssetModelResponce!.length; i++) {
        _savingSmsModel = SavingSmsModel(
            AssetSerial: serialNo[i],
            GPSDeviceID: singleAssetModelResponce![i].GPSDeviceID,
            Language: languageList[i],
            Mobile: mobileNoList[i],
            Model: singleAssetModelResponce![i].Model,
            Name: nameList[i],
            StartDate: singleAssetModelResponce![i].StartDate);
        listOSavingSmsModel.add(_savingSmsModel!);
      }
      Logger().d(_savingSmsModel!.toJson());
      savingData = await _smsScheduleService!.savingSms(listOSavingSmsModel);
      Logger().e(savingData!.toJson());
      if (savingData!.status == "failed") {
        hideLoadingDialog();
        //onBackPressed();
        return false;
      }
      onBackPressed();
      listOSavingSmsModel.clear();
      notifyListeners();
      return true;
    } on DioError catch (e) {
      listOSavingSmsModel.clear();
      hideLoadingDialog();
      final error = DioException.fromDioError(e);
      snackbarService!.showSnackbar(message: error.message!);
      notifyListeners();
    }
  }

  onDownloadingExcelSheet() async {
    showLoadingDialog();
    Directory? path = await (pathProvider.getExternalStorageDirectory());
    final Excel excelSheet = Excel.createExcel();
    var sheetObj = excelSheet.sheets.values.first;
    for (var i = 0; i < savingData!.AssetSerialNo!.length; i++) {
      final excelDataInsert = savingData!.AssetSerialNo!;
      if (i == 0) {
        sheetObj.updateCell(CellIndex.indexByString("A0"), "Device ID");
        sheetObj.updateCell(
            CellIndex.indexByString("B0"), "Asset Serial Number");
        sheetObj.updateCell(CellIndex.indexByString("C0"), "Recipient’s Name");
        sheetObj.updateCell(
            CellIndex.indexByString("D0"), "Recipient Mobile Number");
        sheetObj.updateCell(CellIndex.indexByString("D0"), "Language");
      } else {
        int index = i + 1;
        sheetObj.updateCell(
            CellIndex.indexByString("A$index"), excelDataInsert[i].GPSDeviceID);
        sheetObj.updateCell(
            CellIndex.indexByString("B$index"), excelDataInsert[i].AssetSerial);
        sheetObj.updateCell(
            CellIndex.indexByString("C$index"), excelDataInsert[i].Name);
        sheetObj.updateCell(
            CellIndex.indexByString("D$index"), excelDataInsert[i].Model);
        sheetObj.updateCell(
            CellIndex.indexByString("E$index"), excelDataInsert[i].Language);
      }
      hideLoadingDialog();
      var savefile = excelSheet.save();
      File("${path!.path}/Exists_Combinations_export.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(savefile!);
      //OpenFile.open("${path.path}/Exists_Combinations_export.xlsx");
    }
  }
}

// Serial number, Mobile number, Language and Recipient’s Name combination is already exists. Do you want to download?