// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimated_cycle_volume_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimatedCycleVolumePayLoad _$EstimatedCycleVolumePayLoadFromJson(
    Map<String, dynamic> json) {
  return EstimatedCycleVolumePayLoad(
    assetProductivitySettings: (json['assetProductivitySettings'] as List)
        ?.map((e) => e == null
            ? null
            : AssetProductivitySettings.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EstimatedCycleVolumePayLoadToJson(
        EstimatedCycleVolumePayLoad instance) =>
    <String, dynamic>{
      'assetProductivitySettings': instance.assetProductivitySettings,
    };

AssetProductivitySettings _$AssetProductivitySettingsFromJson(
    Map<String, dynamic> json) {
  return AssetProductivitySettings(
    cycles: json['cycles'] == null
        ? null
        : Cycles.fromJson(json['cycles'] as Map<String, dynamic>),
    volumes: json['volumes'] == null
        ? null
        : Volumes.fromJson(json['volumes'] as Map<String, dynamic>),
    payload: json['payload'] == null
        ? null
        : Cycles.fromJson(json['payload'] as Map<String, dynamic>),
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
    assetUid: json['assetUid'] as String,
  );
}

Map<String, dynamic> _$AssetProductivitySettingsToJson(
        AssetProductivitySettings instance) =>
    <String, dynamic>{
      'cycles': instance.cycles,
      'volumes': instance.volumes,
      'payload': instance.payload,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'assetUid': instance.assetUid,
    };

Cycles _$CyclesFromJson(Map<String, dynamic> json) {
  return Cycles(
    sunday: json['sunday'] as int,
    monday: json['monday'] as int,
    tuesday: json['tuesday'] as int,
    wednesday: json['wednesday'] as int,
    thursday: json['thursday'] as int,
    friday: json['friday'] as int,
    saturday: json['saturday'] as int,
  );
}

Map<String, dynamic> _$CyclesToJson(Cycles instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };

Volumes _$VolumesFromJson(Map<String, dynamic> json) {
  return Volumes(
    sunday: (json['sunday'] as num)?.toDouble(),
    monday: (json['monday'] as num)?.toDouble(),
    tuesday: (json['tuesday'] as num)?.toDouble(),
    wednesday: (json['wednesday'] as num)?.toDouble(),
    thursday: (json['thursday'] as num)?.toDouble(),
    friday: (json['friday'] as num)?.toDouble(),
    saturday: (json['saturday'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VolumesToJson(Volumes instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };
