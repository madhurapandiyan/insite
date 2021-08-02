// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_location_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetLocationHistory _$AssetLocationHistoryFromJson(Map<String, dynamic> json) {
  return AssetLocationHistory(
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    assetLocation: (json['assetLocation'] as List)
        ?.map((e) => e == null
            ? null
            : AssetLocation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssetLocationHistoryToJson(
        AssetLocationHistory instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'links': instance.links,
      'assetLocation': instance.assetLocation,
    };

AssetLocation _$AssetLocationFromJson(Map<String, dynamic> json) {
  return AssetLocation(
    assetEventHistoryId: json['assetEventHistoryId'] as int,
    assetIdentifier: json['assetIdentifier'] as String,
    serialNumber: json['serialNumber'] as String,
    makeCode: json['makeCode'] as String,
    model: json['model'] as String,
    locationEventUtc: json['locationEventUtc'] == null
        ? null
        : DateTime.parse(json['locationEventUtc'] as String),
    locationEventLocalTime: json['locationEventLocalTime'] == null
        ? null
        : DateTime.parse(json['locationEventLocalTime'] as String),
    locationEventLocalTimeZoneAbbrev:
        json['locationEventLocalTimeZoneAbbrev'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    odometer: (json['odometer'] as num)?.toDouble(),
    hourmeter: (json['hourmeter'] as num)?.toDouble(),
    assetStatus: json['assetStatus'] as String,
  );
}

Map<String, dynamic> _$AssetLocationToJson(AssetLocation instance) =>
    <String, dynamic>{
      'assetEventHistoryId': instance.assetEventHistoryId,
      'assetIdentifier': instance.assetIdentifier,
      'serialNumber': instance.serialNumber,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'locationEventUtc': instance.locationEventUtc?.toIso8601String(),
      'locationEventLocalTime':
          instance.locationEventLocalTime?.toIso8601String(),
      'locationEventLocalTimeZoneAbbrev':
          instance.locationEventLocalTimeZoneAbbrev,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'odometer': instance.odometer,
      'hourmeter': instance.hourmeter,
      'assetStatus': instance.assetStatus,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    streetAddress: json['streetAddress'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    county: json['county'] as String,
    country: json['country'] as String,
    zip: json['zip'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'streetAddress': instance.streetAddress,
      'city': instance.city,
      'state': instance.state,
      'county': instance.county,
      'country': instance.country,
      'zip': instance.zip,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    totalCount: json['totalCount'] as int,
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
