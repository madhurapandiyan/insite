// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_mileage_settings_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetMileageSettingsListData _$AssetMileageSettingsListDataFromJson(
        Map<String, dynamic> json) =>
    AssetMileageSettingsListData(
      assetMileageSettings: (json['assetMileageSettings'] as List<dynamic>?)
          ?.map((e) => AssetMileageSettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetMileageSettingsListDataToJson(
        AssetMileageSettingsListData instance) =>
    <String, dynamic>{
      'assetMileageSettings': instance.assetMileageSettings,
    };

AssetMileageSettings _$AssetMileageSettingsFromJson(
        Map<String, dynamic> json) =>
    AssetMileageSettings(
      targetValue: (json['targetValue'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      assetUid: json['assetUid'] as String?,
    );

Map<String, dynamic> _$AssetMileageSettingsToJson(
        AssetMileageSettings instance) =>
    <String, dynamic>{
      'targetValue': instance.targetValue,
      'startDate': instance.startDate,
      'assetUid': instance.assetUid,
    };
