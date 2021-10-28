// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geofence _$GeofenceFromJson(Map<String, dynamic> json) {
  return Geofence(
    Geofences: (json['Geofences'] as List)
        ?.map((e) => e == null
            ? null
            : Geofencemodeldata.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GeofenceToJson(Geofence instance) => <String, dynamic>{
      'Geofences': instance.Geofences?.map((e) => e?.toJson())?.toList(),
    };

Geofencemodeldata _$GeofencemodeldataFromJson(Map<String, dynamic> json) {
  return Geofencemodeldata(
    GeofenceUID: json['GeofenceUID'] as String,
    GeofenceName: json['GeofenceName'] as String,
    GeofenceType: json['GeofenceType'] as String,
    IsFavorite: json['IsFavorite'] as bool,
    CustomerUID: json['CustomerUID'] as String,
    IsTransparent: json['IsTransparent'] as bool,
    AreaSqMeters: (json['AreaSqMeters'] as num)?.toDouble(),
    FillColor: json['FillColor'] as int,
    StartDate: json['StartDate'] as String,
    GeometryWKT: json['GeometryWKT'] as String,
  );
}

Map<String, dynamic> _$GeofencemodeldataToJson(Geofencemodeldata instance) =>
    <String, dynamic>{
      'GeofenceUID': instance.GeofenceUID,
      'GeofenceName': instance.GeofenceName,
      'GeofenceType': instance.GeofenceType,
      'IsFavorite': instance.IsFavorite,
      'CustomerUID': instance.CustomerUID,
      'IsTransparent': instance.IsTransparent,
      'AreaSqMeters': instance.AreaSqMeters,
      'FillColor': instance.FillColor,
      'StartDate': instance.StartDate,
      'GeometryWKT': instance.GeometryWKT,
    };
