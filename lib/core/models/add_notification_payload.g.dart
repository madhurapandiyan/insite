// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationPayLoad _$AddNotificationPayLoadFromJson(
        Map<String, dynamic> json) =>
    AddNotificationPayLoad(
      alertCategoryID: json['alertCategoryID'] as int?,
      notificationUid: json['notificationUid'] as String?,
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
      assetGroupUIDs: (json['assetGroupUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      geofenceUIDs: (json['geofenceUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      siteOperands: (json['siteOperands'] as List<dynamic>?)
          ?.map((e) => SitOperands.fromJson(e as Map<String, dynamic>))
          .toList(),
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => ZonePayload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddNotificationPayLoadToJson(
    AddNotificationPayLoad instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('alertCategoryID', instance.alertCategoryID);
  writeNotNull('notificationUid', instance.notificationUid);
  writeNotNull('assetUIDs', instance.assetUIDs);
  writeNotNull(
      'notificationSubscribers', instance.notificationSubscribers?.toJson());
  writeNotNull('allAssets', instance.allAssets);
  writeNotNull('currentDate', instance.currentDate);
  writeNotNull('schedule', instance.schedule?.map((e) => e.toJson()).toList());
  writeNotNull('alertTitle', instance.alertTitle);
  writeNotNull('alertGroupId', instance.alertGroupId);
  writeNotNull('notificationTypeGroupID', instance.notificationTypeGroupID);
  writeNotNull('operands', instance.operands?.map((e) => e.toJson()).toList());
  writeNotNull('notificationTypeId', instance.notificationTypeId);
  writeNotNull('numberOfOccurences', instance.numberOfOccurences);
  writeNotNull(
      'notificationDeliveryChannel', instance.notificationDeliveryChannel);
  writeNotNull(
      'siteOperands', instance.siteOperands?.map((e) => e.toJson()).toList());
  writeNotNull('geofenceUIDs', instance.geofenceUIDs);
  writeNotNull('assetGroupUIDs', instance.assetGroupUIDs);
  writeNotNull('zones', instance.zones?.map((e) => e.toJson()).toList());
  return val;
}

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

ZonePayload _$ZonePayloadFromJson(Map<String, dynamic> json) => ZonePayload(
      isInclusion: json['isInclusion'] as bool?,
      zoneUID: json['zoneUID'] as String?,
    );

Map<String, dynamic> _$ZonePayloadToJson(ZonePayload instance) =>
    <String, dynamic>{
      'isInclusion': instance.isInclusion,
      'zoneUID': instance.zoneUID,
    };

SitOperands _$SitOperandsFromJson(Map<String, dynamic> json) => SitOperands(
      operandID: json['operandID'] as int?,
      siteUID: json['siteUID'] as String?,
    );

Map<String, dynamic> _$SitOperandsToJson(SitOperands instance) =>
    <String, dynamic>{
      'operandID': instance.operandID,
      'siteUID': instance.siteUID,
    };
