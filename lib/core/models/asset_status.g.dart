// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCount _$AssetCountFromJson(Map<String, dynamic> json) => AssetCount(
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetCountToJson(AssetCount instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

Count _$CountFromJson(Map<String, dynamic> json) => Count(
      countOf: json['countOf'] as String?,
      count: json['count'] as int?,
      assetCount: json['assetCount'] as int?,
      faultCount: json['faultCount'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
      'countOf': instance.countOf,
      'count': instance.count,
      'assetCount': instance.assetCount,
      'faultCount': instance.faultCount,
      'id': instance.id,
      'name': instance.name,
    };
