import 'package:json_annotation/json_annotation.dart';
part 'device_search_model_response.g.dart';

@JsonSerializable()
class DeviceSearchModelResponse {
  final String? code;
  final String? status;
  final DeviceSearchResponce? result;

  DeviceSearchModelResponse({this.code, this.status, this.result});

  factory DeviceSearchModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceSearchModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSearchModelResponseToJson(this);
}

@JsonSerializable()
class DeviceSearchResponce {
  final int? AssetID;
  final String? GPSDeviceID;
  final String? VIN;
  final String? Model;
  final int? TankCapacity;
  final String? S_StartDate;
  final String? S_EndDate;

  DeviceSearchResponce(
      {this.AssetID,
      this.GPSDeviceID,
      this.VIN,
      this.Model,
      this.TankCapacity,
      this.S_StartDate,
      this.S_EndDate});
  factory DeviceSearchResponce.fromJson(Map<String, dynamic> json) =>
      _$DeviceSearchResponceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSearchResponceToJson(this);
}
