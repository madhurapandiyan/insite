// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_burn_rate_trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelBurnRateTrend _$FuelBurnRateTrendFromJson(Map<String, dynamic> json) {
  return FuelBurnRateTrend(
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

Map<String, dynamic> _$FuelBurnRateTrendToJson(FuelBurnRateTrend instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'intervals': instance.intervals,
      'pagination': instance.pagination,
      'code': instance.code,
      'message': instance.message,
    };

Cumulatives _$CumulativesFromJson(Map<String, dynamic> json) {
  return Cumulatives(
    cumulativeFuelBurnRate: json['cumulativeFuelBurnRate'],
    averageFuelBurnRate: json['averageFuelBurnRate'],
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
      'cumulativeFuelBurnRate': instance.cumulativeFuelBurnRate,
      'averageFuelBurnRate': instance.averageFuelBurnRate,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
    };

Interval _$IntervalFromJson(Map<String, dynamic> json) {
  return Interval(
    burnrates: json['burnrates'] == null
        ? null
        : Burnrates.fromJson(json['burnrates'] as Map<String, dynamic>),
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
      'burnrates': instance.burnrates,
      'description': instance.description,
      'intervalStartDateLocalTime':
          instance.intervalStartDateLocalTime?.toIso8601String(),
      'intervalEndDateLocalTime':
          instance.intervalEndDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'dayCount': instance.dayCount,
    };

Burnrates _$BurnratesFromJson(Map<String, dynamic> json) {
  return Burnrates(
    runtimeFuelBurnRate: json['runtimeFuelBurnRate'] as int,
    idleFuelBurnRate: (json['idleFuelBurnRate'] as num)?.toDouble(),
    workingFuelBurnRate: (json['workingFuelBurnRate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BurnratesToJson(Burnrates instance) => <String, dynamic>{
      'runtimeFuelBurnRate': instance.runtimeFuelBurnRate,
      'idleFuelBurnRate': instance.idleFuelBurnRate,
      'workingFuelBurnRate': instance.workingFuelBurnRate,
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
