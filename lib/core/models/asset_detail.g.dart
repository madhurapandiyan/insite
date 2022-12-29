// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDetail _$AssetDetailFromJson(Map<String, dynamic> json) => AssetDetail(
      json['assetUid'] as String?,
      json['assetId'] as String?,
      json['assetSerialNumber'] as String?,
      (json['hourMeter'] as num?)?.toDouble(),
      json['lifetimeFuel'],
      (json['activeServicePlans'] as List<dynamic>?)
          ?.map((e) => ServicePlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['makeCode'] as String?,
      json['lastReportedLocation'] as String?,
      (json['fuelLevelLastReported'] as num?)?.toDouble(),
      json['lastReportedTimeUtc'] as String?,
      json['lastLocationUpdateUtc'] as String?,
      json['percentDEFRemaining'],
      json['lifetimeDEFLiters'],
      json['manufacturer'] as String?,
      (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['model'] as String?,
      json['lastPercentFuelRemainingUTC'] as String?,
      json['lastLifetimeDEFLitersUTC'] as String?,
      json['lastPercentDEFRemainingUTC'] as String?,
      json['fuelReportedTimeUtc'] as String?,
      (json['year'] as num?)?.toDouble(),
      json['assetIcon'] as int?,
      json['productFamily'] as String?,
      json['status'] as String?,
      json['customStateDescription'] as String?,
      json['dealerName'] as String?,
      json['dealerCustomerNumber'] as String?,
      json['accountName'] as String?,
      json['universalCustomerIdentifier'] as String?,
      json['universalCustomerName'] as String?,
      (json['lastReportedLocationLatitude'] as num?)?.toDouble(),
      (json['lastReportedLocationLongitude'] as num?)?.toDouble(),
      (json['geofences'] as List<dynamic>?)
          ?.map((e) => Geofences.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetDetailToJson(AssetDetail instance) =>
    <String, dynamic>{
      'assetUid': instance.assetUid,
      'assetId': instance.assetId,
      'assetSerialNumber': instance.assetSerialNumber,
      'makeCode': instance.makeCode,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'year': instance.year,
      'assetIcon': instance.assetIcon,
      'productFamily': instance.productFamily,
      'status': instance.status,
      'customStateDescription': instance.customStateDescription,
      'dealerName': instance.dealerName,
      'hourMeter': instance.hourMeter,
      'dealerCustomerNumber': instance.dealerCustomerNumber,
      'accountName': instance.accountName,
      'universalCustomerIdentifier': instance.universalCustomerIdentifier,
      'universalCustomerName': instance.universalCustomerName,
      'lastReportedLocation': instance.lastReportedLocation,
      'lastReportedLocationLatitude': instance.lastReportedLocationLatitude,
      'lastReportedLocationLongitude': instance.lastReportedLocationLongitude,
      'fuelLevelLastReported': instance.fuelLevelLastReported,
      'lastPercentFuelRemainingUTC': instance.lastPercentFuelRemainingUTC,
      'fuelReportedTimeUtc': instance.fuelReportedTimeUtc,
      'lifetimeFuel': instance.lifetimeFuel,
      'lastReportedTimeUtc': instance.lastReportedTimeUtc,
      'lastLocationUpdateUtc': instance.lastLocationUpdateUtc,
      'percentDEFRemaining': instance.percentDEFRemaining,
      'lifetimeDEFLiters': instance.lifetimeDEFLiters,
      'lastLifetimeDEFLitersUTC': instance.lastLifetimeDEFLitersUTC,
      'lastPercentDEFRemainingUTC': instance.lastPercentDEFRemainingUTC,
      'devices': instance.devices,
      'activeServicePlans': instance.activeServicePlans,
      'geofences': instance.geofences,
      'groups': instance.groups,
    };

Geofences _$GeofencesFromJson(Map<String, dynamic> json) => Geofences(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GeofencesToJson(Geofences instance) => <String, dynamic>{
      'name': instance.name,
    };

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
    };
