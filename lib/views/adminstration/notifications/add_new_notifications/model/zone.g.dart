// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneCreating _$ZoneCreatingFromJson(Map<String, dynamic> json) => ZoneCreating(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      zoneName: json['zoneName'] as String?,
    );

Map<String, dynamic> _$ZoneCreatingToJson(ZoneCreating instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
      'zoneName': instance.zoneName,
    };
