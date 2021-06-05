// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idle_percent_trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdlePercentTrend _$IdlePercentTrendFromJson(Map<String, dynamic> json) {
  return IdlePercentTrend(
    cumulatives: json['cumulatives'] == null
        ? null
        : Cumulatives.fromJson(json['cumulatives'] as Map<String, dynamic>),
    intervals: (json['intervals'] as List)
        ?.map((e) =>
            e == null ? null : Interval.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$IdlePercentTrendToJson(IdlePercentTrend instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'intervals': instance.intervals,
      'pagination': instance.pagination,
      'code': instance.code,
      'message': instance.message,
    };

Cumulatives _$CumulativesFromJson(Map<String, dynamic> json) {
  return Cumulatives(
    cumulativeIdlePercent: (json['cumulativeIdlePercent'] as num)?.toDouble(),
    averageIdlePercent: (json['averageIdlePercent'] as num)?.toDouble(),
    description: json['description'] as String,
    startDateLocalTime: json['startDateLocalTime'] == null
        ? null
        : DateTime.parse(json['startDateLocalTime'] as String),
    endDateLocalTime: json['endDateLocalTime'] == null
        ? null
        : DateTime.parse(json['endDateLocalTime'] as String),
    totalAssetCount: json['totalAssetCount'] as int,
    totalDayCount: json['totalDayCount'] as int,
    intervalType: json['intervalType'] as String,
  );
}

Map<String, dynamic> _$CumulativesToJson(Cumulatives instance) =>
    <String, dynamic>{
      'cumulativeIdlePercent': instance.cumulativeIdlePercent,
      'averageIdlePercent': instance.averageIdlePercent,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
    };

Interval _$IntervalFromJson(Map<String, dynamic> json) {
  return Interval(
    idlePercentage: (json['idlePercentage'] as num)?.toDouble(),
    idleHours: (json['idleHours'] as num)?.toDouble(),
    description: json['description'] as String,
    intervalStartDateLocalTime: json['intervalStartDateLocalTime'] == null
        ? null
        : DateTime.parse(json['intervalStartDateLocalTime'] as String),
    intervalEndDateLocalTime: json['intervalEndDateLocalTime'] == null
        ? null
        : DateTime.parse(json['intervalEndDateLocalTime'] as String),
    totalAssetCount: json['totalAssetCount'] as int,
    dayCount: json['dayCount'] as int,
  );
}

Map<String, dynamic> _$IntervalToJson(Interval instance) => <String, dynamic>{
      'idlePercentage': instance.idlePercentage,
      'idleHours': instance.idleHours,
      'description': instance.description,
      'intervalStartDateLocalTime':
          instance.intervalStartDateLocalTime?.toIso8601String(),
      'intervalEndDateLocalTime':
          instance.intervalEndDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'dayCount': instance.dayCount,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };
