import 'package:insite/core/models/personalities.dart';
import 'package:json_annotation/json_annotation.dart';
part 'asset_device.g.dart';

@JsonSerializable()
class AssetDeviceResponse {
  final String? AssetUID;
  final List<AssetDevice>? Devices;
  AssetDeviceResponse({this.AssetUID, this.Devices});
  factory AssetDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDeviceResponseToJson(this);
}

@JsonSerializable()
class AssetDevice {
  final String? DeviceUID;
  final String? DeviceSerialNumber;
  final String? DeviceType;
  final String? DeviceState;
  final String? DeregisteredUTC;
  final String? ModuleType;
  final String? DataLinkType;
  final List<Personality>? Personalities;
  AssetDevice(
      {this.DeviceSerialNumber,
      this.DeviceState,
      this.DataLinkType,
      this.DeregisteredUTC,
      this.ModuleType,
      this.Personalities,
      this.DeviceUID,
      this.DeviceType});
  factory AssetDevice.fromJson(Map<String, dynamic> json) =>
      _$AssetDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDeviceToJson(this);
}
