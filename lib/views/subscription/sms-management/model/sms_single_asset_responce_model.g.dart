// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_single_asset_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetResponce _$SingleAssetResponceFromJson(Map<String, dynamic> json) {
  return SingleAssetResponce(
    code: json['code'] as String,
    status: json['status'] as String,
    result: (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : SingleAssetModelResponce.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleAssetResponceToJson(
        SingleAssetResponce instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

SingleAssetModelResponce _$SingleAssetModelResponceFromJson(
    Map<String, dynamic> json) {
  return SingleAssetModelResponce(
    GPSDeviceID: json['GPSDeviceID'] as String,
    SerialNumber: json['SerialNumber'] as String,
    Model: json['Model'] as String,
    StartDate: json['StartDate'] as String,
  );
}

Map<String, dynamic> _$SingleAssetModelResponceToJson(
        SingleAssetModelResponce instance) =>
    <String, dynamic>{
      'GPSDeviceID': instance.GPSDeviceID,
      'SerialNumber': instance.SerialNumber,
      'Model': instance.Model,
      'StartDate': instance.StartDate,
    };
