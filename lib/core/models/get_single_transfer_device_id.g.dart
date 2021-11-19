// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_single_transfer_device_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleTransferDeviceId _$SingleTransferDeviceIdFromJson(
    Map<String, dynamic> json) {
  return SingleTransferDeviceId(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleTransferDeviceIdToJson(
        SingleTransferDeviceId instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    gPSDeviceID: json['GPSDeviceID'] as String,
    vIN: json['VIN'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'GPSDeviceID': instance.gPSDeviceID,
      'VIN': instance.vIN,
    };
