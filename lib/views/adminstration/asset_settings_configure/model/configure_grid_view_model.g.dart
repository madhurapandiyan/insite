// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configure_grid_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetListSettings _$AssetListSettingsFromJson(Map<String, dynamic> json) =>
    AssetListSettings(
      assetListSettings: (json['assetListSettings'] as List<dynamic>?)
          ?.map(
              (e) => AssetListSettingsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetListSettingsToJson(AssetListSettings instance) =>
    <String, dynamic>{
      'assetListSettings':
          instance.assetListSettings?.map((e) => e.toJson()).toList(),
    };

AssetListSettingsData _$AssetListSettingsDataFromJson(
        Map<String, dynamic> json) =>
    AssetListSettingsData(
      assetUID: json['assetUID'] as String?,
      assetName: json['assetName'] as String?,
      assetTypeName: json['assetTypeName'] as String?,
      equipmentVIN: json['equipmentVIN'] as String?,
      iconKey: json['iconKey'] as int?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      serialNumber: json['serialNumber'] as String?,
      statusInd: json['statusInd'] as bool?,
      legacyAssetID: json['legacyAssetID'] as int?,
      modelYear: json['modelYear'] as int?,
    );

Map<String, dynamic> _$AssetListSettingsDataToJson(
        AssetListSettingsData instance) =>
    <String, dynamic>{
      'assetUID': instance.assetUID,
      'assetName': instance.assetName,
      'assetTypeName': instance.assetTypeName,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'modelYear': instance.modelYear,
      'statusInd': instance.statusInd,
      'serialNumber': instance.serialNumber,
      'equipmentVIN': instance.equipmentVIN,
      'legacyAssetID': instance.legacyAssetID,
      'iconKey': instance.iconKey,
    };
