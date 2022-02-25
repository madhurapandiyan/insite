// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_config_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertConfigEdit _$AlertConfigEditFromJson(Map<String, dynamic> json) =>
    AlertConfigEdit(
      alertConfig: json['alertConfig'] == null
          ? null
          : ConfiguredAlerts.fromJson(
              json['alertConfig'] as Map<String, dynamic>),
      responseStatus: json['responseStatus'] as String?,
    );

Map<String, dynamic> _$AlertConfigEditToJson(AlertConfigEdit instance) =>
    <String, dynamic>{
      'alertConfig': instance.alertConfig?.toJson(),
      'responseStatus': instance.responseStatus,
    };

Assets _$AssetsFromJson(Map<String, dynamic> json) => Assets(
      assetID: json['assetID'] as int?,
      assetUID: json['assetUID'] as String?,
      assetName: json['assetName'] as String?,
    );

Map<String, dynamic> _$AssetsToJson(Assets instance) => <String, dynamic>{
      'assetID': instance.assetID,
      'assetUID': instance.assetUID,
      'assetName': instance.assetName,
    };

ScheduleDetails _$ScheduleDetailsFromJson(Map<String, dynamic> json) =>
    ScheduleDetails(
      alertConfigScheduleDtlID: json['alertConfigScheduleDtlID'] as int?,
      scheduleDayNum: json['scheduleDayNum'] as int?,
      scheduleStartTime: json['scheduleStartTime'] as String?,
      scheduleEndTime: json['scheduleEndTime'] as String?,
    );

Map<String, dynamic> _$ScheduleDetailsToJson(ScheduleDetails instance) =>
    <String, dynamic>{
      'alertConfigScheduleDtlID': instance.alertConfigScheduleDtlID,
      'scheduleDayNum': instance.scheduleDayNum,
      'scheduleStartTime': instance.scheduleStartTime,
      'scheduleEndTime': instance.scheduleEndTime,
    };

DeliveryConfig _$DeliveryConfigFromJson(Map<String, dynamic> json) =>
    DeliveryConfig(
      deliveryConfigID: json['deliveryConfigID'] as int?,
      deliveryModeInd: json['deliveryModeInd'] as int?,
      recipientStr: json['recipientStr'] as String?,
      isVLUser: json['isVLUser'] as bool?,
    );

Map<String, dynamic> _$DeliveryConfigToJson(DeliveryConfig instance) =>
    <String, dynamic>{
      'deliveryConfigID': instance.deliveryConfigID,
      'deliveryModeInd': instance.deliveryModeInd,
      'recipientStr': instance.recipientStr,
      'isVLUser': instance.isVLUser,
    };
