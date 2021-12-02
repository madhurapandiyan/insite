import 'package:flutter/cupertino.dart';

class AssetCreationModel {
  String assetSerialNo;
  String deviceId;
  TextEditingController model;
  String hourMeter;
  String status;
  String message;

  AssetCreationModel({
    this.assetSerialNo,
    this.deviceId,
    this.model,
    this.hourMeter,
    this.status,
    this.message,
  });
}
