// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimated_asset_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimatedAssetSetting _$EstimatedAssetSettingFromJson(
        Map<String, dynamic> json) =>
    EstimatedAssetSetting(
      assetTargetSettings: (json['assetTargetSettings'] as List<dynamic>?)
          ?.map((e) => AssetTargetSettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EstimatedAssetSettingToJson(
        EstimatedAssetSetting instance) =>
    <String, dynamic>{
      'assetTargetSettings': instance.assetTargetSettings,
    };

AssetTargetSettings _$AssetTargetSettingsFromJson(Map<String, dynamic> json) =>
    AssetTargetSettings(
      runtime: json['runtime'] == null
          ? null
          : Runtime.fromJson(json['runtime'] as Map<String, dynamic>),
      idle: json['idle'] == null
          ? null
          : Idle.fromJson(json['idle'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      assetUid: json['assetUid'] as String?,
    );

Map<String, dynamic> _$AssetTargetSettingsToJson(
        AssetTargetSettings instance) =>
    <String, dynamic>{
      'runtime': instance.runtime,
      'idle': instance.idle,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'assetUid': instance.assetUid,
    };

Runtime _$RuntimeFromJson(Map<String, dynamic> json) => Runtime(
      sunday: json['sunday'] as num?,
      monday: json['monday'] as num?,
      tuesday: json['tuesday'] as num?,
      wednesday: json['wednesday'] as num?,
      thursday: json['thursday'] as num?,
      friday: json['friday'] as num?,
      saturday: json['saturday'] as num?,
    );

Map<String, dynamic> _$RuntimeToJson(Runtime instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };

Idle _$IdleFromJson(Map<String, dynamic> json) => Idle(
      sunday: json['sunday'] as num?,
      monday: json['monday'] as num?,
      tuesday: json['tuesday'] as num?,
      wednesday: json['wednesday'] as num?,
      thursday: json['thursday'] as num?,
      friday: json['friday'] as num?,
      saturday: json['saturday'] as num?,
    );

Map<String, dynamic> _$IdleToJson(Idle instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };
