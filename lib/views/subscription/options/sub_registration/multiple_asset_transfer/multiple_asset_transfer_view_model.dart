import 'dart:io';
import 'dart:isolate';

import 'package:excel/excel.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class MultipleAssetTransferViewModel extends InsiteViewModel {
  Logger? log;

  MultipleAssetTransferViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  ReceivePort port = ReceivePort();

  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  List<Transfer> _assetValues = [];
  List<Transfer> get assetValues => _assetValues;

  List<Transfer> _transferData = [];
  List<Transfer> get transferData => _transferData;

  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;

  onSampleDownload() async {
    try {
      final status = await permission.Permission.storage.request();

      if (status.isGranted) {
        Directory baseStorage = await (getExternalStorageDirectory() as Future<Directory>);
        int initialIndex = baseStorage.path.indexOf("data/");
        String path = baseStorage.path
            .replaceRange(initialIndex, baseStorage.path.length, "excel");
        // baseStorage = Directory(path);
        // Logger().e(baseStorage.path);

        final data = await FlutterDownloader.enqueue(
            url:
                "https://docs.google.com/spreadsheets/d/1XWCpH3PeR_mmUhXMyozq2CY-fQyCNMUe/edit?usp=sharing&ouid=104928811217417861871&rtpof=true&sd=true",
            savedDir: baseStorage.path,
            fileName: "Multiple Transfer Sample",
            openFileFromNotification: true);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onUpload() async {
    try {
      showLoadingDialog();
      //assetValueData.clear();
      final status = await permission.Permission.storage.request();
      if (status.isGranted) {
        // File data = await file_picker.FilePicker.getFile(fileExtension: "xlsx");
        // Logger().d(data.path);
        // var bytes = File(data.path).readAsBytesSync();
        // var excel = Excel.decodeBytes(bytes);

        // for (var i = 0;
        //     i < excel.tables[excel.tables.keys.first].rows.length;
        //     i++) {
        //   final excelData = excel.tables[excel.tables.keys.first].rows[i];

        //   if (i == 0) {
        //     Logger().d("null");
        //   } else {
        //     Transfer assetTransferValues = Transfer(
        //       deviceId: excelData[0].toString(),
        //       machineModel: excelData[1].toString(),
        //       machineSlNo: excelData[2].toString(),
        //       dealerName: excelData[3].toString(),
        //       dealerCode: excelData[4].toString(),
        //       dealerEmailID: excelData[5].toString(),
        //       dealerMobile: excelData[6].toString(),
        //       dealerLanguage: excelData[7].toString(),
        //       customerMobile: excelData[8].toString(),
        //       customerLanguage: excelData[9].toString(),
        //       primaryIndustry: excelData[10].toString(),
        //       secondaryIndustry: excelData[11].toString(),
        //       customerName: excelData[12].toString(),
        //       customerCode: excelData[13].toString(),
        //       customerEmailID: excelData[14].toString(),
        //       commissioningDate: excelData[15].toString(),
        //     );
        //     assetValues.add(assetTransferValues);
        //     Logger().wtf(excelData);
        //   }
        // }

        // _dataLoaded = true;
        // notifyListeners();
        // hideLoadingDialog();
      } else {
        snackbarService!.showSnackbar(message: "Permission Denied");
        hideLoadingDialog();
      }
    } catch (e) {
      snackbarService!.showSnackbar(
          message: "Permission Denied Only Read Files From External Storage");
      hideLoadingDialog();
    }
  }

  subscriptionMultipleTransferRegistration() async {
    Transfer deviceTransferValues;
    deviceTransferValues = Transfer(
      deviceId: assetValues[0].deviceId,
      machineSlNo: assetValues[0].machineSlNo,
      machineModel: assetValues[0].machineModel,
      customerName: assetValues[0].customerName,
      customerCode: assetValues[0].customerCode,
      customerEmailID: assetValues[0].customerEmailID,
      customerLanguage: assetValues[0].customerLanguage,
      customerMobile: assetValues[0].customerMobile,
      dealerName: assetValues[0].dealerName,
      dealerCode: assetValues[0].dealerCode,
      dealerEmailID: assetValues[0].dealerEmailID,
      dealerLanguage: assetValues[0].dealerLanguage,
      dealerMobile: assetValues[0].dealerMobile,
      commissioningDate: assetValues[0].commissioningDate,
      primaryIndustry: assetValues[0].primaryIndustry,
      secondaryIndustry: assetValues[0].secondaryIndustry,
    );
    _transferData.add(deviceTransferValues);

    var result = await (_subscriptionService!.postSingleTransferRegistration(
        transferData: _transferData) as Future<AssetTransferData>);

    final String? success = result.status;

    notifyListeners();
    return success;
  }
}
