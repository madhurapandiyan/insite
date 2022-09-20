// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_location_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetLocationSearch _$AssetLocationSearchFromJson(Map<String, dynamic> json) =>
    AssetLocationSearch(
      assetLocation: json['assetLocation'] == null
          ? null
          : AssetLocationData.fromJson(
              json['assetLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetLocationSearchToJson(
        AssetLocationSearch instance) =>
    <String, dynamic>{
      'assetLocation': instance.assetLocation,
    };
