// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_mileage_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetMileageSettingData _$AssetMileageSettingDataFromJson(
    Map<String, dynamic> json) {
  return AssetMileageSettingData(
    assetUIds: (json['assetUIds'] as List)?.map((e) => e as String)?.toList(),
    targetValue: (json['targetValue'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AssetMileageSettingDataToJson(
        AssetMileageSettingData instance) =>
    <String, dynamic>{
      'assetUIds': instance.assetUIds,
      'targetValue': instance.targetValue,
    };
