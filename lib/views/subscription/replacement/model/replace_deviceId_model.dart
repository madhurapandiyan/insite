import 'package:json_annotation/json_annotation.dart';
part 'replace_deviceId_model.g.dart';

@JsonSerializable()
class ReplaceDeviceModel {
  final String code;
  final String status;
  final List<List<DeviceModel>> result;
  ReplaceDeviceModel({this.code, this.result, this.status});
  factory ReplaceDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$ReplaceDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplaceDeviceModelToJson(this);
}

@JsonSerializable()
class DeviceModel {
  final int count;
  final String GPSDeviceID;
  final String VIN;
  final String Model;
  final String SubscriptionStartDate;
  final String SubscriptionEndDate;
  final String NetworkProvider;
  DeviceModel(
      {this.GPSDeviceID,
      this.VIN,
      this.Model,
      this.SubscriptionStartDate,
      this.SubscriptionEndDate,
      this.count,
      this.NetworkProvider});
  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
