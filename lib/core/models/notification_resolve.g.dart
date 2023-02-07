// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_resolve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationStatus _$NotificationStatusFromJson(Map<String, dynamic> json) =>
    NotificationStatus(
      successCount: json['successCount'] as int?,
      failureCount: json['failureCount'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$NotificationStatusToJson(NotificationStatus instance) =>
    <String, dynamic>{
      'successCount': instance.successCount,
      'failureCount': instance.failureCount,
      'status': instance.status,
    };
