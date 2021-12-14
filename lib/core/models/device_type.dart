import 'package:json_annotation/json_annotation.dart';
part 'device_type.g.dart';

@JsonSerializable()
class DeviceType {
  final String id;
  final String name;
  final String assetCount;
  DeviceType({this.id, this.name, this.assetCount});
  factory DeviceType.fromJson(Map<String, dynamic> json) =>
      _$DeviceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTypeToJson(this);
}

@JsonSerializable()
class ListDeviceTypeResponse {
  final List<DeviceType> deviceTypes;
  ListDeviceTypeResponse({this.deviceTypes});
  factory ListDeviceTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListDeviceTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListDeviceTypeResponseToJson(this);
}
