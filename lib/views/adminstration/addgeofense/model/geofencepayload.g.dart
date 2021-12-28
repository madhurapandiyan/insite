// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencepayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geofencepayload _$GeofencepayloadFromJson(Map<String, dynamic> json) =>
    Geofencepayload(
      ActionUTC: json['ActionUTC'] as String?,
      GeofenceUID: json['GeofenceUID'] as String?,
      EndDate: json['EndDate'] as String?,
      FillColor: json['FillColor'] as int?,
      Description: json['Description'] as String?,
      GeofenceName: json['GeofenceName'] as String?,
      GeofenceType: json['GeofenceType'] as String?,
      GeometryWKT: json['GeometryWKT'] as String?,
      IsTransparent: json['IsTransparent'] as bool?,
      IsFavorite: json['IsFavorite'] as bool?,
    );

Map<String, dynamic> _$GeofencepayloadToJson(Geofencepayload instance) =>
    <String, dynamic>{
      'ActionUTC': instance.ActionUTC,
      'GeofenceUID': instance.GeofenceUID,
      'EndDate': instance.EndDate,
      'FillColor': instance.FillColor,
      'Description': instance.Description,
      'GeofenceName': instance.GeofenceName,
      'GeofenceType': instance.GeofenceType,
      'GeometryWKT': instance.GeometryWKT,
      'IsTransparent': instance.IsTransparent,
      'IsFavorite': instance.IsFavorite,
    };
