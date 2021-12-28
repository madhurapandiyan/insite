// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_icon_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetIconPayLoad _$AssetIconPayLoadFromJson(Map<String, dynamic> json) =>
    AssetIconPayLoad(
      assetUID: json['assetUID'] as String?,
      legacyAssetID: json['legacyAssetID'] as int?,
      iconKey: json['iconKey'] as int?,
      modelYear: json['modelYear'] as int?,
      actionUTC: json['actionUTC'] as String?,
    );

Map<String, dynamic> _$AssetIconPayLoadToJson(AssetIconPayLoad instance) =>
    <String, dynamic>{
      'assetUID': instance.assetUID,
      'legacyAssetID': instance.legacyAssetID,
      'iconKey': instance.iconKey,
      'modelYear': instance.modelYear,
      'actionUTC': instance.actionUTC,
    };
