import 'package:flutter_map/flutter_map.dart';
import 'package:json_annotation/json_annotation.dart';
part 'geofencemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Geofence {
  final List<Geofencemodeldata> Geofences;
  Geofence({this.Geofences});
  factory Geofence.fromJson(Map<String, dynamic> json) =>
      _$GeofenceFromJson(json);
  Map<String, dynamic> toJson() => _$GeofenceToJson(this);
}

@JsonSerializable()
class Geofencemodeldata {
  final String GeofenceUID;
  final String GeofenceName;
  final String GeofenceType;
  final String Description;
  final bool IsFavorite;
  final String CustomerUID;
  final bool IsTransparent;
  final double AreaSqMeters;
  final int FillColor;
  final String StartDate;
  final String GeometryWKT;

  Geofencemodeldata(
      {this.GeofenceUID,
      this.GeofenceName,
      this.GeofenceType,
      this.Description,
      this.IsFavorite,
      this.CustomerUID,
      this.IsTransparent,
      this.AreaSqMeters,
      this.FillColor,
      this.StartDate,
      this.GeometryWKT});
  factory Geofencemodeldata.fromJson(Map<String, dynamic> json) =>
      _$GeofencemodeldataFromJson(json);
  Map<String, dynamic> toJson() => _$GeofencemodeldataToJson(this);
}
