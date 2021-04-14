// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_utilization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetUtilization _$AssetUtilizationFromJson(Map<String, dynamic> json) {
  return AssetUtilization(
    json['totalDay'] == null
        ? null
        : Hours.fromJson(json['totalDay'] as Map<String, dynamic>),
    json['totalWeek'] == null
        ? null
        : Hours.fromJson(json['totalWeek'] as Map<String, dynamic>),
    json['totalMonth'] == null
        ? null
        : Hours.fromJson(json['totalMonth'] as Map<String, dynamic>),
    json['averageWeek'] == null
        ? null
        : Hours.fromJson(json['averageWeek'] as Map<String, dynamic>),
    json['averageMonth'] == null
        ? null
        : Hours.fromJson(json['averageMonth'] as Map<String, dynamic>),
    json['averageDay'] == null
        ? null
        : Hours.fromJson(json['averageDay'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AssetUtilizationToJson(AssetUtilization instance) =>
    <String, dynamic>{
      'totalDay': instance.totalDay,
      'totalWeek': instance.totalWeek,
      'totalMonth': instance.totalMonth,
      'averageDay': instance.averageDay,
      'averageWeek': instance.averageWeek,
      'averageMonth': instance.averageMonth,
    };

Hours _$HoursFromJson(Map<String, dynamic> json) {
  return Hours(
    (json['idleHours'] as num)?.toDouble(),
    (json['runtimeHours'] as num)?.toDouble(),
    (json['workingHours'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HoursToJson(Hours instance) => <String, dynamic>{
      'idleHours': instance.idleHours,
      'runtimeHours': instance.runtimeHours,
      'workingHours': instance.workingHours,
    };
