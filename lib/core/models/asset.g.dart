// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset(
    json['assetId'] as String,
    json['assetUid'] as String,
    json['makeCode'] as String,
    json['model'] as String,
    (json['assetLocalDates'] as List)
        ?.map((e) => e == null
            ? null
            : AssetLocalDate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['serialNumber'] as String,
    json['productFamily'] as String,
    json['assetLastReceivedEvent'] == null
        ? null
        : AssetLastReceivedEvent.fromJson(
            json['assetLastReceivedEvent'] as Map<String, dynamic>),
    json['customStateDescription'] as String,
    (json['dateRangeRuntimeDuration'] as num)?.toDouble(),
    json['lastKnownOperator'] as String,
    json['capabilities'] as String,
  );
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'assetUid': instance.assetUid,
      'assetId': instance.assetId,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'serialNumber': instance.serialNumber,
      'productFamily': instance.productFamily,
      'customStateDescription': instance.customStateDescription,
      'dateRangeRuntimeDuration': instance.dateRangeRuntimeDuration,
      'lastKnownOperator': instance.lastKnownOperator,
      'capabilities': instance.capabilities,
      'assetLastReceivedEvent': instance.assetLastReceivedEvent,
      'assetLocalDates': instance.assetLocalDates,
    };

AssetLastReceivedEvent _$AssetLastReceivedEventFromJson(
    Map<String, dynamic> json) {
  return AssetLastReceivedEvent(
    json['lastReceivedEvent'] as String,
    json['lastReceivedEventTimeLocal'] as String,
    json['lastReceivedEventUTC'] as String,
    json['timezoneAbbrev'] as String,
    json['serialNumber'] as String,
    json['segmentType'] as String,
  );
}

Map<String, dynamic> _$AssetLastReceivedEventToJson(
        AssetLastReceivedEvent instance) =>
    <String, dynamic>{
      'lastReceivedEvent': instance.lastReceivedEvent,
      'lastReceivedEventTimeLocal': instance.lastReceivedEventTimeLocal,
      'lastReceivedEventUTC': instance.lastReceivedEventUTC,
      'timezoneAbbrev': instance.timezoneAbbrev,
      'serialNumber': instance.serialNumber,
      'segmentType': instance.segmentType,
    };

AssetSummaryResponse _$AssetSummaryResponseFromJson(Map<String, dynamic> json) {
  return AssetSummaryResponse(
    assets: (json['assets'] as List)
        ?.map((e) => e == null ? null : Asset.fromJson(e))
        ?.toList(),
    links: (json['links'] as List)
        ?.map(
            (e) => e == null ? null : Links.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pagination: json['pagination'] == null
        ? null
        : AssetPagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AssetSummaryResponseToJson(
        AssetSummaryResponse instance) =>
    <String, dynamic>{
      'links': instance.links,
      'pagination': instance.pagination,
      'assets': instance.assets,
    };

AssetResponse _$AssetResponseFromJson(Map<String, dynamic> json) {
  return AssetResponse(
    assetOperations: json['assetOperations'] == null
        ? null
        : AssetSummaryResponse.fromJson(
            json['assetOperations'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AssetResponseToJson(AssetResponse instance) =>
    <String, dynamic>{
      'assetOperations': instance.assetOperations,
    };

AssetLocalDate _$AssetLocalDateFromJson(Map<String, dynamic> json) {
  return AssetLocalDate(
    assetLocalDate: json['assetLocalDate'] as String,
    segmentDuration: json['segmentDuration'] == null
        ? null
        : AssetSegmentDuration.fromJson(
            json['segmentDuration'] as Map<String, dynamic>),
    totalRuntimeDurationSeconds:
        (json['totalRuntimeDurationSeconds'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AssetLocalDateToJson(AssetLocalDate instance) =>
    <String, dynamic>{
      'assetLocalDate': instance.assetLocalDate,
      'totalRuntimeDurationSeconds': instance.totalRuntimeDurationSeconds,
      'segmentDuration': instance.segmentDuration,
    };

AssetSegmentDuration _$AssetSegmentDurationFromJson(Map<String, dynamic> json) {
  return AssetSegmentDuration(
    runningDurationSeconds: (json['runningDurationSeconds'] as num)?.toDouble(),
    workingDurationSeconds: (json['workingDurationSeconds'] as num)?.toDouble(),
    idleDurationSeconds: (json['idleDurationSeconds'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AssetSegmentDurationToJson(
        AssetSegmentDuration instance) =>
    <String, dynamic>{
      'runningDurationSeconds': instance.runningDurationSeconds,
      'workingDurationSeconds': instance.workingDurationSeconds,
      'idleDurationSeconds': instance.idleDurationSeconds,
    };
