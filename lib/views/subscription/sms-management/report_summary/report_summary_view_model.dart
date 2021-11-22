import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/subscription/sms-management/model/sms_reportSummary_responce_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:path_provider/path_provider.dart';

class ReportSummaryViewModel extends InsiteViewModel {
  Logger log;

  final _smsScheduleService = locator<SmsManagementService>();

  ReportSummaryViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration.zero, () {
      getReportSummaryData();
    });
  }

  SmsReportSummaryModel _smsReportSummaryModel;
  SmsReportSummaryModel get smsReportSummaryModel => _smsReportSummaryModel;

  List<ReportSummaryModel> modelDataList = [];

  SmsReportSummaryModel data;

  bool isLoading = true;

  bool showDeleteButton = false;

  getReportSummaryData() async {
    try {
      _smsReportSummaryModel =
          await _smsScheduleService.getsmsReportSummaryModel();
      for (var i = 0; i < _smsReportSummaryModel.result.length; i++) {
        if (i == 0) {
          Logger().wtf(null);
          isLoading = false;
          notifyListeners();
        } else {
          modelDataList = _smsReportSummaryModel.result[1];
          for (var i = 0; i < modelDataList.length; i++) {
            modelDataList[i].isSelected = false;
          }
          isLoading = false;
          notifyListeners();
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  onSelected(int i) {
    try {
      modelDataList[i].isSelected = !modelDataList[i].isSelected;
      showDeleteButton = true;
      notifyListeners();
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  // setBool(int i) {
  //   modelDataList.forEach((element) {
  //     if (element.isSelected == true) {
  //       showDeleteButton = true;
  //     }
  //   });
  // }

  onDownload() async {
    try {
      showLoadingDialog();
      Directory path = await getExternalStorageDirectory();
      data = await _smsScheduleService.getScheduleReportData();
      final Excel excelSheet = Excel.createExcel();
      var sheetObj = excelSheet["sheet"];
      for (var i = 0; i < data.result.first.length; i++) {
        final excelDataInsert = data.result.first;
        if (i == 0) {
          sheetObj.updateCell(CellIndex.indexByString("A0"), "Device ID");
          sheetObj.updateCell(CellIndex.indexByString("B0"), "Serial Number");
          sheetObj.updateCell(
              CellIndex.indexByString("C0"), "Recipient’s Name");
          sheetObj.updateCell(CellIndex.indexByString("D0"), "Mobile Number");
          sheetObj.updateCell(CellIndex.indexByString("E0"), "Language");
          sheetObj.updateCell(
              CellIndex.indexByString("F0"), "Scheduled SMS Start Date");
        }
        int index = i + 1;
        sheetObj.updateCell(
            CellIndex.indexByString("A$index"), excelDataInsert[i].GPSDeviceID);
        sheetObj.updateCell(CellIndex.indexByString("B$index"),
            excelDataInsert[i].SerialNumber);
        sheetObj.updateCell(
            CellIndex.indexByString("C$index"), excelDataInsert[i].Name);
        sheetObj.updateCell(
            CellIndex.indexByString("D$index"), excelDataInsert[i].Number);
        sheetObj.updateCell(
            CellIndex.indexByString("E$index"), excelDataInsert[i].Language);
        sheetObj.updateCell(
            CellIndex.indexByString("F$index"), excelDataInsert[i].StartDate);
      }
     // Logger().e(path.path);
      excelSheet.encode().then((onValue) {
        File("${path.path}/SMS_schedule.xlsx")
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue)
          ..open(mode: FileMode.read);
      });
      snackbarService.showSnackbar(message: "File saved in ${path.path}");
     // Logger().e(excelSheet.sheets.values.last.rows);
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }
}
