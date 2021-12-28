class AssetCreationModel {
  String? assetSerialNo;
  String? deviceId;
  String? model;
  String? hourMeter;
  String? status;
  String? message;
  bool isSelected;

  AssetCreationModel({
    this.assetSerialNo,
    this.deviceId,
    this.model,
    this.hourMeter,
    this.status,
    this.message,
    this.isSelected=false
  });
}

