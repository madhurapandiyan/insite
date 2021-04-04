// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fleet _$FleetFromJson(Map<String, dynamic> json) {
  return Fleet(
    assetIdentifier: json['assetIdentifier'] as String,
    assetId: json['assetId'] as String,
    assetIcon: json['assetIcon'] as int,
    assetSerialNumber: json['assetSerialNumber'] as String,
    dealerCode: json['dealerCode'] as String,
    dealerCustomerNumber: json['dealerCustomerNumber'] as String,
    dealerCustomerName: json['dealerCustomerName'] as String,
    customStateDescription: json['customStateDescription'] as String,
    dealerName: json['dealerName'] as String,
    hourMeter: (json['hourMeter'] as num)?.toDouble(),
    lastHourMeterUTC: json['lastHourMeterUTC'] as String,
    lastLocationUpdateUTC: json['lastLocationUpdateUTC'] as String,
    lastOdometerUTC: json['lastOdometerUTC'] as String,
    makeCode: json['makeCode'] as String,
    manufacturer: json['manufacturer'] as String,
    model: json['model'] as String,
    odometer: (json['odometer'] as num)?.toDouble(),
    productFamily: json['productFamily'] as String,
    status: json['status'] as String,
    universalCustomerIdentifier: json['universalCustomerIdentifier'] as String,
    universalCustomerName: json['universalCustomerName'] as String,
  );
}

Map<String, dynamic> _$FleetToJson(Fleet instance) => <String, dynamic>{
      'assetIdentifier': instance.assetIdentifier,
      'assetId': instance.assetId,
      'assetSerialNumber': instance.assetSerialNumber,
      'manufacturer': instance.manufacturer,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'assetIcon': instance.assetIcon,
      'productFamily': instance.productFamily,
      'status': instance.status,
      'hourMeter': instance.hourMeter,
      'lastHourMeterUTC': instance.lastHourMeterUTC,
      'lastOdometerUTC': instance.lastOdometerUTC,
      'odometer': instance.odometer,
      'dealerCustomerName': instance.dealerCustomerName,
      'dealerCode': instance.dealerCode,
      'dealerName': instance.dealerName,
      'universalCustomerIdentifier': instance.universalCustomerIdentifier,
      'universalCustomerName': instance.universalCustomerName,
      'dealerCustomerNumber': instance.dealerCustomerNumber,
      'lastLocationUpdateUTC': instance.lastLocationUpdateUTC,
      'customStateDescription': instance.customStateDescription,
    };

FleetSummaryResponse _$FleetSummaryResponseFromJson(Map<String, dynamic> json) {
  return FleetSummaryResponse(
    fleetRecords: (json['fleetRecords'] as List)
        ?.map(
            (e) => e == null ? null : Fleet.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FleetSummaryResponseToJson(
        FleetSummaryResponse instance) =>
    <String, dynamic>{
      'links': instance.links,
      'pagination': instance.pagination,
      'fleetRecords': instance.fleetRecords,
    };
