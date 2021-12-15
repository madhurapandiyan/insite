import 'package:json_annotation/json_annotation.dart';
part 'asset_creation_payload.g.dart';

@JsonSerializable()
class AssetCreationPayLoad {
  String Source;
  int UserID;
  List<Asset> asset;

  AssetCreationPayLoad({this.Source, this.UserID, this.asset});

  factory AssetCreationPayLoad.fromJson(Map<String, dynamic> json) =>
      _$AssetCreationPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$AssetCreationPayLoadToJson(this);
}

@JsonSerializable()
class Asset {
  String machineSerialNumber;
  String model;
  String deviceId;
  String HMRValue;

  Asset({this.machineSerialNumber, this.model, this.deviceId, this.HMRValue});

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
