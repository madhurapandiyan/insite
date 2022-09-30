// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_replacement_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalDeviceReplacementStatusModel _$TotalDeviceReplacementStatusModelFromJson(
        Map<String, dynamic> json) =>
    TotalDeviceReplacementStatusModel(
      code: json['code'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => DeviceReplacementStatusModel.fromJson(
                  e as Map<String, dynamic>))
              .toList())
          .toList(),
      status: json['status'] as String?,
      replacementHistory: (json['replacementHistory'] as List<dynamic>?)
          ?.map((e) => ReplacementHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalDeviceReplacementStatusModelToJson(
        TotalDeviceReplacementStatusModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'replacementHistory': instance.replacementHistory,
      'result': instance.result,
    };

DeviceReplacementStatusModel _$DeviceReplacementStatusModelFromJson(
        Map<String, dynamic> json) =>
    DeviceReplacementStatusModel(
      count: json['count'] as int?,
      oldDeviceId: json['OldDeviceId'] as String?,
      newDeviceId: json['NewDeviceId'] as String?,
      reason: json['Reason'] as String?,
      vin: json['VIN'] as String?,
      insertUtc: json['InsertUTC'] as String?,
      emailId: json['EmailID'] as String?,
      description: json['Description'] as String?,
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
      state: json['State'] as String?,
    );

Map<String, dynamic> _$DeviceReplacementStatusModelToJson(
        DeviceReplacementStatusModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'OldDeviceId': instance.oldDeviceId,
      'NewDeviceId': instance.newDeviceId,
      'Reason': instance.reason,
      'VIN': instance.vin,
      'InsertUTC': instance.insertUtc,
      'EmailID': instance.emailId,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'State': instance.state,
      'Description': instance.description,
    };

ReplacementHistory _$ReplacementHistoryFromJson(Map<String, dynamic> json) =>
    ReplacementHistory(
      oldDeviceId: json['oldDeviceId'] as String?,
      newDeviceId: json['newDeviceId'] as String?,
      reason: json['reason'] as String?,
      vin: json['vin'] as String?,
      insertUtc: json['insertUTC'] as String?,
      emailId: json['emailID'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      state: json['state'] as String?,
      description: json['description'] as String?,
      sTypename: json['__typename'] as String?,
      count: json['count'] as String?,
    );

Map<String, dynamic> _$ReplacementHistoryToJson(ReplacementHistory instance) =>
    <String, dynamic>{
      'oldDeviceId': instance.oldDeviceId,
      'newDeviceId': instance.newDeviceId,
      'reason': instance.reason,
      'vin': instance.vin,
      'insertUTC': instance.insertUtc,
      'emailID': instance.emailId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'state': instance.state,
      'description': instance.description,
      '__typename': instance.sTypename,
      'count': instance.count,
    };
