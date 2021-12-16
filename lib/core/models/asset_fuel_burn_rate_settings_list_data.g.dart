// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_fuel_burn_rate_settings_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetFuelBurnRateSettingsListData _$AssetFuelBurnRateSettingsListDataFromJson(
        Map<String, dynamic> json) =>
    AssetFuelBurnRateSettingsListData(
      assetFuelBurnRateSettings:
          (json['assetFuelBurnRateSettings'] as List<dynamic>?)
              ?.map((e) =>
                  AssetFuelBurnRateSettings.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AssetFuelBurnRateSettingsListDataToJson(
        AssetFuelBurnRateSettingsListData instance) =>
    <String, dynamic>{
      'assetFuelBurnRateSettings': instance.assetFuelBurnRateSettings,
    };

AssetFuelBurnRateSettings _$AssetFuelBurnRateSettingsFromJson(
        Map<String, dynamic> json) =>
    AssetFuelBurnRateSettings(
      idleTargetValue: (json['idleTargetValue'] as num?)?.toDouble(),
      workTargetValue: (json['workTargetValue'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      assetUid: json['assetUid'] as String?,
    );

Map<String, dynamic> _$AssetFuelBurnRateSettingsToJson(
        AssetFuelBurnRateSettings instance) =>
    <String, dynamic>{
      'idleTargetValue': instance.idleTargetValue,
      'workTargetValue': instance.workTargetValue,
      'startDate': instance.startDate,
      'assetUid': instance.assetUid,
    };
