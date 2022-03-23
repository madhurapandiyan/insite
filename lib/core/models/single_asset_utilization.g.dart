// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_asset_utilization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetUtilization _$SingleAssetUtilizationFromJson(
        Map<String, dynamic> json) =>
    SingleAssetUtilization(
      daily: (json['daily'] as List<dynamic>?)
          ?.map((e) => Range.fromJson(e as Map<String, dynamic>))
          .toList(),
      weekly: (json['weekly'] as List<dynamic>?)
          ?.map((e) => Range.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthly: (json['monthly'] as List<dynamic>?)
          ?.map((e) => Range.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SingleAssetUtilizationToJson(
        SingleAssetUtilization instance) =>
    <String, dynamic>{
      'daily': instance.daily,
      'weekly': instance.weekly,
      'monthly': instance.monthly,
      'code': instance.code,
      'message': instance.message,
    };

Range _$RangeFromJson(Map<String, dynamic> json) => Range(
      aggregateType: json['aggregateType'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RangeToJson(Range instance) => <String, dynamic>{
      'aggregateType': instance.aggregateType,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      capabilities: json['capabilities'],
      message: json['message'],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      idleHours: json['idleHours'],
      supportsIdle: json['supportsIdle'] as bool?,
      runtimeHours: (json['runtimeHours'] as num?)?.toDouble(),
      workDefinitionType: json['workDefinitionType'] as String?,
      workingHours: (json['workingHours'] as num?)?.toDouble(),
      distanceTravelledKilometers:
          (json['distanceTravelledKilometers'] as num?)?.toDouble(),
      idleEfficiency: (json['idleEfficiency'] as num?)?.toDouble(),
      workingEfficiency: (json['workingEfficiency'] as num?)?.toDouble(),
      idleEfficiencyCalloutTypes:
          (json['idleEfficiencyCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      workingEfficiencyCalloutTypes:
          (json['workingEfficiencyCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      targetIdlePerformanceCalloutTypes:
          (json['targetIdlePerformanceCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      targetIdlePerformance: json['targetIdlePerformance'],
      targetIdle: (json['targetIdle'] as num?)?.toDouble(),
      targetRuntime: (json['targetRuntime'] as num?)?.toDouble(),
      targetRuntimePerformance: json['targetRuntimePerformance'],
      runtimeHoursCalloutTypes:
          (json['runtimeHoursCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleHoursCalloutTypes: (json['idleHoursCalloutTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      workingHoursCalloutTypes:
          (json['workingHoursCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      lastRuntimeHourMeter: (json['lastRuntimeHourMeter'] as num?)?.toDouble(),
      lastOdometerMeter: (json['lastOdometerMeter'] as num?)?.toDouble(),
      lastIdleHourMeter: (json['lastIdleHourMeter'] as num?)?.toDouble(),
      lastRuntimeFuelConsumptionLitersMeter:
          json['lastRuntimeFuelConsumptionLitersMeter'],
      lastIdleFuelConsumptionLitersMeter:
          json['lastIdleFuelConsumptionLitersMeter'],
      runtimeFuelConsumedLiters: json['runtimeFuelConsumedLiters'],
      workingFuelConsumedLiters: json['workingFuelConsumedLiters'],
      idleFuelConsumedLiters: json['idleFuelConsumedLiters'],
      runtimeFuelConsumptionRate: json['runtimeFuelConsumptionRate'],
      workingFuelConsumptionRate: json['workingFuelConsumptionRate'],
      idleFuelConsumptionRate: json['idleFuelConsumptionRate'],
      idleFuelConsumptionRateCalloutTypes:
          (json['idleFuelConsumptionRateCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      workingFuelConsumptionRateCalloutTypes:
          (json['workingFuelConsumptionRateCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      kmsPerRuntimeFuelConsumedLiter: json['kmsPerRuntimeFuelConsumedLiter'],
      runtimeFuelConsumedLitersCalloutTypes:
          (json['runtimeFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleFuelConsumedLitersCalloutTypes:
          (json['idleFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      workingFuelConsumedLitersCalloutTypes:
          (json['workingFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      runtimeFuelConsumptionLitersMeterCalloutTypes:
          (json['runtimeFuelConsumptionLitersMeterCalloutTypes']
                  as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleFuelConsumptionLitersMeterCalloutTypes:
          (json['idleFuelConsumptionLitersMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      runtimeHoursMeterCalloutTypes:
          (json['runtimeHoursMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleHoursMeterCalloutTypes:
          (json['idleHoursMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      lastReportedTime: json['lastReportedTime'] == null
          ? null
          : DateTime.parse(json['lastReportedTime'] as String),
      lastReportedTimeZoneAbbrev: json['lastReportedTimeZoneAbbrev'] as String?,
      dailyreportedtimeTypes: (json['dailyreportedtimeTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      firstEngineStartTime: json['firstEngineStartTime'] == null
          ? null
          : DateTime.parse(json['firstEngineStartTime'] as String),
      lastEngineStopTime: json['lastEngineStopTime'] == null
          ? null
          : DateTime.parse(json['lastEngineStopTime'] as String),
      firstEngineStartTimeZoneAbbrev:
          json['firstEngineStartTimeZoneAbbrev'] as String?,
      lastEngineStopTimeZoneAbbrev:
          json['lastEngineStopTimeZoneAbbrev'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'capabilities': instance.capabilities,
      'message': instance.message,
      'date': instance.date?.toIso8601String(),
      'idleHours': instance.idleHours,
      'supportsIdle': instance.supportsIdle,
      'runtimeHours': instance.runtimeHours,
      'workDefinitionType': instance.workDefinitionType,
      'workingHours': instance.workingHours,
      'distanceTravelledKilometers': instance.distanceTravelledKilometers,
      'idleEfficiency': instance.idleEfficiency,
      'workingEfficiency': instance.workingEfficiency,
      'idleEfficiencyCalloutTypes': instance.idleEfficiencyCalloutTypes,
      'workingEfficiencyCalloutTypes': instance.workingEfficiencyCalloutTypes,
      'targetIdlePerformanceCalloutTypes':
          instance.targetIdlePerformanceCalloutTypes,
      'targetIdlePerformance': instance.targetIdlePerformance,
      'targetIdle': instance.targetIdle,
      'targetRuntime': instance.targetRuntime,
      'targetRuntimePerformance': instance.targetRuntimePerformance,
      'runtimeHoursCalloutTypes': instance.runtimeHoursCalloutTypes,
      'idleHoursCalloutTypes': instance.idleHoursCalloutTypes,
      'workingHoursCalloutTypes': instance.workingHoursCalloutTypes,
      'lastRuntimeHourMeter': instance.lastRuntimeHourMeter,
      'lastOdometerMeter': instance.lastOdometerMeter,
      'lastIdleHourMeter': instance.lastIdleHourMeter,
      'lastRuntimeFuelConsumptionLitersMeter':
          instance.lastRuntimeFuelConsumptionLitersMeter,
      'lastIdleFuelConsumptionLitersMeter':
          instance.lastIdleFuelConsumptionLitersMeter,
      'runtimeFuelConsumedLiters': instance.runtimeFuelConsumedLiters,
      'workingFuelConsumedLiters': instance.workingFuelConsumedLiters,
      'idleFuelConsumedLiters': instance.idleFuelConsumedLiters,
      'runtimeFuelConsumptionRate': instance.runtimeFuelConsumptionRate,
      'workingFuelConsumptionRate': instance.workingFuelConsumptionRate,
      'idleFuelConsumptionRate': instance.idleFuelConsumptionRate,
      'idleFuelConsumptionRateCalloutTypes':
          instance.idleFuelConsumptionRateCalloutTypes,
      'workingFuelConsumptionRateCalloutTypes':
          instance.workingFuelConsumptionRateCalloutTypes,
      'kmsPerRuntimeFuelConsumedLiter': instance.kmsPerRuntimeFuelConsumedLiter,
      'runtimeFuelConsumedLitersCalloutTypes':
          instance.runtimeFuelConsumedLitersCalloutTypes,
      'idleFuelConsumedLitersCalloutTypes':
          instance.idleFuelConsumedLitersCalloutTypes,
      'workingFuelConsumedLitersCalloutTypes':
          instance.workingFuelConsumedLitersCalloutTypes,
      'runtimeFuelConsumptionLitersMeterCalloutTypes':
          instance.runtimeFuelConsumptionLitersMeterCalloutTypes,
      'idleFuelConsumptionLitersMeterCalloutTypes':
          instance.idleFuelConsumptionLitersMeterCalloutTypes,
      'runtimeHoursMeterCalloutTypes': instance.runtimeHoursMeterCalloutTypes,
      'idleHoursMeterCalloutTypes': instance.idleHoursMeterCalloutTypes,
      'lastReportedTime': instance.lastReportedTime?.toIso8601String(),
      'lastReportedTimeZoneAbbrev': instance.lastReportedTimeZoneAbbrev,
      'dailyreportedtimeTypes': instance.dailyreportedtimeTypes,
      'firstEngineStartTime': instance.firstEngineStartTime?.toIso8601String(),
      'lastEngineStopTime': instance.lastEngineStopTime?.toIso8601String(),
      'firstEngineStartTimeZoneAbbrev': instance.firstEngineStartTimeZoneAbbrev,
      'lastEngineStopTimeZoneAbbrev': instance.lastEngineStopTimeZoneAbbrev,
    };
