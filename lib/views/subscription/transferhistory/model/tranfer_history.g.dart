// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tranfer_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranferHistory _$TranferHistoryFromJson(Map<String, dynamic> json) =>
    TranferHistory(
      deviceTransfer: (json['deviceTransfer'] as List<dynamic>?)
          ?.map((e) => DeviceTransfer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranferHistoryToJson(TranferHistory instance) =>
    <String, dynamic>{
      'deviceTransfer': instance.deviceTransfer,
    };

DeviceTransfer _$DeviceTransferFromJson(Map<String, dynamic> json) =>
    DeviceTransfer(
      gpsDeviceId: json['gpsDeviceID'] as String?,
      oemName: json['oemName'] as String?,
      status: json['status'] as String?,
      destinationCustomerType: json['destinationCustomerType'] as String?,
      destinationName1: json['destinationName1'] as String?,
      destinationName2: json['destinationName2'] as String?,
      fkAssetId: json['fk_AssetId'] as int?,
      insertUtc: json['insertUTC'] as String?,
      sourceName1: json['sourceName1'] as String?,
      sourceName2: json['sourceName2'] as String?,
      sourceCustomerType: json['sourceCustomerType'] as String?,
      vin: json['vin'] as String?,
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$DeviceTransferToJson(DeviceTransfer instance) =>
    <String, dynamic>{
      'gpsDeviceID': instance.gpsDeviceId,
      'oemName': instance.oemName,
      'status': instance.status,
      'destinationCustomerType': instance.destinationCustomerType,
      'sourceCustomerType': instance.sourceCustomerType,
      'destinationName1': instance.destinationName1,
      'destinationName2': instance.destinationName2,
      'fk_AssetId': instance.fkAssetId,
      'insertUTC': instance.insertUtc,
      'sourceName1': instance.sourceName1,
      'sourceName2': instance.sourceName2,
      'vin': instance.vin,
      'sTypename': instance.sTypename,
    };
