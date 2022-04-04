// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDetail _$AssetDetailFromJson(Map<String, dynamic> json) => AssetDetail(
      json['assetUid'] as String?,
      json['assetSerialNumber'] as String?,
      (json['hourMeter'] as num?)?.toDouble(),
      json['lifetimeFuel'],
      (json['activeServicePlans'] as List<dynamic>?)
          ?.map((e) => ServicePlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['makeCode'] as String?,
      json['lastReportedLocation'] as String?,
      (json['fuelLevelLastReported'] as num?)?.toDouble(),
      json['lastLocationUpdateUtc'] as String?,
      json['lastLocationUpdateUTC'] as String?,
      json['percentDEFRemaining'],
      (json['lifetimeDEFLiters'] as num?)?.toDouble(),
      json['manufacturer'] as String?,
      (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['model'] as String?,
      json['lastPercentFuelRemainingUTC'] as String?,
      json['lastLifetimeDEFLitersUTC'] as String?,
      json['lastPercentDEFRemainingUTC'] as String?,
      json['fuelReportedTimeUTC'] as String?,
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
    );

Map<String, dynamic> _$AssetDetailToJson(AssetDetail instance) =>
    <String, dynamic>{
      'assetUid': instance.assetUid,
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
      'fuelReportedTimeUTC': instance.fuelReportedTimeUTC,
      'lifetimeFuel': instance.lifetimeFuel,
      'lastLocationUpdateUtc': instance.lastReportedTimeUTC,
      'lastLocationUpdateUTC': instance.lastLocationUpdateUTC,
      'percentDEFRemaining': instance.percentDEFRemaining,
      'lifetimeDEFLiters': instance.lifetimeDEFLiters,
      'lastLifetimeDEFLitersUTC': instance.lastLifetimeDEFLitersUTC,
      'lastPercentDEFRemainingUTC': instance.lastPercentDEFRemainingUTC,
      'devices': instance.devices,
      'activeServicePlans': instance.activeServicePlans,
    };
