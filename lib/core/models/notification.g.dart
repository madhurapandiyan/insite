// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      notificationType: json['notificationType'] as String?,
      notificationSubType: json['notificationSubType'] as String?,
      count: (json['count'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'notificationType': instance.notificationType,
      'notificationSubType': instance.notificationSubType,
      'count': instance.count,
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notification.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'status': instance.status,
    };
