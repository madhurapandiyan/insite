import 'dart:io';
import 'dart:isolate';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/views/subscription/sms-management/model/delete_sms_management_schedule.dart';
import 'package:insite/views/subscription/sms-management/model/sms_reportSummary_responce_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class ReportSummaryViewModel extends InsiteViewModel {
  Logger? log;

  final SmsManagementService? _smsScheduleService =
      locator<SmsManagementService>();
  LocalService? _localService = locator<LocalService>();
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

  int startLimit = 0;
  int? endLimit;
  int totalCount = 0;

  int startCount = 0;
  final controller = new ScrollController();

  bool showDeleteButton = false;

  getReportSummaryData() async {
    try {
      if (enableGraphQl) {
        int start = 1;
        int limit = 100;
        SmsReportSummaryModel? smsSummaryModel = await _smsScheduleService!
            .getsmsReportSummaryModel(
                0, graphqlSchemaService!.getSmsReportSummary(),{
                  "start":start,
                  "limit":limit
                });

        if (smsSummaryModel != null) {
          // totalCount = smsSummaryModel.getSMSSummaryReport?.length??0;   
         // Logger().wtf("totalCount:$totalCount");
          if (smsSummaryModel.getSMSSummaryReport != null) {
            for (GetSmsSummaryReport element
                in smsSummaryModel.getSMSSummaryReport!) {
              modelDataList.add(ReportSummaryModel(
                  id: element.id,
                  gpsDeviceId: element.gpsDeviceId,
                  serialNumber: element.serialNumber,
                  name: element.name,
                  number: element.number,
                  startDate: element.startDate,
                  language: element.language));
                  totalCount = modelDataList.length; 
            }
           
            isLoading = false;
            isLoadMore = false;
            notifyListeners();
          } else {
            isLoading = false;
            isLoadMore = false;
            notifyListeners();
          }
        } else {
          isLoading = false;
          isLoadMore = false;
          notifyListeners();
        }
      } else {
        _smsReportSummaryModel =
            await _smsScheduleService!.getsmsReportSummaryModel(startCount, "");
        totalCount = smsReportSummaryModel!.result!.first.first.count!;
        Logger().wtf("totalCount:$totalCount");
        for (var i = 0; i < _smsReportSummaryModel!.result!.length; i++) {
          if (i == 0) {
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
      }
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
        selectedId.add(modelDataList[i].id);
      } else if (modelDataList[i].isSelected == false) {
        selectedId.remove(modelDataList[i].id);
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
      var userId = await _localService!.getUserId();
      var id = int.parse(userId as String);
      //List deleteSms = [];
      DeleteSmsReport deleteData;
      selectedId.forEach((id) {
        deleteData = DeleteSmsReport(ID: id);

        // var deleteSMSRequest={"id":id};
        // deleteSms.add(deleteSMSRequest);

        Logger().w(deleteData.ID);

        deleteSmsReport.add(deleteData);
        var deletingData =
            modelDataList.singleWhere((element) => element.id == id);
        modelDataList.remove(deletingData);
        notifyListeners();
      });
      var data = await _smsScheduleService!
          .deleteSmsScheduleReport(deleteSmsReport, id);
      Logger().w(selectedId.length);
      selectedId.clear();
      deleteSmsReport.clear();
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  List<ReportSummaryModel> getListRange(List<ReportSummaryModel> listData) {
    Iterable<ReportSummaryModel> data = listData.getRange(0, 1000);
    return data as List<ReportSummaryModel>;
  }

  onDownload() async {
    try {
      showLoadingDialog();
      Directory? path = await (pathProvider.getExternalStorageDirectory());
      data = await _smsScheduleService!.getScheduleReportData();
      var isolateData = await compute(onExcelSheetUpdate, data!.result!.first);
      var saveFile = isolateData!.save();
      File("${path!.path}/report_summary.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(saveFile!);
      hideLoadingDialog();
      //OpenFile.open("${path.path}/report_summary.xlsx");
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  static Future<Excel?> onExcelSheetUpdate(
      List<ReportSummaryModel> data) async {
    try {
      Logger().e("function running");
      final Excel excelSheet = Excel.createExcel();

      //Directory path = await getExternalStorageDirectory();
      var sheetObj = excelSheet.sheets.values.first;
      for (var i = 0; i < data.length; i++) {
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
            CellIndex.indexByString("A$index"), data[i].gpsDeviceId);
        sheetObj.updateCell(
            CellIndex.indexByString("B$index"), data[i].serialNumber);
        sheetObj.updateCell(CellIndex.indexByString("C$index"), data[i].name);
        sheetObj.updateCell(CellIndex.indexByString("D$index"), data[i].number);
        sheetObj.updateCell(
            CellIndex.indexByString("E$index"), data[i].language);
        sheetObj.updateCell(
            CellIndex.indexByString("F$index"), data[i].startDate);
      }
      Logger().e("excel sheet update");
      return excelSheet;
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
