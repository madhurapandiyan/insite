// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_creation_reset_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCreationResetData _$AssetCreationResetDataFromJson(
        Map<String, dynamic> json) =>
    AssetCreationResetData(
      code: json['code'] as String?,
      status: json['status'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetCreationResetDataToJson(
        AssetCreationResetData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      code: json['code'] as int?,
      status: json['status'] as String?,
      GPSDeviceID: json['GPSDeviceID'] as String?,
      VIN: json['VIN'] as String?,
      vin: json['vin'] as String?,
      message: json['message'] as String?,
      Model: json['Model'] as String?,
      HMRValue: (json['HMRValue'] as num?)?.toDouble(),
      AssetCreationDate: json['AssetCreationDate'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'GPSDeviceID': instance.GPSDeviceID,
      'VIN': instance.VIN,
      'vin': instance.vin,
      'message': instance.message,
      'Model': instance.Model,
      'HMRValue': instance.HMRValue,
      'AssetCreationDate': instance.AssetCreationDate,
    };
