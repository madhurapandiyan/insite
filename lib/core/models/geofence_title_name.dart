import 'package:json_annotation/json_annotation.dart';
part 'geofence_title_name.g.dart';

@JsonSerializable()
class GeofenceTitleName {
  GetGeofenceName? getGeofenceName;
  GeofenceTitleName({this.getGeofenceName});
  factory GeofenceTitleName.fromJson(Map<String, dynamic> json) =>
      _$GeofenceTitleNameFromJson(json);

  Map<String, dynamic> toJson() => _$GeofenceTitleNameToJson(this);
}

@JsonSerializable()
class GetGeofenceName {
  bool? geofenceNameExist;
  GetGeofenceName({this.geofenceNameExist});
  factory GetGeofenceName.fromJson(Map<String, dynamic> json) =>
      _$GetGeofenceNameFromJson(json);

  Map<String, dynamic> toJson() => _$GetGeofenceNameToJson(this);
}
