import 'package:json_annotation/json_annotation.dart';
part 'geofencepayload.g.dart';

@JsonSerializable()
class Geofencepayload {
  final String? ActionUTC;
  final String? GeofenceUID;
  final String? EndDate;
  final int? FillColor;
  final String? Description;
  final String? GeofenceName;
  final String? GeofenceType;
  final String? GeometryWKT;
  final bool? IsTransparent;
  final bool? IsFavorite;
  Geofencepayload(
      {this.ActionUTC,
      this.GeofenceUID,
      this.EndDate,
      this.FillColor,
      this.Description,
      this.GeofenceName,
      this.GeofenceType,
      this.GeometryWKT,
      this.IsTransparent,this.IsFavorite});
  factory Geofencepayload.fromJson(Map<String, dynamic> json) =>
      _$GeofencepayloadFromJson(json);
  Map<String, dynamic> toJson() => _$GeofencepayloadToJson(this);
}
