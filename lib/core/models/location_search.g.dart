// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationSearchResponse _$LocationSearchResponseFromJson(
    Map<String, dynamic> json) {
  return LocationSearchResponse(
    Locations: (json['Locations'] as List)
        ?.map((e) => e == null
            ? null
            : LocationSearchData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationSearchResponseToJson(
        LocationSearchResponse instance) =>
    <String, dynamic>{
      'Locations': instance.Locations,
    };

LocationSearchData _$LocationSearchDataFromJson(Map<String, dynamic> json) {
  return LocationSearchData(
    Address: json['Address'] == null
        ? null
        : LocationSearchAddress.fromJson(
            json['Address'] as Map<String, dynamic>),
    Coords: json['Coords'] == null
        ? null
        : LocationSearchCoords.fromJson(json['Coords'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationSearchDataToJson(LocationSearchData instance) =>
    <String, dynamic>{
      'Address': instance.Address,
      'Coords': instance.Coords,
    };

LocationSearchAddress _$LocationSearchAddressFromJson(
    Map<String, dynamic> json) {
  return LocationSearchAddress(
    StreetAddress: json['StreetAddress'] as String,
    City: json['City'] as String,
    State: json['State'] as String,
    StateName: json['StateName'] as String,
  );
}

Map<String, dynamic> _$LocationSearchAddressToJson(
        LocationSearchAddress instance) =>
    <String, dynamic>{
      'StreetAddress': instance.StreetAddress,
      'City': instance.City,
      'State': instance.State,
      'StateName': instance.StateName,
    };

LocationSearchCoords _$LocationSearchCoordsFromJson(Map<String, dynamic> json) {
  return LocationSearchCoords(
    Lat: json['Lat'] as String,
    Lon: json['Lon'] as String,
  );
}

Map<String, dynamic> _$LocationSearchCoordsToJson(
        LocationSearchCoords instance) =>
    <String, dynamic>{
      'Lat': instance.Lat,
      'Lon': instance.Lon,
    };
