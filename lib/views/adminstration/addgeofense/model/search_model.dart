import 'package:insite/core/models/admin_manage_user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_model.g.dart';
@JsonSerializable(explicitToJson: true)
class SearchModel {
  final num Err;
  final List<Location> Locations;
  SearchModel({this.Err, this.Locations});
  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class Location {
  final AddressLocation Address;
  final Coordinate Coords;
  final int Region;
  final int POITypeID;
  final int PersistentPOIID;
  final int SiteID;
  final int ResultType;
  final String ShortString;
  Location(
      {this.Address,
      this.Coords,
      this.Region,
      this.POITypeID,
      this.PersistentPOIID,
      this.SiteID,
      this.ResultType,
      this.ShortString});
        factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
@JsonSerializable()
class AddressLocation {
  final String StreetAddress;
  final String City;
  final String State;
  final String StateName;
  final String Zip;
  final String County;
  final String Country;
  final String CountryFullName;
  final String SPLC;
  AddressLocation(
      {this.StreetAddress,
      this.City,
      this.State,
      this.StateName,
      this.Zip,
      this.County,
      this.Country,
      this.CountryFullName,
      this.SPLC});
        factory AddressLocation.fromJson(Map<String, dynamic> json) =>
      _$AddressLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AddressLocationToJson(this);
}
@JsonSerializable()
class Coordinate {
  final String Lat;
  final String Lon;
  Coordinate({this.Lat, this.Lon});
    factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}
