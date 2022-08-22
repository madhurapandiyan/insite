// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimatedResponse _$EstimatedResponseFromJson(Map<String, dynamic> json) =>
    EstimatedResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EstimatedResponseToJson(EstimatedResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      updateAssetTargetSettings: json['updateAssetTargetSettings'] == null
          ? null
          : UpdateAssetTargetSettings.fromJson(
              json['updateAssetTargetSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'updateAssetTargetSettings': instance.updateAssetTargetSettings,
    };

UpdateAssetTargetSettings _$UpdateAssetTargetSettingsFromJson(
        Map<String, dynamic> json) =>
    UpdateAssetTargetSettings(
      assetUIDs: (json['assetUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateAssetTargetSettingsToJson(
        UpdateAssetTargetSettings instance) =>
    <String, dynamic>{
      'assetUIDs': instance.assetUIDs,
    };
