// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_asset_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetOperation _$SingleAssetOperationFromJson(Map<String, dynamic> json) {
  return SingleAssetOperation(
    assetOperations: json['assetOperations'] == null
        ? null
        : AssetOperations.fromJson(
            json['assetOperations'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SingleAssetOperationToJson(
        SingleAssetOperation instance) =>
    <String, dynamic>{
      'assetOperations': instance.assetOperations,
    };

AssetOperations _$AssetOperationsFromJson(Map<String, dynamic> json) {
  return AssetOperations(
    pagination: json['pagination'],
    links: (json['links'] as List)
        ?.map(
            (e) => e == null ? null : Link.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assets: (json['assets'] as List)
        ?.map(
            (e) => e == null ? null : Asset.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetOperationsToJson(AssetOperations instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'links': instance.links,
      'assets': instance.assets,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset(
    assetUid: json['assetUid'] as String,
    assetId: json['assetId'],
    makeCode: json['makeCode'] as String,
    model: json['model'] as String,
    serialNumber: json['serialNumber'] as String,
    assetIcon: json['assetIcon'] == null
        ? null
        : AssetIcon.fromJson(json['assetIcon'] as Map<String, dynamic>),
    productFamily: json['productFamily'] as String,
    customStateDescription: json['customStateDescription'] as String,
    distanceTravelledKilometers:
        (json['distanceTravelledKilometers'] as num)?.toDouble(),
    dateRangeRuntimeDuration: json['dateRangeRuntimeDuration'] as double,
    lastKnownOperator: json['lastKnownOperator'],
    capabilities: json['capabilities'] == null
        ? null
        : Capabilities.fromJson(json['capabilities'] as Map<String, dynamic>),
    assetLocalDates: (json['assetLocalDates'] as List)
        ?.map((e) => e == null
            ? null
            : AssetLocalDate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assetLastReceivedEvent: json['assetLastReceivedEvent'] == null
        ? null
        : AssetLastReceivedEvent.fromJson(
            json['assetLastReceivedEvent'] as Map<String, dynamic>),
    firstEngineStartEvent: json['firstEngineStartEvent'],
    lastEngineStopEvent: json['lastEngineStopEvent'],
  );
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'assetUid': instance.assetUid,
      'assetId': instance.assetId,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'serialNumber': instance.serialNumber,
      'assetIcon': instance.assetIcon,
      'productFamily': instance.productFamily,
      'customStateDescription': instance.customStateDescription,
      'distanceTravelledKilometers': instance.distanceTravelledKilometers,
      'dateRangeRuntimeDuration': instance.dateRangeRuntimeDuration,
      'lastKnownOperator': instance.lastKnownOperator,
      'capabilities': instance.capabilities,
      'assetLocalDates': instance.assetLocalDates,
      'assetLastReceivedEvent': instance.assetLastReceivedEvent,
      'firstEngineStartEvent': instance.firstEngineStartEvent,
      'lastEngineStopEvent': instance.lastEngineStopEvent,
    };

AssetIcon _$AssetIconFromJson(Map<String, dynamic> json) {
  return AssetIcon(
    key: json['key'] as int,
  );
}

Map<String, dynamic> _$AssetIconToJson(AssetIcon instance) => <String, dynamic>{
      'key': instance.key,
    };

AssetLastReceivedEvent _$AssetLastReceivedEventFromJson(
    Map<String, dynamic> json) {
  return AssetLastReceivedEvent(
    lastReceivedEvent: json['lastReceivedEvent'] as String,
    lastReceivedEventTimeLocal: json['lastReceivedEventTimeLocal'] == null
        ? null
        : DateTime.parse(json['lastReceivedEventTimeLocal'] as String),
    lastReceivedEventUtc: json['lastReceivedEventUtc'] == null
        ? null
        : DateTime.parse(json['lastReceivedEventUtc'] as String),
    timezoneAbbrev: json['timezoneAbbrev'] as String,
    isPairedEvent: json['isPairedEvent'] as bool,
    segmentType: json['segmentType'] as String,
  );
}

Map<String, dynamic> _$AssetLastReceivedEventToJson(
        AssetLastReceivedEvent instance) =>
    <String, dynamic>{
      'lastReceivedEvent': instance.lastReceivedEvent,
      'lastReceivedEventTimeLocal':
          instance.lastReceivedEventTimeLocal?.toIso8601String(),
      'lastReceivedEventUtc': instance.lastReceivedEventUtc?.toIso8601String(),
      'timezoneAbbrev': instance.timezoneAbbrev,
      'isPairedEvent': instance.isPairedEvent,
      'segmentType': instance.segmentType,
    };

AssetLocalDate _$AssetLocalDateFromJson(Map<String, dynamic> json) {
  return AssetLocalDate(
    assetLocalDate: json['assetLocalDate'] == null
        ? null
        : DateTime.parse(json['assetLocalDate'] as String),
    totalRuntimeDurationSeconds: json['totalRuntimeDurationSeconds'] as int,
    totalRuntimeKeyDateDurationSeconds:
        json['totalRuntimeKeyDateDurationSeconds'] as int,
    segments: (json['segments'] as List)
        ?.map((e) =>
            e == null ? null : Segment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetLocalDateToJson(AssetLocalDate instance) =>
    <String, dynamic>{
      'assetLocalDate': instance.assetLocalDate?.toIso8601String(),
      'totalRuntimeDurationSeconds': instance.totalRuntimeDurationSeconds,
      'totalRuntimeKeyDateDurationSeconds':
          instance.totalRuntimeKeyDateDurationSeconds,
      'segments': instance.segments,
    };

Segment _$SegmentFromJson(Map<String, dynamic> json) {
  return Segment(
    startTimeUtc: json['startTimeUtc'] == null
        ? null
        : DateTime.parse(json['startTimeUtc'] as String),
    endTimeUtc: json['endTimeUtc'] == null
        ? null
        : DateTime.parse(json['endTimeUtc'] as String),
    startTimeLocal: json['startTimeLocal'] == null
        ? null
        : DateTime.parse(json['startTimeLocal'] as String),
    endTimeLocal: json['endTimeLocal'] == null
        ? null
        : DateTime.parse(json['endTimeLocal'] as String),
    startLocationLatitude: (json['startLocationLatitude'] as num)?.toDouble(),
    startLocationLongitude: (json['startLocationLongitude'] as num)?.toDouble(),
    startStateTimezoneAbbrev: json['startStateTimezoneAbbrev'] as String,
    endLocationLatitude: (json['endLocationLatitude'] as num)?.toDouble(),
    endLocationLongitude: (json['endLocationLongitude'] as num)?.toDouble(),
    endStateTimezoneAbbrev: json['endStateTimezoneAbbrev'] as String,
    durationSeconds: json['durationSeconds'] as int,
    workDefinitionType: json['workDefinitionType'] as String,
    segmentType: json['segmentType'] as String,
    isProjectedEnd: json['isProjectedEnd'] as bool,
    segmentOperator: json['segmentOperator'],
    updateUtc: json['updateUtc'] == null
        ? null
        : DateTime.parse(json['updateUtc'] as String),
    startTimeKeyDateUtc: json['startTimeKeyDateUtc'] == null
        ? null
        : DateTime.parse(json['startTimeKeyDateUtc'] as String),
    endTimeKeyDateUtc: json['endTimeKeyDateUtc'] == null
        ? null
        : DateTime.parse(json['endTimeKeyDateUtc'] as String),
    startTimeKeyDateLocal: json['startTimeKeyDateLocal'] == null
        ? null
        : DateTime.parse(json['startTimeKeyDateLocal'] as String),
    endTimeKeyDateLocal: json['endTimeKeyDateLocal'] == null
        ? null
        : DateTime.parse(json['endTimeKeyDateLocal'] as String),
    durationKeyDateSeconds: json['durationKeyDateSeconds'] as int,
  );
}

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
      'startTimeUtc': instance.startTimeUtc?.toIso8601String(),
      'endTimeUtc': instance.endTimeUtc?.toIso8601String(),
      'startTimeLocal': instance.startTimeLocal?.toIso8601String(),
      'endTimeLocal': instance.endTimeLocal?.toIso8601String(),
      'startLocationLatitude': instance.startLocationLatitude,
      'startLocationLongitude': instance.startLocationLongitude,
      'startStateTimezoneAbbrev': instance.startStateTimezoneAbbrev,
      'endLocationLatitude': instance.endLocationLatitude,
      'endLocationLongitude': instance.endLocationLongitude,
      'endStateTimezoneAbbrev': instance.endStateTimezoneAbbrev,
      'durationSeconds': instance.durationSeconds,
      'workDefinitionType': instance.workDefinitionType,
      'segmentType': instance.segmentType,
      'isProjectedEnd': instance.isProjectedEnd,
      'segmentOperator': instance.segmentOperator,
      'updateUtc': instance.updateUtc?.toIso8601String(),
      'startTimeKeyDateUtc': instance.startTimeKeyDateUtc?.toIso8601String(),
      'endTimeKeyDateUtc': instance.endTimeKeyDateUtc?.toIso8601String(),
      'startTimeKeyDateLocal':
          instance.startTimeKeyDateLocal?.toIso8601String(),
      'endTimeKeyDateLocal': instance.endTimeKeyDateLocal?.toIso8601String(),
      'durationKeyDateSeconds': instance.durationKeyDateSeconds,
    };

Capabilities _$CapabilitiesFromJson(Map<String, dynamic> json) {
  return Capabilities(
    hasActiveCoreSubscription: json['hasActiveCoreSubscription'] as String,
  );
}

Map<String, dynamic> _$CapabilitiesToJson(Capabilities instance) =>
    <String, dynamic>{
      'hasActiveCoreSubscription': instance.hasActiveCoreSubscription,
    };

Link _$LinkFromJson(Map<String, dynamic> json) {
  return Link(
    rel: json['rel'] as String,
    href: json['href'] as String,
  );
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'rel': instance.rel,
      'href': instance.href,
    };
