// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetLocationData _$AssetLocationDataFromJson(Map<String, dynamic> json) =>
    AssetLocationData(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      mapRecords: (json['mapRecords'] as List<dynamic>?)
          ?.map((e) => MapRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => CountDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetLocationDataToJson(AssetLocationData instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'links': instance.links,
      'mapRecords': instance.mapRecords,
      'countData': instance.countData,
    };

CountDatum _$CountDatumFromJson(Map<String, dynamic> json) => CountDatum(
      countOf: json['countOf'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CountDatumToJson(CountDatum instance) =>
    <String, dynamic>{
      'countOf': instance.countOf,
      'count': instance.count,
    };

MapRecord _$MapRecordFromJson(Map<String, dynamic> json) => MapRecord(
      assetIdentifier: json['assetIdentifier'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      manufacturer: json['manufacturer'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      assetIcon: json['assetIcon'] as int?,
      status: json['status'] as String?,
      hourMeter: (json['hourMeter'] as num?)?.toDouble(),
      odometer: (json['odometer'] as num?)?.toDouble(),
      lastReportedLocationLatitude:
          (json['lastReportedLocationLatitude'] as num?)?.toDouble(),
      lastReportedLocationLongitude:
          (json['lastReportedLocationLongitude'] as num?)?.toDouble(),
      lastReportedLocation: json['lastReportedLocation'] as String?,
      lastReportedUtc: json['lastReportedUtc'] == null
          ? null
          : DateTime.parse(json['lastReportedUtc'] as String),
      fuelLevelLastReported:
          (json['fuelLevelLastReported'] as num?)?.toDouble(),
      notifications: json['notifications'] as int?,
      geofences: json['geofences'] as List<dynamic>?,
      lastLocationUpdateUtc: json['lastLocationUpdateUtc'] == null
          ? null
          : DateTime.parse(json['lastLocationUpdateUtc'] as String),
    );

Map<String, dynamic> _$MapRecordToJson(MapRecord instance) => <String, dynamic>{
      'assetIdentifier': instance.assetIdentifier,
      'assetSerialNumber': instance.assetSerialNumber,
      'manufacturer': instance.manufacturer,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'assetIcon': instance.assetIcon,
      'status': instance.status,
      'hourMeter': instance.hourMeter,
      'odometer': instance.odometer,
      'lastReportedLocationLatitude': instance.lastReportedLocationLatitude,
      'lastReportedLocationLongitude': instance.lastReportedLocationLongitude,
      'lastReportedLocation': instance.lastReportedLocation,
      'lastReportedUtc': instance.lastReportedUtc?.toIso8601String(),
      'fuelLevelLastReported': instance.fuelLevelLastReported,
      'notifications': instance.notifications,
      'geofences': instance.geofences,
      'lastLocationUpdateUtc':
          instance.lastLocationUpdateUtc?.toIso8601String(),
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalCount: json['totalCount'] as int?,
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
