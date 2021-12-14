// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceType _$DeviceTypeFromJson(Map<String, dynamic> json) {
  return DeviceType(
    id: json['id'] as String,
    name: json['name'] as String,
    assetCount: json['assetCount'] as String,
  );
}

Map<String, dynamic> _$DeviceTypeToJson(DeviceType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'assetCount': instance.assetCount,
    };

ListDeviceTypeResponse _$ListDeviceTypeResponseFromJson(
    Map<String, dynamic> json) {
  return ListDeviceTypeResponse(
    deviceTypes: (json['deviceTypes'] as List)
        ?.map((e) =>
            e == null ? null : DeviceType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListDeviceTypeResponseToJson(
        ListDeviceTypeResponse instance) =>
    <String, dynamic>{
      'deviceTypes': instance.deviceTypes,
    };
