// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details_per_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailsPerId _$DeviceDetailsPerIdFromJson(Map<String, dynamic> json) {
  return DeviceDetailsPerId(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : ResultData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeviceDetailsPerIdToJson(DeviceDetailsPerId instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
    serialNo: json['VIN'] as String,
    model: json['Model'] as String,
  );
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'VIN': instance.serialNo,
      'Model': instance.model,
    };