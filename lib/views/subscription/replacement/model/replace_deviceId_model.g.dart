// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_deviceId_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplaceDeviceModel _$ReplaceDeviceModelFromJson(Map<String, dynamic> json) =>
    ReplaceDeviceModel(
      code: json['code'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ReplaceDeviceModelToJson(ReplaceDeviceModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      GPSDeviceID: json['GPSDeviceID'] as String?,
      VIN: json['VIN'] as String?,
      Model: json['Model'] as String?,
      SubscriptionStartDate: json['SubscriptionStartDate'] as String?,
      SubscriptionEndDate: json['SubscriptionEndDate'] as String?,
      count: json['count'] as int?,
      NetworkProvider: json['NetworkProvider'] as String?,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'GPSDeviceID': instance.GPSDeviceID,
      'VIN': instance.VIN,
      'Model': instance.Model,
      'SubscriptionStartDate': instance.SubscriptionStartDate,
      'SubscriptionEndDate': instance.SubscriptionEndDate,
      'NetworkProvider': instance.NetworkProvider,
    };
