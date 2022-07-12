// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_replacement_details_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplacementData _$ReplacementDataFromJson(Map<String, dynamic> json) =>
    ReplacementData(
      replacementHistory: (json['replacementHistory'] as List<dynamic>?)
          ?.map((e) => ReplacementHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplacementDataToJson(ReplacementData instance) =>
    <String, dynamic>{
      'replacementHistory': instance.replacementHistory,
    };

ReplacementHistory _$ReplacementHistoryFromJson(Map<String, dynamic> json) =>
    ReplacementHistory(
      oldDeviceId: json['oldDeviceId'] as String?,
      newDeviceId: json['newDeviceId'] as String?,
      reason: json['reason'] as String?,
      vin: json['vin'] as String?,
      insertUTC: json['insertUTC'] as String?,
      emailID: json['emailID'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      state: json['state'] as String?,
      description: json['description'] as String?,
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$ReplacementHistoryToJson(ReplacementHistory instance) =>
    <String, dynamic>{
      'oldDeviceId': instance.oldDeviceId,
      'newDeviceId': instance.newDeviceId,
      'reason': instance.reason,
      'vin': instance.vin,
      'insertUTC': instance.insertUTC,
      'emailID': instance.emailID,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'state': instance.state,
      'description': instance.description,
      'sTypename': instance.sTypename,
    };
