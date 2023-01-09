// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_notification_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageNotificationFilter _$ManageNotificationFilterFromJson(
        Map<String, dynamic> json) =>
    ManageNotificationFilter(
      getAlertConfigsCountData: json['getAlertConfigsCountData'] == null
          ? null
          : GetAlertConfigsCountData.fromJson(
              json['getAlertConfigsCountData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageNotificationFilterToJson(
        ManageNotificationFilter instance) =>
    <String, dynamic>{
      'getAlertConfigsCountData': instance.getAlertConfigsCountData,
    };

GetAlertConfigsCountData _$GetAlertConfigsCountDataFromJson(
        Map<String, dynamic> json) =>
    GetAlertConfigsCountData(
      alertConfigs: (json['alertConfigs'] as List<dynamic>?)
          ?.map((e) => AlertConfigs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAlertConfigsCountDataToJson(
        GetAlertConfigsCountData instance) =>
    <String, dynamic>{
      'alertConfigs': instance.alertConfigs,
    };

AlertConfigs _$AlertConfigsFromJson(Map<String, dynamic> json) => AlertConfigs(
      notificationType: json['notificationType'] as String?,
      notificationTypeGroup: json['notificationTypeGroup'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$AlertConfigsToJson(AlertConfigs instance) =>
    <String, dynamic>{
      'notificationType': instance.notificationType,
      'notificationTypeGroup': instance.notificationTypeGroup,
      'count': instance.count,
    };
