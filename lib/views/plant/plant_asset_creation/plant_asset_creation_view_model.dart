import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_creation_payload.dart';
import 'package:insite/core/models/asset_creation_reset_data.dart';
import 'package:insite/core/models/asset_creation_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/plant_hierachy_service.dart';
import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

class PlantAssetCreationViewModel extends InsiteViewModel {
  Logger log;

  var _localService = locator<LocalService>();

  PlantAssetCreationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  var _plantService = locator<PlantHeirarchyAssetService>();

  int selectedIndex;

  String assetSerialValue;

  String deviceValue;

  String hourMeterValue;

  AssetCreationResetData result;

  bool _issubmitButtonState = false;
  bool get issubmitButtonState => _issubmitButtonState;

  TextEditingController modelController = new TextEditingController();

  bool _isResetButtonState = false;
  bool get isResetButtonState => _isResetButtonState;

  final formKeyScreenOne = GlobalKey<FormState>();
  final formKeyScreenTwo = GlobalKey<FormState>();

  bool screenOne = false;

  bool _isChangingSubmitAndResetButtonState = false;
  bool get isChangingSubmitAndResetButtonState =>
      _isChangingSubmitAndResetButtonState;

  bool _containerState = false;
  bool get containerState => _containerState;

  var _snackbarService = locator<SnackbarService>();

  List<AssetCreationModel> getassetCreationListData = [
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
    AssetCreationModel(
        assetSerialNo: "",
        deviceId: "",
        model: "",
        hourMeter: "",
        status: "",
        message: "",
        isSelected: false),
  ];

  getAssetSerialListValue(String value, int index) {
    selectedIndex = index;
    assetSerialValue = value;
    getassetCreationListData[index].assetSerialNo = value;

    checkResetAndSubmitButtonVisiblity(value);

    getAssetCreationData(value, index);
  }

  getDeviceIdListValue(String value, int index) {
    selectedIndex = index;
    getassetCreationListData[index].deviceId = value;
    checkResetAndSubmitButtonVisiblity(value);

    notifyListeners();
  }

  getHrsMeterListValue(String value, int index) {
    getassetCreationListData[index].hourMeter = value;

    checkResetAndSubmitButtonVisiblity(value);
  }

  getAssetCreationData(String value, int index) async {
    if (value.length < 4) {
      return null;
    } else {
      AssetCreationResponse data =
          await _plantService.getAssetCreationData(value);
      getassetCreationListData[index].model = data.result.modelName;
      notifyListeners();
    }
  }

  bool validate() {
    try {
      if (getassetCreationListData[selectedIndex].assetSerialNo.length < 9 &&
          getassetCreationListData[selectedIndex].assetSerialNo.isEmpty) {
        _snackbarService.showSnackbar(
            message:
                "Request contains special character or character length is less than 8, Please recheck & retry!!!");
        return false;
      } else if (getassetCreationListData[selectedIndex].deviceId.isEmpty &&
          getassetCreationListData[selectedIndex].deviceId.length < 9) {
        _snackbarService.showSnackbar(
            message:
                "Request contains special character or character length is less than 8, Please recheck & retry!!!");
        return false;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return true;
  }

  changedResetButtonState() {
    _isChangingSubmitAndResetButtonState = false;
    _containerState = false;
    // _isResetButtonState = false;
    notifyListeners();
  }

  checkResetAndSubmitButtonVisiblity(String value) {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[i];

      if (value.isNotEmpty) {
        _issubmitButtonState = true;
        _isResetButtonState = true;
        notifyListeners();
      } else if (data.assetSerialNo == value &&
          data.deviceId == value &&
          data.hourMeter == value) {
        _issubmitButtonState = false;
        _isResetButtonState = false;
        notifyListeners();
      } else {
        _issubmitButtonState = false;
        _isResetButtonState = false;
        notifyListeners();
      }
    }
  }

  submitAssetCreationData() async {
    showLoadingDialog();

    try {
      String userId = await _localService.getUserId();
      List<Asset> getAssetPayLoad = [];
      Logger().d(getassetCreationListData.length);
      getassetCreationListData.forEach((item) {
        if (item.assetSerialNo.isEmpty &&
            item.deviceId.isEmpty &&
            item.model.isEmpty &&
            item.hourMeter.isEmpty) {
        } else {
          getAssetPayLoad.add(Asset(
              machineSerialNumber: item.assetSerialNo,
              deviceId: item.deviceId,
              HMRValue: item.hourMeter,
              model: item.model));
        }
      });
      if (getAssetPayLoad.isEmpty) {
        return;
      } else {
        result = await _plantService.submitAssetCreationData(
            AssetCreationPayLoad(
                Source: "THC",
                asset: getAssetPayLoad,
                UserID: int.parse(userId)));
      }
      for (int i = 0; i < result.result.length; i++) {
        getassetCreationListData.forEach((element) {
          if (element.assetSerialNo.trim().toUpperCase() ==
              result.result[i].vin) {
            element.status = result.result[i].status;
            element.message = result.result[i].message;
          }
        });
      }

      _isChangingSubmitAndResetButtonState = true;
      _isResetButtonState = true;
      _issubmitButtonState = false;
      screenOne = true;
      notifyListeners();
      hideLoadingDialog();
    } catch (e) {}
  }

  onClickResetButton() {
    try {
      if (screenOne) {
        _isResetButtonState = true;
        _issubmitButtonState = false;

        formKeyScreenTwo.currentState.reset();
        getassetCreationListData.forEach((element) {
          element.model = null;
        });
        screenOne = !screenOne;
        _isChangingSubmitAndResetButtonState = false;
        _isResetButtonState = false;

        notifyListeners();
      } else {
        formKeyScreenOne.currentState.reset();

        getassetCreationListData.forEach((element) {
          element.model = "";
        });
        _issubmitButtonState = false;
        _isResetButtonState = false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  downloadAssetCreationData() async {
    try {
      showLoadingDialog();
      Directory path = await getExternalStorageDirectory();
      AssetCreationResetData result =
          await _plantService.downloadAssetCreationData();
      if (result != null) {
        final Excel excelSheet = Excel.createExcel();
        var sheetObj = excelSheet.sheets.values.first;
        for (var i = 0; i < result.result.length; i++) {
          final excelDataInsert = result.result[i];
          if (i == 0) {
            sheetObj.updateCell(CellIndex.indexByString("A0"), "Device ID");
            sheetObj.updateCell(CellIndex.indexByString("B0"), "Serial Number");
            sheetObj.updateCell(CellIndex.indexByString("C0"), "Model");
            sheetObj.updateCell(CellIndex.indexByString("D0"), "Hour Meter");
            sheetObj.updateCell(CellIndex.indexByString("E0"), "Created At");
          } else {
            int index = i + 1;
            sheetObj.updateCell(CellIndex.indexByString("A$index"),
                excelDataInsert.GPSDeviceID);

            sheetObj.updateCell(
                CellIndex.indexByString("B$index"), excelDataInsert.VIN);
            sheetObj.updateCell(
                CellIndex.indexByString("C$index"), excelDataInsert.Model);
            sheetObj.updateCell(
                CellIndex.indexByString("D$index"), excelDataInsert.HMRValue);
            sheetObj.updateCell(CellIndex.indexByString("E$index"),
                excelDataInsert.AssetCreationDate);
          }
        }

        // excelSheet.encode().then((onValue) {
        //   File("${path.path}/Asset Creation_export_20211130183645.xlsx")
        //     ..createSync(recursive: true)
        //     ..writeAsBytesSync(onValue)
        //     ..open(mode: FileMode.read);
        // });
        snackbarService.showSnackbar(message: "File saved in ${path.path}");
        Logger().w("File saved in ${path.path}");

        hideLoadingDialog();
      } else {
        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onItemSelect(int index) {
    getassetCreationListData[index].isSelected =
        !getassetCreationListData[index].isSelected;
    notifyListeners();
  }
}
