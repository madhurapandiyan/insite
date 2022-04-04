// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsData _$NotificationsDataFromJson(Map<String, dynamic> json) =>
    NotificationsData(
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notification.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$NotificationsDataToJson(NotificationsData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'notifications': instance.notifications,
      'status': instance.status,
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      notificationUID: json['notificationUID'] as String?,
      notificationTitle: json['notificationTitle'] as String?,
      occurUTC: json['occurUTC'] as String?,
      assetUID: json['assetUID'] as String?,
      serialNumber: json['serialNumber'] as String?,
      assetName: json['assetName'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      location: json['location'] as String?,
      iconKey: json['iconKey'] as int?,
      latitude: json['latitude'],
      longitude: json['longitude'],
      notificationType: json['notificationType'] as String?,
      notificationSubType: json['notificationSubType'] as String?,
      notificationConfigJSON: json['notificationConfigJSON'] as String,
      resolvedStatus: json['resolvedStatus'] as String?,
      readStatus: json['readStatus'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'isSelected': instance.isSelected,
      'notificationUID': instance.notificationUID,
      'notificationTitle': instance.notificationTitle,
      'occurUTC': instance.occurUTC,
      'assetUID': instance.assetUID,
      'serialNumber': instance.serialNumber,
      'assetName': instance.assetName,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'location': instance.location,
      'iconKey': instance.iconKey,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notificationType': instance.notificationType,
      'notificationSubType': instance.notificationSubType,
      'notificationConfigJSON': instance.notificationConfigJSON,
      'resolvedStatus': instance.resolvedStatus,
      'readStatus': instance.readStatus,
    };
