// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelLevelData _$FuelLevelDataFromJson(Map<String, dynamic> json) {
  return FuelLevelData(
    countData: (json['countData'] as List)
        ?.map((e) =>
            e == null ? null : CountDatum.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FuelLevelDataToJson(FuelLevelData instance) =>
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
