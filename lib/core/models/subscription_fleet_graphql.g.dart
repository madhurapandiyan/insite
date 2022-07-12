// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_fleet_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetProvisionStatus _$FleetProvisionStatusFromJson(
        Map<String, dynamic> json) =>
    FleetProvisionStatus(
      count: json['count'] as int?,
      fleetProvisionStatusInfo:
          (json['fleetProvisionStatusInfo'] as List<dynamic>?)
              ?.map((e) =>
                  FleetProvisionStatusInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$FleetProvisionStatusToJson(
        FleetProvisionStatus instance) =>
    <String, dynamic>{
      'count': instance.count,
      'fleetProvisionStatusInfo': instance.fleetProvisionStatusInfo,
      'sTypename': instance.sTypename,
    };

FleetProvisionStatusInfo _$FleetProvisionStatusInfoFromJson(
        Map<String, dynamic> json) =>
    FleetProvisionStatusInfo(
      gpsDeviceID: json['gpsDeviceID'] as String?,
      vin: json['vin'] as String?,
      model: json['model'] as String?,
      oemName: json['oemName'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
      actualStartDate: json['actualStartDate'] as String?,
      subscriptionEndDate: json['subscriptionEndDate'] as String?,
      productFamily: json['productFamily'] as String?,
      customerName: json['customerName'] as String?,
      customerCode: json['customerCode'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCode: json['dealerCode'] as String?,
      commissioningDate: json['commissioningDate'] as String?,
      secondaryIndustry: json['secondaryIndustry'] as String?,
      primaryIndustry: json['primaryIndustry'] as String?,
      networkProvider: json['networkProvider'] as String?,
      status: json['status'] as int?,
      description: json['description'] as String?,
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$FleetProvisionStatusInfoToJson(
        FleetProvisionStatusInfo instance) =>
    <String, dynamic>{
      'gpsDeviceID': instance.gpsDeviceID,
      'vin': instance.vin,
      'model': instance.model,
      'oemName': instance.oemName,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'actualStartDate': instance.actualStartDate,
      'subscriptionEndDate': instance.subscriptionEndDate,
      'productFamily': instance.productFamily,
      'customerName': instance.customerName,
      'customerCode': instance.customerCode,
      'dealerName': instance.dealerName,
      'dealerCode': instance.dealerCode,
      'commissioningDate': instance.commissioningDate,
      'secondaryIndustry': instance.secondaryIndustry,
      'primaryIndustry': instance.primaryIndustry,
      'networkProvider': instance.networkProvider,
      'status': instance.status,
      'description': instance.description,
      'sTypename': instance.sTypename,
    };
