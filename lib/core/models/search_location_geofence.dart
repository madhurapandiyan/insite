import 'package:json_annotation/json_annotation.dart';
part 'search_location_geofence.g.dart';

@JsonSerializable()
class SearchLocationGeofence {
  GeofenceSearchLocation? geofenceSearchLoaction;
  SearchLocationGeofence({this.geofenceSearchLoaction});
  factory SearchLocationGeofence.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationGeofenceFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLocationGeofenceToJson(this);
}

@JsonSerializable()
class GeofenceSearchLocation {
  int? err;
  List<Locations>? locations;
  GeofenceSearchLocation({this.err,this.locations});
  factory GeofenceSearchLocation.fromJson(Map<String, dynamic> json) =>
      _$GeofenceSearchLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeofenceSearchLocationToJson(this);
}

@JsonSerializable()
class Locations {
  Coords? coords;
  String? shortString;
  Locations({this.coords,this.shortString});
  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

@JsonSerializable()
class Coords {
  String? lat;
  String? lon;
  Coords({this.lat,this.lon});
  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);

  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}
