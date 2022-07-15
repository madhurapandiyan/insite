import 'package:json_annotation/json_annotation.dart';
part 'asset_creation_reset_data.g.dart';

@JsonSerializable()
class AssetCreationResetData {
  String? code;
  String? status;
  List<Result>? result;
  List<CreateAsset>? createAsset;

  AssetCreationResetData(
      {this.code, this.status, this.result, this.createAsset});

  factory AssetCreationResetData.fromJson(Map<String, dynamic> json) =>
      _$AssetCreationResetDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetCreationResetDataToJson(this);
}

@JsonSerializable()
class Result {
  int? code;
  String? status;
  String? GPSDeviceID;
  String? VIN;
  String? vin;
  String? message;
  String? Model;
  double? HMRValue;
  String? AssetCreationDate;

  Result(
      {this.code,
      this.status,
      this.GPSDeviceID,
      this.VIN,
      this.vin,
      this.message,
      this.Model,
      this.HMRValue,
      this.AssetCreationDate});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class CreateAsset {
  final String? code;
  final String? status;
  final String? message;
  final String? gpsDeviceId;
  final String? vin;

  CreateAsset(
      {this.code, this.status, this.message, this.gpsDeviceId, this.vin});

  factory CreateAsset.fromJson(Map<String, dynamic> json) =>
      _$CreateAssetFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAssetToJson(this);
}
