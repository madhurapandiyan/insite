import 'package:json_annotation/json_annotation.dart';
part 'geofencepayload.g.dart';

@JsonSerializable()
class Geofencepayload {
  final String ActionUTC;
  final String EndDate;
  final int FillColor;
  final String GeofenceName;
  final String GeofenceType;
  final String GeometryWKT;
  final bool IsTransparent;
  Geofencepayload(
      {this.ActionUTC,
      this.EndDate,
      this.FillColor,
      this.GeofenceName,
      this.GeofenceType,
      this.GeometryWKT,
      this.IsTransparent});
          factory Geofencepayload.fromJson(Map<String, dynamic> json) =>
      _$GeofencepayloadFromJson(json);
  Map<String, dynamic> toJson() => _$GeofencepayloadToJson(this);
}
