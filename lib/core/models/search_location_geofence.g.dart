// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_geofence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationGeofence _$SearchLocationGeofenceFromJson(
        Map<String, dynamic> json) =>
    SearchLocationGeofence(
      geofenceSearchLoaction: json['geofenceSearchLoaction'] == null
          ? null
          : GeofenceSearchLocation.fromJson(
              json['geofenceSearchLoaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchLocationGeofenceToJson(
        SearchLocationGeofence instance) =>
    <String, dynamic>{
      'geofenceSearchLoaction': instance.geofenceSearchLoaction,
    };

GeofenceSearchLocation _$GeofenceSearchLocationFromJson(
        Map<String, dynamic> json) =>
    GeofenceSearchLocation(
      err: json['err'] as int?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Locations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeofenceSearchLocationToJson(
        GeofenceSearchLocation instance) =>
    <String, dynamic>{
      'err': instance.err,
      'locations': instance.locations,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      coords: json['coords'] == null
          ? null
          : Coords.fromJson(json['coords'] as Map<String, dynamic>),
      shortString: json['shortString'] as String?,
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'coords': instance.coords,
      'shortString': instance.shortString,
    };

Coords _$CoordsFromJson(Map<String, dynamic> json) => Coords(
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
    );

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
