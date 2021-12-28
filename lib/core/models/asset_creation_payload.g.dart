// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_creation_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCreationPayLoad _$AssetCreationPayLoadFromJson(
        Map<String, dynamic> json) =>
    AssetCreationPayLoad(
      Source: json['Source'] as String?,
      UserID: json['UserID'] as int?,
      asset: (json['asset'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetCreationPayLoadToJson(
        AssetCreationPayLoad instance) =>
    <String, dynamic>{
      'Source': instance.Source,
      'UserID': instance.UserID,
      'asset': instance.asset,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      machineSerialNumber: json['machineSerialNumber'] as String?,
      model: json['model'] as String?,
      deviceId: json['deviceId'] as String?,
      HMRValue: json['HMRValue'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'machineSerialNumber': instance.machineSerialNumber,
      'model': instance.model,
      'deviceId': instance.deviceId,
      'HMRValue': instance.HMRValue,
    };
