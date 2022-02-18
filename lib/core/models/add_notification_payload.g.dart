// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationPayLoad _$AddNotificationPayLoadFromJson(
        Map<String, dynamic> json) =>
    AddNotificationPayLoad(
      alertCategoryID: json['alertCategoryID'] as int?,
      assetUIDs: (json['assetUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notificationSubscribers: json['notificationSubscribers'] == null
          ? null
          : NotificationSubscribers.fromJson(
              json['notificationSubscribers'] as Map<String, dynamic>),
      allAssets: json['allAssets'] as bool?,
      currentDate: json['currentDate'] as String?,
      schedule: (json['schedule'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      alertTitle: json['alertTitle'] as String?,
      alertGroupId: json['alertGroupId'] as int?,
      operands: (json['operands'] as List<dynamic>?)
          ?.map((e) => Operand.fromJson(e as Map<String, dynamic>))
          .toList(),
      notificationTypeGroupID: json['notificationTypeGroupID'] as int?,
      notificationTypeId: json['notificationTypeId'] as int?,
      numberOfOccurences: json['numberOfOccurences'] as int?,
      notificationDeliveryChannel:
          json['notificationDeliveryChannel'] as String?,
    );

Map<String, dynamic> _$AddNotificationPayLoadToJson(
        AddNotificationPayLoad instance) =>
    <String, dynamic>{
      'alertCategoryID': instance.alertCategoryID,
      'assetUIDs': instance.assetUIDs,
      'notificationSubscribers': instance.notificationSubscribers,
      'allAssets': instance.allAssets,
      'currentDate': instance.currentDate,
      'schedule': instance.schedule,
      'alertTitle': instance.alertTitle,
      'alertGroupId': instance.alertGroupId,
      'notificationTypeGroupID': instance.notificationTypeGroupID,
      'operands': instance.operands,
      'notificationTypeId': instance.notificationTypeId,
      'numberOfOccurences': instance.numberOfOccurences,
      'notificationDeliveryChannel': instance.notificationDeliveryChannel,
    };

NotificationSubscribers _$NotificationSubscribersFromJson(
        Map<String, dynamic> json) =>
    NotificationSubscribers(
      emailIds: (json['emailIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NotificationSubscribersToJson(
        NotificationSubscribers instance) =>
    <String, dynamic>{
      'emailIds': instance.emailIds,
      'phoneNumbers': instance.phoneNumbers,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      day: json['day'] as int?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'day': instance.day,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

Operand _$OperandFromJson(Map<String, dynamic> json) => Operand(
      operandID: json['operandID'] as int?,
      operatorId: json['operatorId'] as int?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$OperandToJson(Operand instance) => <String, dynamic>{
      'operandID': instance.operandID,
      'operatorId': instance.operatorId,
      'value': instance.value,
    };
