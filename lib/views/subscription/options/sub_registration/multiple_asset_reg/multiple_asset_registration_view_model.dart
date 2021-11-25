import 'dart:io';
import 'dart:isolate';

import 'package:excel/excel.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class MultipleAssetRegistrationViewModel extends InsiteViewModel {
  Logger log;

  MultipleAssetRegistrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ReceivePort port = ReceivePort();
  var _subscriptionService = locator<SubScriptionService>();

  List<AssetValues> _assetValueData = [];
  List<AssetValues> get assetValueData => _assetValueData;

  List<AssetValues> _assetData = [];
  List<AssetValues> get assetData => _assetData;

  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;

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
                "https://insite.frame-oesolutions.com/assets/files/Sample-multiple.xlsx",
            savedDir: baseStorage.path,
            fileName: "Sample- multiple",
            openFileFromNotification: true);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onUpload() async {
    try {
      showLoadingDialog();
      assetValueData.clear();
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
              AssetValues assetValues = AssetValues(
                  deviceId: excelData[0].toString(),
                  machineModel: excelData[1].toString(),
                  machineSlNo: excelData[2].toString(),
                  hMR: excelData[3].toInt(),
                  hMRDate: excelData[4].toString(),
                  plantName: excelData[5].toString(),
                  plantCode: excelData[6].toString(),
                  plantEmailID: excelData[7].toString(),
                  dealerName: excelData[8].toString(),
                  dealerCode: excelData[9].toString(),
                  dealerEmailID: excelData[10].toString(),
                  customerName: excelData[11].toString(),
                  customerCode: excelData[12].toString(),
                  customerEmailID: excelData[13].toString());
              assetValueData.add(assetValues);
            }
          }
        }
        Logger().wtf(assetValueData[0].toJson());
        _dataLoaded = true;
        notifyListeners();
        hideLoadingDialog();
        // onGettingMultiSmsData();
      } else {
        snackbarService.showSnackbar(message: "Permission Denied");
        hideLoadingDialog();
      }
    } catch (e) {
      snackbarService.showSnackbar(
          message: "Permission Denied Only Read Files From External Storage");
      //hideLoadingDialog();
    }
  }

  subscriptionMultipleAssetRegistration() async {
    AssetValues deviceAssetValues;
    deviceAssetValues = AssetValues(
      deviceId: assetValueData[0].deviceId,
      machineSlNo: assetValueData[0].machineSlNo,
      machineModel: assetValueData[0].machineModel,
      hMRDate: assetValueData[0].hMRDate,
      hMR: assetValueData[0].hMR,
      plantName: assetValueData[0].plantName,
      plantCode: assetValueData[0].plantCode,
      plantEmailID: assetValueData[0].plantEmailID,
      customerName: assetValueData[0].customerName,
      customerCode: assetValueData[0].customerCode,
      customerEmailID: assetValueData[0].customerEmailID,
      dealerName: assetValueData[0].dealerName,
      dealerCode: assetValueData[0].dealerCode,
      dealerEmailID: assetValueData[0].dealerEmailID,
      commissioningDate: assetValueData[0].commissioningDate,
      primaryIndustry: assetValueData[0].primaryIndustry,
      secondaryIndustry: assetValueData[0].secondaryIndustry,
    );
    _assetData.add(deviceAssetValues);

    var result = await _subscriptionService.postSingleAssetRegistration(
        data: _assetData);

    notifyListeners();
    return result;
  }
}
