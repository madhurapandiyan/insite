// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_replacement_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalDeviceReplacementStatusModel _$TotalDeviceReplacementStatusModelFromJson(
    Map<String, dynamic> json) {
  return TotalDeviceReplacementStatusModel(
    code: json['code'] as String,
    result: (json['result'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : DeviceReplacementStatusModel.fromJson(
                    e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TotalDeviceReplacementStatusModelToJson(
        TotalDeviceReplacementStatusModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

DeviceReplacementStatusModel _$DeviceReplacementStatusModelFromJson(
    Map<String, dynamic> json) {
  return DeviceReplacementStatusModel(
    count: json['count'] as int,
    OldDeviceId: json['OldDeviceId'] as String,
    NewDeviceId: json['NewDeviceId'] as String,
    Reason: json['Reason'] as String,
    VIN: json['VIN'] as String,
    InsertUTC: json['InsertUTC'] as String,
    EmailID: json['EmailID'] as String,
    Description: json['Description'] as String,
    FirstName: json['FirstName'] as String,
    LastName: json['LastName'] as String,
    State: json['State'] as String,
  );
}

Map<String, dynamic> _$DeviceReplacementStatusModelToJson(
        DeviceReplacementStatusModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'OldDeviceId': instance.OldDeviceId,
      'NewDeviceId': instance.NewDeviceId,
      'Reason': instance.Reason,
      'VIN': instance.VIN,
      'InsertUTC': instance.InsertUTC,
      'EmailID': instance.EmailID,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'State': instance.State,
      'Description': instance.Description,
    };
