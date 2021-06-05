// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cumulative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunTimeCumulative _$RunTimeCumulativeFromJson(Map<String, dynamic> json) {
  return RunTimeCumulative(
    cumulatives: json['cumulatives'] == null
        ? null
        : Cumulatives.fromJson(json['cumulatives'] as Map<String, dynamic>),
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$RunTimeCumulativeToJson(RunTimeCumulative instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'code': instance.code,
      'message': instance.message,
    };

Cumulatives _$CumulativesFromJson(Map<String, dynamic> json) {
  return Cumulatives(
    cumulativeHours: (json['cumulativeHours'] as num)?.toDouble(),
    averageHours: (json['averageHours'] as num)?.toDouble(),
    totals: json['totals'] == null
        ? null
        : Totals.fromJson(json['totals'] as Map<String, dynamic>),
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
      'totals': instance.totals,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
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

FuelBurnedCumulative _$FuelBurnedCumulativeFromJson(Map<String, dynamic> json) {
  return FuelBurnedCumulative(
    cumulatives: json['cumulatives'] == null
        ? null
        : FuelBurnedCumulatives.fromJson(
            json['cumulatives'] as Map<String, dynamic>),
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$FuelBurnedCumulativeToJson(
        FuelBurnedCumulative instance) =>
    <String, dynamic>{
      'cumulatives': instance.cumulatives,
      'code': instance.code,
      'message': instance.message,
    };

FuelBurnedCumulatives _$FuelBurnedCumulativesFromJson(
    Map<String, dynamic> json) {
  return FuelBurnedCumulatives(
    totalFuelBurned: (json['totalFuelBurned'] as num)?.toDouble(),
    averageFuelBurned: (json['averageFuelBurned'] as num)?.toDouble(),
    totals: json['totals'] == null
        ? null
        : FuelBurnedTotals.fromJson(json['totals'] as Map<String, dynamic>),
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

Map<String, dynamic> _$FuelBurnedCumulativesToJson(
        FuelBurnedCumulatives instance) =>
    <String, dynamic>{
      'totalFuelBurned': instance.totalFuelBurned,
      'averageFuelBurned': instance.averageFuelBurned,
      'totals': instance.totals,
      'description': instance.description,
      'startDateLocalTime': instance.startDateLocalTime?.toIso8601String(),
      'endDateLocalTime': instance.endDateLocalTime?.toIso8601String(),
      'totalAssetCount': instance.totalAssetCount,
      'totalDayCount': instance.totalDayCount,
      'intervalType': instance.intervalType,
    };

FuelBurnedTotals _$FuelBurnedTotalsFromJson(Map<String, dynamic> json) {
  return FuelBurnedTotals(
    idleFuelBurned: json['idleFuelBurned'] as double,
    workingFuelBurned: json['workingFuelBurned'] as double,
    runtimeFuelBurned: (json['runtimeFuelBurned'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FuelBurnedTotalsToJson(FuelBurnedTotals instance) =>
    <String, dynamic>{
      'idleFuelBurned': instance.idleFuelBurned,
      'workingFuelBurned': instance.workingFuelBurned,
      'runtimeFuelBurned': instance.runtimeFuelBurned,
    };
