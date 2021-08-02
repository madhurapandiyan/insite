// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthListResponse _$HealthListResponseFromJson(Map<String, dynamic> json) {
  return HealthListResponse(
    assetData: json['assetData'] == null
        ? null
        : AssetData.fromJson(json['assetData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HealthListResponseToJson(HealthListResponse instance) =>
    <String, dynamic>{
      'assetData': instance.assetData,
    };

AssetData _$AssetDataFromJson(Map<String, dynamic> json) {
  return AssetData(
    faults: (json['faults'] as List)
        ?.map(
            (e) => e == null ? null : Fault.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetDataToJson(AssetData instance) => <String, dynamic>{
      'faults': instance.faults,
    };

Fault _$FaultFromJson(Map<String, dynamic> json) {
  return Fault(
    description: json['description'] as String,
    lastReportedLocation: json['lastReportedLocation'] as String,
    lastReportedTimeUTC: json['lastReportedTimeUTC'] as String,
    hours: (json['hours'] as num)?.toDouble(),
    severityLabel: json['severityLabel'] as String,
    source: json['source'] as String,
  );
}

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
      'description': instance.description,
      'lastReportedLocation': instance.lastReportedLocation,
      'hours': instance.hours,
      'severityLabel': instance.severityLabel,
      'lastReportedTimeUTC': instance.lastReportedTimeUTC,
      'source': instance.source,
    };
