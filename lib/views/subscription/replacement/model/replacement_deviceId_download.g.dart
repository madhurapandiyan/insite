// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replacement_deviceId_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplacementDeviceIdDownload _$ReplacementDeviceIdDownloadFromJson(
    Map<String, dynamic> json) {
  return ReplacementDeviceIdDownload(
    code: json['code'] as String,
    status: json['status'] as String,
    result: (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : DeviceReplacementStatusModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReplacementDeviceIdDownloadToJson(
        ReplacementDeviceIdDownload instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };
