// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_utilization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetUtilization _$AssetUtilizationFromJson(Map<String, dynamic> json) {
  return AssetUtilization(
    totalDay: json['totalDay'] == null
        ? null
        : Hours.fromJson(json['totalDay'] as Map<String, dynamic>),
    totalWeek: json['totalWeek'] == null
        ? null
        : Hours.fromJson(json['totalWeek'] as Map<String, dynamic>),
    totalMonth: json['totalMonth'] == null
        ? null
        : Hours.fromJson(json['totalMonth'] as Map<String, dynamic>),
    targetDay: json['targetDay'] == null
        ? null
        : Hours.fromJson(json['targetDay'] as Map<String, dynamic>),
    targetWeek: json['targetWeek'] == null
        ? null
        : Hours.fromJson(json['targetWeek'] as Map<String, dynamic>),
    targetMonth: json['targetMonth'] == null
        ? null
        : Hours.fromJson(json['targetMonth'] as Map<String, dynamic>),
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AssetUtilizationToJson(AssetUtilization instance) =>
    <String, dynamic>{
      'totalDay': instance.totalDay,
      'totalWeek': instance.totalWeek,
      'totalMonth': instance.totalMonth,
      'targetDay': instance.targetDay,
      'targetWeek': instance.targetWeek,
      'targetMonth': instance.targetMonth,
      'code': instance.code,
      'message': instance.message,
    };

Hours _$HoursFromJson(Map<String, dynamic> json) {
  return Hours(
    idleHours: (json['idleHours'] as num)?.toDouble(),
    runtimeHours: (json['runtimeHours'] as num)?.toDouble(),
    workingHours: (json['workingHours'] as num)?.toDouble(),
    idleFuel: (json['idleFuel'] as num)?.toDouble(),
    runtimeFuel: (json['runtimeFuel'] as num)?.toDouble(),
    workingFuel: (json['workingFuel'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HoursToJson(Hours instance) => <String, dynamic>{
      'idleHours': instance.idleHours,
      'runtimeHours': instance.runtimeHours,
      'workingHours': instance.workingHours,
      'idleFuel': instance.idleFuel,
      'runtimeFuel': instance.runtimeFuel,
      'workingFuel': instance.workingFuel,
    };
