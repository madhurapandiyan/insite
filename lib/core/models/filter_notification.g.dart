// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      notificationStatusInd: json['notificationStatusInd'] as String?,
      countOf: json['countOf'] as int?,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'notificationStatusInd': instance.notificationStatusInd,
      'countOf': instance.countOf,
    };

FilterNotification _$FilterNotificationFromJson(Map<String, dynamic> json) =>
    FilterNotification(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterNotificationToJson(FilterNotification instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };
