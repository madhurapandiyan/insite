// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDeviceResponse _$AssetDeviceResponseFromJson(Map<String, dynamic> json) {
  return AssetDeviceResponse(
    AssetUID: json['AssetUID'] as String,
    Devices: (json['Devices'] as List)
        ?.map((e) =>
            e == null ? null : AssetDevice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetDeviceResponseToJson(
        AssetDeviceResponse instance) =>
    <String, dynamic>{
      'AssetUID': instance.AssetUID,
      'Devices': instance.Devices,
    };

AssetDevice _$AssetDeviceFromJson(Map<String, dynamic> json) {
  return AssetDevice(
    DeviceSerialNumber: json['DeviceSerialNumber'] as String,
    DeviceState: json['DeviceState'] as String,
    DataLinkType: json['DataLinkType'] as String,
    DeregisteredUTC: json['DeregisteredUTC'] as String,
    ModuleType: json['ModuleType'] as String,
    Personalities: (json['Personalities'] as List)
        ?.map((e) =>
            e == null ? null : Personality.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    DeviceUID: json['DeviceUID'] as String,
    DeviceType: json['DeviceType'] as String,
  );
}

Map<String, dynamic> _$AssetDeviceToJson(AssetDevice instance) =>
    <String, dynamic>{
      'DeviceUID': instance.DeviceUID,
      'DeviceSerialNumber': instance.DeviceSerialNumber,
      'DeviceType': instance.DeviceType,
      'DeviceState': instance.DeviceState,
      'DeregisteredUTC': instance.DeregisteredUTC,
      'ModuleType': instance.ModuleType,
      'DataLinkType': instance.DataLinkType,
      'Personalities': instance.Personalities,
    };
