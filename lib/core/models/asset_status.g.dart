// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetStatus _$AssetStatusFromJson(Map<String, dynamic> json) {
  return AssetStatus(
    countData: (json['countData'] as List)
        ?.map((e) =>
            e == null ? null : CountDatum.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetStatusToJson(AssetStatus instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

CountDatum _$CountDatumFromJson(Map<String, dynamic> json) {
  return CountDatum(
    countOf: json['countOf'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$CountDatumToJson(CountDatum instance) =>
    <String, dynamic>{
      'countOf': instance.countOf,
      'count': instance.count,
    };
