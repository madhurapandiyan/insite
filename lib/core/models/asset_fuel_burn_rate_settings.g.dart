// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_fuel_burn_rate_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSettings _$AddSettingsFromJson(Map<String, dynamic> json) => AddSettings(
      assetFuelBurnRateSettings:
          (json['assetFuelBurnRateSettings'] as List<dynamic>?)
              ?.map((e) =>
                  AssetFuelBurnRateSetting.fromJson(e as Map<String, dynamic>))
              .toList(),
      errors: json['errors'] as List<dynamic>?,
    );

Map<String, dynamic> _$AddSettingsToJson(AddSettings instance) =>
    <String, dynamic>{
      'assetFuelBurnRateSettings': instance.assetFuelBurnRateSettings,
      'errors': instance.errors,
    };

AssetFuelBurnRateSetting _$AssetFuelBurnRateSettingFromJson(
        Map<String, dynamic> json) =>
    AssetFuelBurnRateSetting(
      idleTargetValue: (json['idleTargetValue'] as num?)?.toDouble(),
      workTargetValue: (json['workTargetValue'] as num?)?.toDouble(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      assetUIds: (json['assetUIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AssetFuelBurnRateSettingToJson(
        AssetFuelBurnRateSetting instance) =>
    <String, dynamic>{
      'idleTargetValue': instance.idleTargetValue,
      'workTargetValue': instance.workTargetValue,
      'startDate': instance.startDate?.toIso8601String(),
      'assetUIds': instance.assetUIds,
    };
