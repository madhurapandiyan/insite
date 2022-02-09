// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Utilization _$UtilizationFromJson(Map<String, dynamic> json) => Utilization(
      assetResults: (json['assetResults'] as List<dynamic>?)
          ?.map((e) => AssetResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: (json['totals'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UtilizationToJson(Utilization instance) =>
    <String, dynamic>{
      'assetResults': instance.assetResults,
      'totals': instance.totals,
      'code': instance.code,
      'message': instance.message,
    };

AssetResult _$AssetResultFromJson(Map<String, dynamic> json) => AssetResult(
      assetIdentifierSqluid: json['assetIdentifierSqluid'] as String?,
      assetIcon: (json['assetIcon'] as num?)?.toDouble(),
      assetIdentifier: json['assetIdentifier'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      date: json['date'] as String?,
      distanceTravelledKilometers:
          (json['distanceTravelledKilometers'] as num?)?.toDouble(),
      idleEfficiency: (json['idleEfficiency'] as num?)?.toDouble(),
      idleFuelConsumedLiters: json['idleFuelConsumedLiters'],
      idleFuelConsumedLitersCalloutTypes:
          (json['idleFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleFuelConsumptionRate: json['idleFuelConsumptionRate'],
      idleHours: (json['idleHours'] as num?)?.toDouble(),
      idleHoursCalloutTypes: (json['idleHoursCalloutTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      kmsPerRuntimeFuelConsumedLiter: json['kmsPerRuntimeFuelConsumedLiter'],
      lastIdleFuelConsumptionLitersMeter:
          json['lastIdleFuelConsumptionLitersMeter'],
      lastIdleHourMeter: (json['lastIdleHourMeter'] as num?)?.toDouble(),
      lastOdometerMeter: (json['lastOdometerMeter'] as num?)?.toDouble(),
      lastReportedTime: json['lastReportedTime'] as String?,
      lastReportedTimeZoneAbbrev: json['lastReportedTimeZoneAbbrev'] as String?,
      lastRuntimeFuelConsumptionLitersMeter:
          json['lastRuntimeFuelConsumptionLitersMeter'],
      lastRuntimeHourMeter: (json['lastRuntimeHourMeter'] as num?)?.toDouble(),
      makeCode: json['makeCode'] as String?,
      message: json['message'],
      model: json['model'] as String?,
      manufacturer: json['manufacturer'] as String?,
      currentHourMeter: (json['currentHourMeter'] as num?)?.toDouble(),
      runtimeFuelConsumedLiters:
          (json['runtimeFuelConsumedLiters'] as num?)?.toDouble(),
      runtimeFuelConsumedLitersCalloutTypes:
          (json['runtimeFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      runtimeFuelConsumptionRate:
          (json['runtimeFuelConsumptionRate'] as num?)?.toDouble(),
      runtimeHours: (json['runtimeHours'] as num?)?.toDouble(),
      runtimeHoursCalloutTypes:
          (json['runtimeHoursCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      supportsIdle: json['supportsIdle'] as bool?,
      targetIdle: (json['targetIdle'] as num?)?.toDouble(),
      targetIdlePerformance:
          (json['targetIdlePerformance'] as num?)?.toDouble(),
      targetRuntime: (json['targetRuntime'] as num?)?.toDouble(),
      targetRuntimePerformance:
          (json['targetRuntimePerformance'] as num?)?.toDouble(),
      workDefinitionType: json['workDefinitionType'] as String?,
      workingEfficiency: (json['workingEfficiency'] as num?)?.toDouble(),
      workingFuelConsumedLiters: json['workingFuelConsumedLiters'],
      workingFuelConsumedLitersCalloutTypes:
          (json['workingFuelConsumedLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      workingFuelConsumptionRate: json['workingFuelConsumptionRate'],
      workingHours: (json['workingHours'] as num?)?.toDouble(),
      workingHoursCalloutTypes:
          (json['workingHoursCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleFuelConsumptionRateCalloutTypes:
          (json['idleFuelConsumptionRateCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      workingFuelConsumptionRateCalloutTypes:
          (json['workingFuelConsumptionRateCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
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
      idleHoursMeterCalloutTypes:
          (json['idleHoursMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      runtimeHoursMeterCalloutTypes:
          (json['runtimeHoursMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      idleFuelConsumptionLitersMeterCalloutTypes:
          (json['idleFuelConsumptionLitersMeterCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      runtimeFuelConsumptionLitersMeterCalloutTypes:
          (json['runtimeFuelConsumptionLitersMeterCalloutTypes']
                  as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      lastReportedLocationLatitude:
          (json['lastReportedLocationLatitude'] as num?)?.toDouble(),
      lastReportedLocationLongitude:
          (json['lastReportedLocationLongitude'] as num?)?.toDouble(),
      lastReportedLocation: json['lastReportedLocation'] as String?,
      dieselExhaustFluidLiters: json['dieselExhaustFluidLiters'],
      lastDieselExhaustFluidLitersMeter:
          json['lastDieselExhaustFluidLitersMeter'],
      dieselExhaustFluidLitersBurnedRate:
          json['dieselExhaustFluidLitersBurnedRate'],
      dieselExhaustFluidLitersCalloutTypes:
          (json['dieselExhaustFluidLitersCalloutTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$AssetResultToJson(AssetResult instance) =>
    <String, dynamic>{
      'assetIdentifierSqluid': instance.assetIdentifierSqluid,
      'assetIcon': instance.assetIcon,
      'assetIdentifier': instance.assetIdentifier,
      'assetSerialNumber': instance.assetSerialNumber,
      'date': instance.date,
      'distanceTravelledKilometers': instance.distanceTravelledKilometers,
      'idleEfficiency': instance.idleEfficiency,
      'idleFuelConsumedLiters': instance.idleFuelConsumedLiters,
      'idleFuelConsumedLitersCalloutTypes':
          instance.idleFuelConsumedLitersCalloutTypes,
      'idleFuelConsumptionRate': instance.idleFuelConsumptionRate,
      'idleHours': instance.idleHours,
      'idleHoursCalloutTypes': instance.idleHoursCalloutTypes,
      'kmsPerRuntimeFuelConsumedLiter': instance.kmsPerRuntimeFuelConsumedLiter,
      'lastIdleFuelConsumptionLitersMeter':
          instance.lastIdleFuelConsumptionLitersMeter,
      'lastIdleHourMeter': instance.lastIdleHourMeter,
      'lastOdometerMeter': instance.lastOdometerMeter,
      'lastReportedTime': instance.lastReportedTime,
      'lastReportedTimeZoneAbbrev': instance.lastReportedTimeZoneAbbrev,
      'lastRuntimeFuelConsumptionLitersMeter':
          instance.lastRuntimeFuelConsumptionLitersMeter,
      'lastRuntimeHourMeter': instance.lastRuntimeHourMeter,
      'makeCode': instance.makeCode,
      'message': instance.message,
      'model': instance.model,
      'manufacturer': instance.manufacturer,
      'currentHourMeter': instance.currentHourMeter,
      'runtimeFuelConsumedLiters': instance.runtimeFuelConsumedLiters,
      'runtimeFuelConsumedLitersCalloutTypes':
          instance.runtimeFuelConsumedLitersCalloutTypes,
      'runtimeFuelConsumptionRate': instance.runtimeFuelConsumptionRate,
      'runtimeHours': instance.runtimeHours,
      'runtimeHoursCalloutTypes': instance.runtimeHoursCalloutTypes,
      'supportsIdle': instance.supportsIdle,
      'targetIdle': instance.targetIdle,
      'targetIdlePerformance': instance.targetIdlePerformance,
      'targetRuntime': instance.targetRuntime,
      'targetRuntimePerformance': instance.targetRuntimePerformance,
      'workDefinitionType': instance.workDefinitionType,
      'workingEfficiency': instance.workingEfficiency,
      'workingFuelConsumedLiters': instance.workingFuelConsumedLiters,
      'workingFuelConsumedLitersCalloutTypes':
          instance.workingFuelConsumedLitersCalloutTypes,
      'workingFuelConsumptionRate': instance.workingFuelConsumptionRate,
      'workingHours': instance.workingHours,
      'workingHoursCalloutTypes': instance.workingHoursCalloutTypes,
      'idleFuelConsumptionRateCalloutTypes':
          instance.idleFuelConsumptionRateCalloutTypes,
      'workingFuelConsumptionRateCalloutTypes':
          instance.workingFuelConsumptionRateCalloutTypes,
      'idleEfficiencyCalloutTypes': instance.idleEfficiencyCalloutTypes,
      'workingEfficiencyCalloutTypes': instance.workingEfficiencyCalloutTypes,
      'targetIdlePerformanceCalloutTypes':
          instance.targetIdlePerformanceCalloutTypes,
      'idleHoursMeterCalloutTypes': instance.idleHoursMeterCalloutTypes,
      'runtimeHoursMeterCalloutTypes': instance.runtimeHoursMeterCalloutTypes,
      'idleFuelConsumptionLitersMeterCalloutTypes':
          instance.idleFuelConsumptionLitersMeterCalloutTypes,
      'runtimeFuelConsumptionLitersMeterCalloutTypes':
          instance.runtimeFuelConsumptionLitersMeterCalloutTypes,
      'lastReportedLocationLatitude': instance.lastReportedLocationLatitude,
      'lastReportedLocationLongitude': instance.lastReportedLocationLongitude,
      'lastReportedLocation': instance.lastReportedLocation,
      'dieselExhaustFluidLiters': instance.dieselExhaustFluidLiters,
      'lastDieselExhaustFluidLitersMeter':
          instance.lastDieselExhaustFluidLitersMeter,
      'dieselExhaustFluidLitersBurnedRate':
          instance.dieselExhaustFluidLitersBurnedRate,
      'dieselExhaustFluidLitersCalloutTypes':
          instance.dieselExhaustFluidLitersCalloutTypes,
    };
