// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimated_cycle_volume_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimatedCycleVolumePayLoad _$EstimatedCycleVolumePayLoadFromJson(
        Map<String, dynamic> json) =>
    EstimatedCycleVolumePayLoad(
      assetProductivitySettings:
          (json['assetProductivitySettings'] as List<dynamic>?)
              ?.map((e) =>
                  AssetProductivitySettings.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EstimatedCycleVolumePayLoadToJson(
        EstimatedCycleVolumePayLoad instance) =>
    <String, dynamic>{
      'assetProductivitySettings': instance.assetProductivitySettings,
    };

AssetProductivitySettings _$AssetProductivitySettingsFromJson(
        Map<String, dynamic> json) =>
    AssetProductivitySettings(
      cycles: json['cycles'] == null
          ? null
          : Cycles.fromJson(json['cycles'] as Map<String, dynamic>),
      volumes: json['volumes'] == null
          ? null
          : Volumes.fromJson(json['volumes'] as Map<String, dynamic>),
      payload: json['payload'] == null
          ? null
          : PayLoad.fromJson(json['payload'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      assetUid: json['assetUid'] as String?,
    );

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

Cycles _$CyclesFromJson(Map<String, dynamic> json) => Cycles(
      sunday: (json['sunday'] as num?)?.toDouble(),
      monday: (json['monday'] as num?)?.toDouble(),
      tuesday: (json['tuesday'] as num?)?.toDouble(),
      wednesday: (json['wednesday'] as num?)?.toDouble(),
      thursday: (json['thursday'] as num?)?.toDouble(),
      friday: (json['friday'] as num?)?.toDouble(),
      saturday: (json['saturday'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CyclesToJson(Cycles instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };

Volumes _$VolumesFromJson(Map<String, dynamic> json) => Volumes(
      sunday: (json['sunday'] as num?)?.toDouble(),
      monday: (json['monday'] as num?)?.toDouble(),
      tuesday: (json['tuesday'] as num?)?.toDouble(),
      wednesday: (json['wednesday'] as num?)?.toDouble(),
      thursday: (json['thursday'] as num?)?.toDouble(),
      friday: (json['friday'] as num?)?.toDouble(),
      saturday: (json['saturday'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VolumesToJson(Volumes instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };

PayLoad _$PayLoadFromJson(Map<String, dynamic> json) => PayLoad(
      sunday: (json['sunday'] as num?)?.toDouble(),
      monday: (json['monday'] as num?)?.toDouble(),
      tuesday: (json['tuesday'] as num?)?.toDouble(),
      wednesday: (json['wednesday'] as num?)?.toDouble(),
      thursday: (json['thursday'] as num?)?.toDouble(),
      friday: (json['friday'] as num?)?.toDouble(),
      saturday: (json['saturday'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PayLoadToJson(PayLoad instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };
