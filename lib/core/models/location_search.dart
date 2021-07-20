import 'package:json_annotation/json_annotation.dart';
part 'location_search.g.dart';

@JsonSerializable()
class LocationSearchResponse {
  final List<LocationSearchData> Locations;
  LocationSearchResponse({this.Locations});

  factory LocationSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchResponseToJson(this);
}

@JsonSerializable()
class LocationSearchData {
  final LocationSearchAddress Address;
  final LocationSearchCoords Coords;
  LocationSearchData({this.Address, this.Coords});

  factory LocationSearchData.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchDataToJson(this);
}

@JsonSerializable()
class LocationSearchAddress {
  final String StreetAddress;
  final String City;
  final String State;
  final String StateName;
  final String Zip;
  final String Country;
  LocationSearchAddress(
      {this.StreetAddress,
      this.Zip,
      this.City,
      this.Country,
      this.State,
      this.StateName});

  factory LocationSearchAddress.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchAddressFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchAddressToJson(this);
}

@JsonSerializable()
class LocationSearchCoords {
  final String Lat;
  final String Lon;
  LocationSearchCoords({this.Lat, this.Lon});

  factory LocationSearchCoords.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchCoordsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchCoordsToJson(this);
}
