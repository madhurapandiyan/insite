// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceType _$DeviceTypeFromJson(Map<String, dynamic> json) => DeviceType(
      id: json['id'] as String?,
      name: json['name'] as String?,
      assetCount: (json['assetCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeviceTypeToJson(DeviceType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'assetCount': instance.assetCount,
    };

ListDeviceTypeResponse _$ListDeviceTypeResponseFromJson(
        Map<String, dynamic> json) =>
    ListDeviceTypeResponse(
      deviceTypes: (json['deviceTypes'] as List<dynamic>?)
          ?.map((e) => DeviceType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDeviceTypeResponseToJson(
        ListDeviceTypeResponse instance) =>
    <String, dynamic>{
      'deviceTypes': instance.deviceTypes,
    };

DeviceTypeRequest _$DeviceTypeRequestFromJson(Map<String, dynamic> json) =>
    DeviceTypeRequest(
      allAssets: json['allAssets'] as bool?,
      assetUID: (json['assetUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DeviceTypeRequestToJson(DeviceTypeRequest instance) =>
    <String, dynamic>{
      'allAssets': instance.allAssets,
      'assetUID': instance.assetUID,
    };
