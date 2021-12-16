// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilization_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilizationSummary _$UtilizationSummaryFromJson(Map<String, dynamic> json) =>
    UtilizationSummary(
      totalDay: json['totalDay'] == null
          ? null
          : AverageDay.fromJson(json['totalDay'] as Map<String, dynamic>),
      totalWeek: json['totalWeek'] == null
          ? null
          : AverageDay.fromJson(json['totalWeek'] as Map<String, dynamic>),
      totalMonth: json['totalMonth'] == null
          ? null
          : AverageDay.fromJson(json['totalMonth'] as Map<String, dynamic>),
      averageDay: json['averageDay'] == null
          ? null
          : AverageDay.fromJson(json['averageDay'] as Map<String, dynamic>),
      averageWeek: json['averageWeek'] == null
          ? null
          : AverageDay.fromJson(json['averageWeek'] as Map<String, dynamic>),
      averageMonth: json['averageMonth'] == null
          ? null
          : AverageDay.fromJson(json['averageMonth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UtilizationSummaryToJson(UtilizationSummary instance) =>
    <String, dynamic>{
      'totalDay': instance.totalDay,
      'totalWeek': instance.totalWeek,
      'totalMonth': instance.totalMonth,
      'averageDay': instance.averageDay,
      'averageWeek': instance.averageWeek,
      'averageMonth': instance.averageMonth,
    };

AverageDay _$AverageDayFromJson(Map<String, dynamic> json) => AverageDay(
      idleHours: (json['idleHours'] as num?)?.toDouble(),
      runtimeHours: (json['runtimeHours'] as num?)?.toDouble(),
      workingHours: (json['workingHours'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AverageDayToJson(AverageDay instance) =>
    <String, dynamic>{
      'idleHours': instance.idleHours,
      'runtimeHours': instance.runtimeHours,
      'workingHours': instance.workingHours,
    };
