// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence_title_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeofenceTitleName _$GeofenceTitleNameFromJson(Map<String, dynamic> json) =>
    GeofenceTitleName(
      getGeofenceName: json['getGeofenceName'] == null
          ? null
          : GetGeofenceName.fromJson(
              json['getGeofenceName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeofenceTitleNameToJson(GeofenceTitleName instance) =>
    <String, dynamic>{
      'getGeofenceName': instance.getGeofenceName,
    };

GetGeofenceName _$GetGeofenceNameFromJson(Map<String, dynamic> json) =>
    GetGeofenceName(
      geofenceNameExist: json['geofenceNameExist'] as bool?,
    );

Map<String, dynamic> _$GetGeofenceNameToJson(GetGeofenceName instance) =>
    <String, dynamic>{
      'geofenceNameExist': instance.geofenceNameExist,
    };
