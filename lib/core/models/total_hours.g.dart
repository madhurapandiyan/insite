// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalHours _$TotalHoursFromJson(Map<String, dynamic> json) {
  return TotalHours(
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

Map<String, dynamic> _$TotalHoursToJson(TotalHours instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'intervals': instance.intervals,
      'pagination': instance.pagination,
      'code': instance.code,
      'message': instance.message,
    };

Cumulatives _$CumulativesFromJson(Map<String, dynamic> json) {
  return Cumulatives(
    cumulativeHours: (json['cumulativeHours'] as num)?.toDouble(),
    averageHours: (json['averageHours'] as num)?.toDouble(),
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
      'cumulativeHours': instance.cumulativeHours,
      'averageHours': instance.averageHours,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
    };

Interval _$IntervalFromJson(Map<String, dynamic> json) {
  return Interval(
    totalHours: (json['totalHours'] as num)?.toDouble(),
    averageHours: (json['averageHours'] as num)?.toDouble(),
    totals: json['totals'] == null
        ? null
        : Totals.fromJson(json['totals'] as Map<String, dynamic>),
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
      'totalHours': instance.totalHours,
      'averageHours': instance.averageHours,
      'totals': instance.totals,
      'description': instance.description,
      'intervalStartDateLocalTime':
          instance.intervalStartDateLocalTime?.toIso8601String(),
      'intervalEndDateLocalTime':
          instance.intervalEndDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'dayCount': instance.dayCount,
    };

Totals _$TotalsFromJson(Map<String, dynamic> json) {
  return Totals(
    idleHours: (json['idleHours'] as num)?.toDouble(),
    workingHours: (json['workingHours'] as num)?.toDouble(),
    runtimeHours: (json['runtimeHours'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
      'idleHours': instance.idleHours,
      'workingHours': instance.workingHours,
      'runtimeHours': instance.runtimeHours,
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
