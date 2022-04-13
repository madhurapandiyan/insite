import 'package:json_annotation/json_annotation.dart';

part 'single_asset_utilization.g.dart';

@JsonSerializable()
class SingleAssetUtilization {
  SingleAssetUtilization({
    this.daily,
    this.weekly,
    this.monthly,
    this.code,
    this.message,
  });

  List<Range>? daily;
  List<Range>? weekly;
  List<Range>? monthly;
  dynamic code;
  String? message;

  factory SingleAssetUtilization.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetUtilizationFromJson(json);

  Map<String, dynamic> toJson() => _$SingleAssetUtilizationToJson(this);
}

@JsonSerializable()
class Range {
  Range({
    this.aggregateType,
    this.startDate,
    this.endDate,
    this.data,
  });

  String? aggregateType;
  DateTime? startDate;
  DateTime? endDate;
  Data? data;

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.capabilities,
    this.message,
    this.date,
    this.idleHours,
    this.supportsIdle,
    this.runtimeHours,
    this.workDefinitionType,
    this.workingHours,
    this.distanceTravelledKilometers,
    this.idleEfficiency,
    this.workingEfficiency,
    this.idleEfficiencyCalloutTypes,
    this.workingEfficiencyCalloutTypes,
    this.targetIdlePerformanceCalloutTypes,
    this.targetIdlePerformance,
    this.targetIdle,
    this.targetRuntime,
    this.targetRuntimePerformance,
    this.runtimeHoursCalloutTypes,
    this.idleHoursCalloutTypes,
    this.workingHoursCalloutTypes,
    this.lastRuntimeHourMeter,
    this.lastOdometerMeter,
    this.lastIdleHourMeter,
    this.lastRuntimeFuelConsumptionLitersMeter,
    this.lastIdleFuelConsumptionLitersMeter,
    this.runtimeFuelConsumedLiters,
    this.workingFuelConsumedLiters,
    this.idleFuelConsumedLiters,
    this.runtimeFuelConsumptionRate,
    this.workingFuelConsumptionRate,
    this.idleFuelConsumptionRate,
    this.idleFuelConsumptionRateCalloutTypes,
    this.workingFuelConsumptionRateCalloutTypes,
    this.kmsPerRuntimeFuelConsumedLiter,
    this.runtimeFuelConsumedLitersCalloutTypes,
    this.idleFuelConsumedLitersCalloutTypes,
    this.workingFuelConsumedLitersCalloutTypes,
    this.runtimeFuelConsumptionLitersMeterCalloutTypes,
    this.idleFuelConsumptionLitersMeterCalloutTypes,
    this.runtimeHoursMeterCalloutTypes,
    this.idleHoursMeterCalloutTypes,
    this.lastReportedTime,
    this.lastReportedTimeZoneAbbrev,
    this.dailyreportedtimeTypes,
    this.firstEngineStartTime,
    this.lastEngineStopTime,
    this.firstEngineStartTimeZoneAbbrev,
    this.lastEngineStopTimeZoneAbbrev,
  });

  dynamic capabilities;
  dynamic message;
  DateTime? date;
  dynamic idleHours;
  bool? supportsIdle;
  double? runtimeHours;
  String? workDefinitionType;
  double? workingHours;
  double? distanceTravelledKilometers;
  double? idleEfficiency;
  double? workingEfficiency;
  List<String>? idleEfficiencyCalloutTypes;
  List<String>? workingEfficiencyCalloutTypes;
  List<String>? targetIdlePerformanceCalloutTypes;
  dynamic targetIdlePerformance;
  double? targetIdle;
  double? targetRuntime;
  dynamic targetRuntimePerformance;
  List<String>? runtimeHoursCalloutTypes;
  List<String>? idleHoursCalloutTypes;
  List<String>? workingHoursCalloutTypes;
  double? lastRuntimeHourMeter;
  double? lastOdometerMeter;
  double? lastIdleHourMeter;
  dynamic lastRuntimeFuelConsumptionLitersMeter;
  dynamic lastIdleFuelConsumptionLitersMeter;
  dynamic runtimeFuelConsumedLiters;
  dynamic workingFuelConsumedLiters;
  dynamic idleFuelConsumedLiters;
  dynamic runtimeFuelConsumptionRate;
  dynamic workingFuelConsumptionRate;
  dynamic idleFuelConsumptionRate;
  List<String>? idleFuelConsumptionRateCalloutTypes;
  List<String>? workingFuelConsumptionRateCalloutTypes;
  dynamic kmsPerRuntimeFuelConsumedLiter;
  List<String>? runtimeFuelConsumedLitersCalloutTypes;
  List<String>? idleFuelConsumedLitersCalloutTypes;
  List<String>? workingFuelConsumedLitersCalloutTypes;
  List<String>? runtimeFuelConsumptionLitersMeterCalloutTypes;
  List<String>? idleFuelConsumptionLitersMeterCalloutTypes;
  List<String>? runtimeHoursMeterCalloutTypes;
  List<String>? idleHoursMeterCalloutTypes;
  DateTime? lastReportedTime;
  String? lastReportedTimeZoneAbbrev;
  List<String>? dailyreportedtimeTypes;
  DateTime? firstEngineStartTime;
  DateTime? lastEngineStopTime;
  String? firstEngineStartTimeZoneAbbrev;
  String? lastEngineStopTimeZoneAbbrev;

  // String? message;
  // String? date;
  // dynamic capabilities;
  // String? idleHours;
  // bool? supportsIdle;
  // double? workingHours;
  // double? runtimeHours;
  // String? workDefinitionType;
  // double? distanceTravelledKilometers;
  // double? idleEfficiency;
  // double? workingEfficiency;
  // List<String>? idleEfficiencyCalloutTypes;
  // List<String>? workingEfficiencyCalloutTypes;
  // List<String>? targetIdlePerformanceCalloutTypes;
  // String? targetIdlePerformance;
  // double? targetIdle;
  // double? targetRuntime;
  // String? targetRuntimePerformance;
  // List<String>? runtimeHoursCalloutTypes;
  // List<String>? idleHoursCalloutTypes;
  // List<String>? workingHoursCalloutTypes;
  // List<String>? runtimeFuelConsumptionLitersMeterCalloutTypes;
  // List<String>? idleFuelConsumptionLitersMeterCalloutTypes;
  // List<String>? runtimeHoursMeterCalloutTypes;
  // List<String>? idleHoursMeterCalloutTypes;
  // DateTime? firstEngineStartTime;
  // String? firstEngineStartTimeZoneAbbrev;
  // String? lastEngineStopTimeZoneAbbrev;
  // DateTime? lastEngineStopTime;
  // double? lastRuntimeHourMeter;
  // double? lastOdometerMeter;
  // double? lastIdleHourMeter;
  // double? lastRuntimeFuelConsumptionLitersMeter;
  // double? lastIdleFuelConsumptionLitersMeter;
  // double? runtimeFuelConsumedLiters;
  // double? workingFuelConsumedLiters;
  // double? idleFuelConsumedLiters;
  // double? runtimeFuelConsumptionRate;
  // double? workingFuelConsumptionRate;
  // double? idleFuelConsumptionRate;
  // List<String>? idleFuelConsumptionRateCalloutTypes;
  // List<String>? workingFuelConsumptionRateCalloutTypes;
  // String? kmsPerRuntimeFuelConsumedLiter;
  // List<String>? runtimeFuelConsumedLitersCalloutTypes;
  // List<String>? idleFuelConsumedLitersCalloutTypes;
  // List<String>? workingFuelConsumedLitersCalloutTypes;
  // DateTime? lastReportedTime;
  // String? lastReportedTimeZoneAbbrev;
  // List<String>? dailyreportedtimeTypes;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
