// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationSearchResponse _$LocationSearchResponseFromJson(
        Map<String, dynamic> json) =>
    LocationSearchResponse(
      Locations: (json['Locations'] as List<dynamic>?)
          ?.map((e) => LocationSearchData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationSearchResponseToJson(
        LocationSearchResponse instance) =>
    <String, dynamic>{
      'Locations': instance.Locations,
    };

LocationSearchData _$LocationSearchDataFromJson(Map<String, dynamic> json) =>
    LocationSearchData(
      Address: json['Address'] == null
          ? null
          : LocationSearchAddress.fromJson(
              json['Address'] as Map<String, dynamic>),
      Coords: json['Coords'] == null
          ? null
          : LocationSearchCoords.fromJson(
              json['Coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationSearchDataToJson(LocationSearchData instance) =>
    <String, dynamic>{
      'Address': instance.Address,
      'Coords': instance.Coords,
    };

LocationSearchAddress _$LocationSearchAddressFromJson(
        Map<String, dynamic> json) =>
    LocationSearchAddress(
      StreetAddress: json['StreetAddress'] as String?,
      Zip: json['Zip'] as String?,
      City: json['City'] as String?,
      Country: json['Country'] as String?,
      State: json['State'] as String?,
      StateName: json['StateName'] as String?,
    );

Map<String, dynamic> _$LocationSearchAddressToJson(
        LocationSearchAddress instance) =>
    <String, dynamic>{
      'StreetAddress': instance.StreetAddress,
      'City': instance.City,
      'State': instance.State,
      'StateName': instance.StateName,
      'Zip': instance.Zip,
      'Country': instance.Country,
    };

LocationSearchCoords _$LocationSearchCoordsFromJson(
        Map<String, dynamic> json) =>
    LocationSearchCoords(
      Lat: json['Lat'] as String?,
      Lon: json['Lon'] as String?,
    );

Map<String, dynamic> _$LocationSearchCoordsToJson(
        LocationSearchCoords instance) =>
    <String, dynamic>{
      'Lat': instance.Lat,
      'Lon': instance.Lon,
    };
