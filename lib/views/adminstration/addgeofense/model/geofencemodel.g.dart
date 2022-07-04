// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geofence _$GeofenceFromJson(Map<String, dynamic> json) => Geofence(
      geofences: (json['geofences'] as List<dynamic>?)
          ?.map((e) => Geofencemodeldata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeofenceToJson(Geofence instance) => <String, dynamic>{
      'geofences': instance.geofences?.map((e) => e.toJson()).toList(),
    };

Geofencemodeldata _$GeofencemodeldataFromJson(Map<String, dynamic> json) =>
    Geofencemodeldata(
      GeofenceUID: json['geofenceUID'] as String?,
      GeofenceName: json['geofenceName'] as String?,
      GeofenceType: json['geofences'] as String?,
      Description: json['description'] as String?,
      IsFavorite: json['isFavorite'],
      CustomerUID: json['customerUID'] as String?,
      IsTransparent: json['isTransparent'] as bool?,
      AreaSqMeters: (json['areaSqMeters'] as num?)?.toDouble(),
      FillColor: json['fillColor'] as int?,
      StartDate: json['startDate'] as String?,
      GeometryWKT: json['geometryWKT'] as String?,
      EndDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$GeofencemodeldataToJson(Geofencemodeldata instance) =>
    <String, dynamic>{
      'geofenceUID': instance.GeofenceUID,
      'geofenceName': instance.GeofenceName,
      'geofences': instance.GeofenceType,
      'description': instance.Description,
      'isFavorite': instance.IsFavorite,
      'customerUID': instance.CustomerUID,
      'isTransparent': instance.IsTransparent,
      'areaSqMeters': instance.AreaSqMeters,
      'fillColor': instance.FillColor,
      'startDate': instance.StartDate,
      'geometryWKT': instance.GeometryWKT,
      'endDate': instance.EndDate,
    };
