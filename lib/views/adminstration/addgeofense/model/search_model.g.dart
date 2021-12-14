// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      Err: json['Err'] as num?,
      Locations: (json['Locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'Err': instance.Err,
      'Locations': instance.Locations?.map((e) => e.toJson()).toList(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      Address: json['Address'] == null
          ? null
          : AddressLocation.fromJson(json['Address'] as Map<String, dynamic>),
      Coords: json['Coords'] == null
          ? null
          : Coordinate.fromJson(json['Coords'] as Map<String, dynamic>),
      Region: json['Region'] as int?,
      POITypeID: json['POITypeID'] as int?,
      PersistentPOIID: json['PersistentPOIID'] as int?,
      SiteID: json['SiteID'] as int?,
      ResultType: json['ResultType'] as int?,
      ShortString: json['ShortString'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'Address': instance.Address?.toJson(),
      'Coords': instance.Coords?.toJson(),
      'Region': instance.Region,
      'POITypeID': instance.POITypeID,
      'PersistentPOIID': instance.PersistentPOIID,
      'SiteID': instance.SiteID,
      'ResultType': instance.ResultType,
      'ShortString': instance.ShortString,
    };

AddressLocation _$AddressLocationFromJson(Map<String, dynamic> json) =>
    AddressLocation(
      StreetAddress: json['StreetAddress'] as String?,
      City: json['City'] as String?,
      State: json['State'] as String?,
      StateName: json['StateName'] as String?,
      Zip: json['Zip'] as String?,
      County: json['County'] as String?,
      Country: json['Country'] as String?,
      CountryFullName: json['CountryFullName'] as String?,
      SPLC: json['SPLC'] as String?,
    );

Map<String, dynamic> _$AddressLocationToJson(AddressLocation instance) =>
    <String, dynamic>{
      'StreetAddress': instance.StreetAddress,
      'City': instance.City,
      'State': instance.State,
      'StateName': instance.StateName,
      'Zip': instance.Zip,
      'County': instance.County,
      'Country': instance.Country,
      'CountryFullName': instance.CountryFullName,
      'SPLC': instance.SPLC,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) => Coordinate(
      Lat: json['Lat'] as String?,
      Lon: json['Lon'] as String?,
    );

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'Lat': instance.Lat,
      'Lon': instance.Lon,
    };
