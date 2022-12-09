// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_replacement_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDeviceFleetList _$SubscriptionDeviceFleetListFromJson(
        Map<String, dynamic> json) =>
    SubscriptionDeviceFleetList(
      count: json['count'] as int?,
      provisioningInfo: (json['provisioningInfo'] as List<dynamic>?)
          ?.map((e) => ProvisioningInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$SubscriptionDeviceFleetListToJson(
        SubscriptionDeviceFleetList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'provisioningInfo': instance.provisioningInfo,
      'sTypename': instance.sTypename,
    };

ProvisioningInfo _$ProvisioningInfoFromJson(Map<String, dynamic> json) =>
    ProvisioningInfo(
      vin: json['vin'] as String?,
      gpsDeviceID: json['gpsDeviceID'] as String?,
      model: json['model'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$ProvisioningInfoToJson(ProvisioningInfo instance) =>
    <String, dynamic>{
      'vin': instance.vin,
      'gpsDeviceID': instance.gpsDeviceID,
      'model': instance.model,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'sTypename': instance.sTypename,
    };
