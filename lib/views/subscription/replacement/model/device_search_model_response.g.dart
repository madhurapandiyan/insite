// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_search_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceSearchModelResponse _$DeviceSearchModelResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceSearchModelResponse(
      code: json['code'] as String?,
      status: json['status'] as String?,
      result: json['result'] == null
          ? null
          : DeviceSearchResponce.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceSearchModelResponseToJson(
        DeviceSearchModelResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

DeviceSearchResponce _$DeviceSearchResponceFromJson(
        Map<String, dynamic> json) =>
    DeviceSearchResponce(
      AssetID: json['AssetID'] as int?,
      GPSDeviceID: json['GPSDeviceID'] as String?,
      VIN: json['VIN'] as String?,
      Model: json['Model'] as String?,
      TankCapacity: json['TankCapacity'] as int?,
      S_StartDate: json['S_StartDate'] as String?,
      S_EndDate: json['S_EndDate'] as String?,
    );

Map<String, dynamic> _$DeviceSearchResponceToJson(
        DeviceSearchResponce instance) =>
    <String, dynamic>{
      'AssetID': instance.AssetID,
      'GPSDeviceID': instance.GPSDeviceID,
      'VIN': instance.VIN,
      'Model': instance.Model,
      'TankCapacity': instance.TankCapacity,
      'S_StartDate': instance.S_StartDate,
      'S_EndDate': instance.S_EndDate,
    };
