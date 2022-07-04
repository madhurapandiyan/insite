import 'package:json_annotation/json_annotation.dart';
part 'geofencemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Geofence {
  
  final List<Geofencemodeldata>? geofences;
  Geofence({this.geofences});
  factory Geofence.fromJson(Map<String, dynamic> json) =>
      _$GeofenceFromJson(json);
  Map<String, dynamic> toJson() => _$GeofenceToJson(this);
}

@JsonSerializable()
class Geofencemodeldata {
  @JsonKey(name: "geofenceUID")
  final String? GeofenceUID;
  @JsonKey(name: "geofenceName")
  final String? GeofenceName;
  @JsonKey(name: "geofences")
  final String? GeofenceType;
  @JsonKey(name: "description")
  final String? Description;
  @JsonKey(name: "isFavorite")
  dynamic IsFavorite;
  @JsonKey(name: "customerUID")
  final String? CustomerUID;
  @JsonKey(name: "isTransparent")
  final bool? IsTransparent;
  @JsonKey(name: "areaSqMeters")
  final double? AreaSqMeters;
  @JsonKey(name: "fillColor")
  final int? FillColor;
  @JsonKey(name: "startDate")
  final String? StartDate;
  @JsonKey(name: "geometryWKT")
  final String? GeometryWKT;
  @JsonKey(name: "endDate")
  final String? EndDate;

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
      this.GeometryWKT,
      this.EndDate});
  factory Geofencemodeldata.fromJson(Map<String, dynamic> json) =>
      _$GeofencemodeldataFromJson(json);
  Map<String, dynamic> toJson() => _$GeofencemodeldataToJson(this);
}
