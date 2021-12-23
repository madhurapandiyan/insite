import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/replacement_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_status_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:open_file/open_file.dart';

class DeviceReplacementStatusViewModel extends InsiteViewModel {
  Logger? log;

  final ReplacementService? replacementService = locator<ReplacementService>();

  DeviceReplacementStatusViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration.zero, () async {
      await getTotalDeviceReplacementStatusModel();
      controller.addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          isLoadMore = true;
          startCount = startCount + 16;
          getTotalDeviceReplacementStatusModel();
          notifyListeners();
        }
      });
    });
  }

  bool isLoading = true;
  bool isLoadMore = false;

  List<DeviceReplacementStatusModel> deviceReplacementStatusModelList = [];

  TotalDeviceReplacementStatusModel? totalDeviceReplacementStatusModel;
  int startCount = 0;
  final controller = new ScrollController();

  getTotalDeviceReplacementStatusModel() async {
    try {
      totalDeviceReplacementStatusModel = await replacementService!
          .getTotalDeviceReplacementStatusModel(startCount);
      Logger().wtf(totalDeviceReplacementStatusModel);
      Logger().d(deviceReplacementStatusModelList);
      totalDeviceReplacementStatusModel!.result![1].forEach((element) {
        deviceReplacementStatusModelList.add(element);
      });
      isLoading = false;
      isLoadMore = false;
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onDownload() async {
    try {
      showLoadingDialog();
      Directory? path = await (pathProvider.getExternalStorageDirectory());
      var data = await replacementService!.getReplacementDeviceIdDownload();
      Logger().d(data!.toJson());
      final Excel excelSheet = Excel.createExcel();
      var sheetObj = excelSheet.sheets.values.first;
      for (var i = 0; i < data.result!.length; i++) {
        final excelDataInsert = data.result!;
        if (i == 0) {
          sheetObj.updateCell(CellIndex.indexByString("A0"), "Old Device ID");
          sheetObj.updateCell(CellIndex.indexByString("B0"), "Serial Number");
          sheetObj.updateCell(CellIndex.indexByString("C0"), "New Device ID");
          sheetObj.updateCell(CellIndex.indexByString("D0"), "Reason");
          sheetObj.updateCell(
              CellIndex.indexByString("E0"), "Replacement Status");
          sheetObj.updateCell(CellIndex.indexByString("F0"), "Description");
          sheetObj.updateCell(CellIndex.indexByString("G0"), "First Name");
          sheetObj.updateCell(CellIndex.indexByString("H0"), "Last Name");
          sheetObj.updateCell(CellIndex.indexByString("I0"), "User Email");
          sheetObj.updateCell(CellIndex.indexByString("J0"), "Request Time");
        }
        int index = i + 1;
        sheetObj.updateCell(
            CellIndex.indexByString("A$index"), excelDataInsert[i].OldDeviceId);
        sheetObj.updateCell(
            CellIndex.indexByString("B$index"), excelDataInsert[i].VIN);
        sheetObj.updateCell(
            CellIndex.indexByString("C$index"), excelDataInsert[i].NewDeviceId);
        sheetObj.updateCell(
            CellIndex.indexByString("D$index"), excelDataInsert[i].Reason);
        sheetObj.updateCell(
            CellIndex.indexByString("E$index"), excelDataInsert[i].State);
        sheetObj.updateCell(
            CellIndex.indexByString("F$index"), excelDataInsert[i].Description);
        sheetObj.updateCell(
            CellIndex.indexByString("G$index"), excelDataInsert[i].FirstName);
        sheetObj.updateCell(
            CellIndex.indexByString("H$index"), excelDataInsert[i].LastName);
        sheetObj.updateCell(
            CellIndex.indexByString("I$index"), excelDataInsert[i].EmailID);
        sheetObj.updateCell(
            CellIndex.indexByString("J$index"),
            Utils.getLastReportedDateFilterData(
                DateTime.parse(excelDataInsert[i].InsertUTC!)));
      }
      var savefile = excelSheet.save();
      File("${path!.path}/Device_Replacement_Report.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(savefile!);
      OpenFile.open("${path.path}/Device_Replacement_Report.xlsx");
      // excelSheet.encode()!.then((onValue) {
      //   File("${path.path}/Device_Replacement_Report.xlsx")
      //     ..createSync(recursive: false)
      //     ..writeAsBytesSync(onValue)
      //     ..open(mode: FileMode.read);
      // });
      hideLoadingDialog();
      //snackbarService!.showSnackbar(message: "File saved in ${path.path}");
      // Logger().e(excelSheet.sheets.values.last.rows);
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }
}
