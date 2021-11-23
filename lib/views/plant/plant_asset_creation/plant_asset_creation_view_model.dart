import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_creation_response.dart';
import 'package:insite/core/services/plant_hierachy_service.dart';
import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PlantAssetCreationViewModel extends InsiteViewModel {
  Logger log;

  PlantAssetCreationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  var _plantService = locator<PlantHeirarchyAssetService>();

  var _snackbarService = locator<SnackbarService>();

  List<AssetCreationModel> getassetCreationListData = [
    AssetCreationModel(
        assetSerialNo: "", deviceId: "", model: "", hourMeter: ""),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
    AssetCreationModel(
      assetSerialNo: "",
      deviceId: "",
      model: "",
      hourMeter: "",
    ),
  ];

  getAssetSerialListValue(String value, int index) {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[index];
      if (value != null) {
        data.assetSerialNo = value;
      }
    }
    getAssetCreationData(value, index);
  }

  getAssetSerialData() {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[i];

      print("assetSerial:${data.assetSerialNo}");
    }
  }

  getModelListValue(String value, int index) {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[index];
      if (value != null) {
        data.model = value;
      }
    }
  }

  getModelData() {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[i];
      print("model:${data.model}");
    }
  }

  getDeviceIdListValue(String value, int index) {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[index];
      if (value != null) {
        data.deviceId = value;
      }
    }
  }

  getDeviceIdData() {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[i];
      print("deviceId:${data.deviceId}");
    }
  }

  getHrsMeterListValue(String value, int index) {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[index];
      if (value != null) {
        data.hourMeter = value;
      }
    }
  }

  getHrsMeterData() {
    for (int i = 0; i < getassetCreationListData.length; i++) {
      var data = getassetCreationListData[i];
      print("hourMater:${data.hourMeter}");
    }
  }

  getAssetCreationData(String value, int index) async {
    if (value.length < 4) {
      return null;
    } else {
      AssetCreationResponse data =
          await _plantService.getAssetCreationData(value);
      getassetCreationListData[index].model = data.result.modelName;
      notifyListeners();

      Logger().w(data);
    }
  }

  validate(int index) {
    if (getassetCreationListData[index].assetSerialNo.length < 9) {
      Logger().e("ff");
      _snackbarService.showSnackbar(
          message:
              "Request contains special character or character length is less than 8, Please recheck & retry!!!");
    }
  }
}
