import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/subscription/sms-management/model/delete_sms_management_schedule.dart';
import 'package:insite/views/subscription/sms-management/model/sms_reportSummary_responce_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:path_provider/path_provider.dart';

class ReportSummaryViewModel extends InsiteViewModel {
  Logger? log;

  final SmsManagementService? _smsScheduleService =
      locator<SmsManagementService>();

  ReportSummaryViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration.zero, () {
      getReportSummaryData();
    });
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        isLoadMore = true;
        startCount = startCount + 16;
        getReportSummaryData();
        notifyListeners();
      }
    });
  }

  SmsReportSummaryModel? _smsReportSummaryModel;
  SmsReportSummaryModel? get smsReportSummaryModel => _smsReportSummaryModel;

  List<ReportSummaryModel> modelDataList = [];
  List<int?> selectedId = [];
  List<DeleteSmsReport> deleteSmsReport = [];

  SmsReportSummaryModel? data;

  bool isLoading = true;
  bool isLoadMore = false;

  int startCount = 0;
  final controller = new ScrollController();

  bool showDeleteButton = false;

  getReportSummaryData() async {
    try {
      _smsReportSummaryModel =
          await _smsScheduleService!.getsmsReportSummaryModel(startCount);
      for (var i = 0; i < _smsReportSummaryModel!.result!.length; i++) {
        if (i == 0) {
          Logger().wtf(null);
          isLoading = false;
          notifyListeners();
        } else {
          _smsReportSummaryModel!.result![1].forEach((element) {
            modelDataList.add(element);
          });
          for (var i = 0; i < modelDataList.length; i++) {
            modelDataList[i].isSelected = false;
          }
          isLoading = false;
          isLoadMore = false;
          notifyListeners();
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      Logger().e(e.toString());
      notifyListeners();
    }
  }

  onSelected(int i) {
    try {
      modelDataList[i].isSelected = !modelDataList[i].isSelected!;
      if (modelDataList[i].isSelected!) {
        selectedId.add(modelDataList[i].ID);
      } else if (modelDataList[i].isSelected == false) {
        selectedId.remove(modelDataList[i].ID);
      }
      Logger().wtf(selectedId);
      setBool();
      notifyListeners();
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  setBool() {
    final checkIsSelected = modelDataList.any((element) {
      return element.isSelected == true;
    });
    if (checkIsSelected) {
      showDeleteButton = true;
      notifyListeners();
    } else {
      showDeleteButton = false;
      notifyListeners();
    }
  }

  onDeletingSmsSchedule() async {
    try {
      DeleteSmsReport deleteData;
      selectedId.forEach((id) {
        deleteData = DeleteSmsReport(ID: id);
        deleteSmsReport.add(deleteData);
        var deletingData =
            modelDataList.singleWhere((element) => element.ID == id);
        modelDataList.remove(deletingData);
        // selectedId.remove(id);
        notifyListeners();
      });
      var data =
          await _smsScheduleService!.deleteSmsScheduleReport(deleteSmsReport);
      Logger().w(selectedId.length);
      selectedId.clear();
      deleteSmsReport.clear();
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  onDownload() async {
    try {
      showLoadingDialog();
      data = await _smsScheduleService!.getScheduleReportData();
      Directory? path = await getExternalStorageDirectory();
      if (data != null) {
        final Excel excelSheet = Excel.createExcel();
        var sheetObj = excelSheet.sheets.values.first;
        for (var i = 0; i < data!.result!.first.length; i++) {
          final excelDataInsert = data!.result!.first;
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
          sheetObj.updateCell(CellIndex.indexByString("A$index"),
              excelDataInsert[i].GPSDeviceID);
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

        // excelSheet.encode().then((onValue) {
        //   File("${path.path}/SMS_schedule.xlsx")
        //     ..createSync(recursive: true)
        //     ..writeAsBytesSync(onValue)
        //     ..open(mode: FileMode.read);
        // });
        snackbarService!.showSnackbar(message: "File saved in ${path!.path}");
        // Logger().e(excelSheet.sheets.values.last.rows);
        hideLoadingDialog();
      } else {
        hideLoadingDialog();
      }
    } catch (e) {
      // hideLoadingDialog();
      Logger().e(e.toString());
    }
  }
}
