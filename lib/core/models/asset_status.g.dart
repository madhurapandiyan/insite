// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCountData _$AssetCountDataFromJson(Map<String, dynamic> json) {
  return AssetCountData(
    countData: (json['countData'] as List)
        ?.map((e) =>
            e == null ? null : CountData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetCountDataToJson(AssetCountData instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

CountData _$CountDataFromJson(Map<String, dynamic> json) {
  return CountData(
    countOf: json['countOf'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$CountDataToJson(CountData instance) => <String, dynamic>{
      'countOf': instance.countOf,
      'count': instance.count,
    };
