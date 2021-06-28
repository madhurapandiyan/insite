// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCount _$AssetCountFromJson(Map<String, dynamic> json) {
  return AssetCount(
    countData: (json['countData'] as List)
        ?.map(
            (e) => e == null ? null : Count.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetCountToJson(AssetCount instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

Count _$CountFromJson(Map<String, dynamic> json) {
  return Count(
    countOf: json['countOf'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
      'countOf': instance.countOf,
      'count': instance.count,
    };
