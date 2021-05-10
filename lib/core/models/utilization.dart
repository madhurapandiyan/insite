import 'package:json_annotation/json_annotation.dart';

part 'utilization.g.dart';

@JsonSerializable()
class Utilization {
  Utilization({
    this.assetResults,
    this.totals,
    this.code,
    this.message,
  });

  List<AssetResult> assetResults;
  Map<String, double> totals;
  String code;
  String message;

  factory Utilization.fromJson(Map<String, dynamic> json) =>
      _$UtilizationFromJson(json);

  Map<String, dynamic> toJson() => _$UtilizationToJson(this);
}

@JsonSerializable()
class AssetResult {
  AssetResult({
    this.assetIdentifierSqluid,
    this.assetIcon,
    this.assetIdentifier,
    this.assetSerialNumber,
    this.date,
    this.distanceTravelledKilometers,
    this.idleEfficiency,
    this.idleFuelConsumedLiters,
    this.idleFuelConsumedLitersCalloutTypes,
    this.idleFuelConsumptionRate,
    this.idleHours,
    this.idleHoursCalloutTypes,
    this.kmsPerRuntimeFuelConsumedLiter,
    this.lastIdleFuelConsumptionLitersMeter,
    this.lastIdleHourMeter,
    this.lastOdometerMeter,
    this.lastReportedTime,
    this.lastReportedTimeZoneAbbrev,
    this.lastRuntimeFuelConsumptionLitersMeter,
    this.lastRuntimeHourMeter,
    this.makeCode,
    this.message,
    this.model,
    this.manufacturer,
    this.currentHourMeter,
    this.runtimeFuelConsumedLiters,
    this.runtimeFuelConsumedLitersCalloutTypes,
    this.runtimeFuelConsumptionRate,
    this.runtimeHours,
    this.runtimeHoursCalloutTypes,
    this.supportsIdle,
    this.targetIdle,
    this.targetIdlePerformance,
    this.targetRuntime,
    this.targetRuntimePerformance,
    this.workDefinitionType,
    this.workingEfficiency,
    this.workingFuelConsumedLiters,
    this.workingFuelConsumedLitersCalloutTypes,
    this.workingFuelConsumptionRate,
    this.workingHours,
    this.workingHoursCalloutTypes,
    this.idleFuelConsumptionRateCalloutTypes,
    this.workingFuelConsumptionRateCalloutTypes,
    this.idleEfficiencyCalloutTypes,
    this.workingEfficiencyCalloutTypes,
    this.targetIdlePerformanceCalloutTypes,
    this.idleHoursMeterCalloutTypes,
    this.runtimeHoursMeterCalloutTypes,
    this.idleFuelConsumptionLitersMeterCalloutTypes,
    this.runtimeFuelConsumptionLitersMeterCalloutTypes,
    this.lastReportedLocationLatitude,
    this.lastReportedLocationLongitude,
    this.lastReportedLocation,
    this.dieselExhaustFluidLiters,
    this.lastDieselExhaustFluidLitersMeter,
    this.dieselExhaustFluidLitersBurnedRate,
    this.dieselExhaustFluidLitersCalloutTypes,
  });

  String assetIdentifierSqluid;
  double assetIcon;
  String assetIdentifier;
  String assetSerialNumber;
  String date;
  double distanceTravelledKilometers;
  double idleEfficiency;
  dynamic idleFuelConsumedLiters;
  List<String> idleFuelConsumedLitersCalloutTypes;
  dynamic idleFuelConsumptionRate;
  double idleHours;
  List<String> idleHoursCalloutTypes;
  dynamic kmsPerRuntimeFuelConsumedLiter;
  dynamic lastIdleFuelConsumptionLitersMeter;
  double lastIdleHourMeter;
  double lastOdometerMeter;
  DateTime lastReportedTime;
  String lastReportedTimeZoneAbbrev;
  dynamic lastRuntimeFuelConsumptionLitersMeter;
  double lastRuntimeHourMeter;
  String makeCode;
  dynamic message;
  String model;
  String manufacturer;
  double currentHourMeter;
  dynamic runtimeFuelConsumedLiters;
  List<String> runtimeFuelConsumedLitersCalloutTypes;
  dynamic runtimeFuelConsumptionRate;
  double runtimeHours;
  List<String> runtimeHoursCalloutTypes;
  bool supportsIdle;
  double targetIdle;
  double targetIdlePerformance;
  double targetRuntime;
  double targetRuntimePerformance;
  String workDefinitionType;
  double workingEfficiency;
  dynamic workingFuelConsumedLiters;
  List<String> workingFuelConsumedLitersCalloutTypes;
  dynamic workingFuelConsumptionRate;
  double workingHours;
  List<String> workingHoursCalloutTypes;
  List<String> idleFuelConsumptionRateCalloutTypes;
  List<String> workingFuelConsumptionRateCalloutTypes;
  List<String> idleEfficiencyCalloutTypes;
  List<String> workingEfficiencyCalloutTypes;
  List<String> targetIdlePerformanceCalloutTypes;
  List<String> idleHoursMeterCalloutTypes;
  List<String> runtimeHoursMeterCalloutTypes;
  List<String> idleFuelConsumptionLitersMeterCalloutTypes;
  List<String> runtimeFuelConsumptionLitersMeterCalloutTypes;
  double lastReportedLocationLatitude;
  double lastReportedLocationLongitude;
  String lastReportedLocation;
  dynamic dieselExhaustFluidLiters;
  dynamic lastDieselExhaustFluidLitersMeter;
  dynamic dieselExhaustFluidLitersBurnedRate;
  List<String> dieselExhaustFluidLitersCalloutTypes;

  factory AssetResult.fromJson(Map<String, dynamic> json) =>
      _$AssetResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResultToJson(this);
}
