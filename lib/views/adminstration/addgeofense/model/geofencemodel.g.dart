// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geofence _$GeofenceFromJson(Map<String, dynamic> json) => Geofence(
      Geofences: (json['Geofences'] as List<dynamic>?)
          ?.map((e) => Geofencemodeldata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeofenceToJson(Geofence instance) => <String, dynamic>{
      'Geofences': instance.Geofences?.map((e) => e.toJson()).toList(),
    };

Geofencemodeldata _$GeofencemodeldataFromJson(Map<String, dynamic> json) =>
    Geofencemodeldata(
      GeofenceUID: json['GeofenceUID'] as String?,
      GeofenceName: json['GeofenceName'] as String?,
      GeofenceType: json['GeofenceType'] as String?,
      Description: json['Description'] as String?,
      IsFavorite: json['IsFavorite'] as bool?,
      CustomerUID: json['CustomerUID'] as String?,
      IsTransparent: json['IsTransparent'] as bool?,
      AreaSqMeters: (json['AreaSqMeters'] as num?)?.toDouble(),
      FillColor: json['FillColor'] as int?,
      StartDate: json['StartDate'] as String?,
      GeometryWKT: json['GeometryWKT'] as String?,
      EndDate: json['EndDate'] as String?,
    );

Map<String, dynamic> _$GeofencemodeldataToJson(Geofencemodeldata instance) =>
    <String, dynamic>{
      'GeofenceUID': instance.GeofenceUID,
      'GeofenceName': instance.GeofenceName,
      'GeofenceType': instance.GeofenceType,
      'Description': instance.Description,
      'IsFavorite': instance.IsFavorite,
      'CustomerUID': instance.CustomerUID,
      'IsTransparent': instance.IsTransparent,
      'AreaSqMeters': instance.AreaSqMeters,
      'FillColor': instance.FillColor,
      'StartDate': instance.StartDate,
      'GeometryWKT': instance.GeometryWKT,
      'EndDate': instance.EndDate,
    };
