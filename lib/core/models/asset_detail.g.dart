// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDetail _$AssetDetailFromJson(Map<String, dynamic> json) {
  return AssetDetail(
    json['assetUid'] as String,
    json['assetSerialNumber'] as String,
    json['makeCode'] as String,
    json['manufacturer'] as String,
    (json['devices'] as List)
        ?.map((e) =>
            e == null ? null : Device.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['model'] as String,
    (json['year'] as num)?.toDouble(),
    json['assetIcon'] as int,
    json['productFamily'] as String,
    json['status'] as String,
    json['customStateDescription'] as String,
    json['dealerName'] as String,
    json['dealerCustomerNumber'] as String,
    json['accountName'] as String,
    json['universalCustomerIdentifier'] as String,
    json['universalCustomerName'] as String,
    (json['lastReportedLocationLatitude'] as num)?.toDouble(),
    (json['lastReportedLocationLongitude'] as num)?.toDouble(),
  );
}

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
      'dealerCustomerNumber': instance.dealerCustomerNumber,
      'accountName': instance.accountName,
      'universalCustomerIdentifier': instance.universalCustomerIdentifier,
      'universalCustomerName': instance.universalCustomerName,
      'lastReportedLocationLatitude': instance.lastReportedLocationLatitude,
      'lastReportedLocationLongitude': instance.lastReportedLocationLongitude,
      'devices': instance.devices,
    };
