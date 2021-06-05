// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_fuel_burned.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalFuelBurned _$TotalFuelBurnedFromJson(Map<String, dynamic> json) {
  return TotalFuelBurned(
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

Map<String, dynamic> _$TotalFuelBurnedToJson(TotalFuelBurned instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'intervals': instance.intervals,
      'pagination': instance.pagination,
      'code': instance.code,
      'message': instance.message,
    };

Cumulatives _$CumulativesFromJson(Map<String, dynamic> json) {
  return Cumulatives(
    cumulativeFuelBurned: (json['cumulativeFuelBurned'] as num)?.toDouble(),
    averageFuelBurned: (json['averageFuelBurned'] as num)?.toDouble(),
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
      'cumulativeFuelBurned': instance.cumulativeFuelBurned,
      'averageFuelBurned': instance.averageFuelBurned,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
    };

Interval _$IntervalFromJson(Map<String, dynamic> json) {
  return Interval(
    totalFuelBurned: (json['totalFuelBurned'] as num)?.toDouble(),
    averageFuelBurned: (json['averageFuelBurned'] as num)?.toDouble(),
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
      'totalFuelBurned': instance.totalFuelBurned,
      'averageFuelBurned': instance.averageFuelBurned,
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
    idleFuelBurned: (json['idleFuelBurned'] as num)?.toDouble(),
    workingFuelBurned: (json['workingFuelBurned'] as num)?.toDouble(),
    runtimeFuelBurned: (json['runtimeFuelBurned'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
      'idleFuelBurned': instance.idleFuelBurned,
      'workingFuelBurned': instance.workingFuelBurned,
      'runtimeFuelBurned': instance.runtimeFuelBurned,
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
