// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details_per_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailsPerId _$DeviceDetailsPerIdFromJson(Map<String, dynamic> json) =>
    DeviceDetailsPerId(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ResultData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceDetailsPerIdToJson(DeviceDetailsPerId instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      serialNo: json['VIN'] as String?,
      model: json['Model'] as String?,
      CustomerCode: json['CustomerCode'] as String?,
      CustomerName: json['CustomerName'] as String?,
      DealerCode: json['DealerCode'] as String?,
      DealerName: json['DealerName'] as String?,
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'VIN': instance.serialNo,
      'Model': instance.model,
      'CustomerCode': instance.CustomerCode,
      'CustomerName': instance.CustomerName,
      'DealerName': instance.DealerName,
      'DealerCode': instance.DealerCode,
    };
