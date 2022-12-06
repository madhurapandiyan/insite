// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageNotificationsData _$ManageNotificationsDataFromJson(
        Map<String, dynamic> json) =>
    ManageNotificationsData(
      configuredAlerts: (json['configuredAlerts'] as List<dynamic>?)
          ?.map((e) => ConfiguredAlerts.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      responseStatus: json['responseStatus'] as String?,
    );

Map<String, dynamic> _$ManageNotificationsDataToJson(
        ManageNotificationsData instance) =>
    <String, dynamic>{
      'configuredAlerts':
          instance.configuredAlerts?.map((e) => e.toJson()).toList(),
      'links': instance.links?.toJson(),
      'total': instance.total?.toJson(),
      'responseStatus': instance.responseStatus,
    };

ConfiguredAlerts _$ConfiguredAlertsFromJson(Map<String, dynamic> json) =>
    ConfiguredAlerts(
      alertConfigID: json['alertConfigID'] as int?,
      alertConfigUID: json['alertConfigUID'] as String?,
      notificationTitle: json['notificationTitle'] as String?,
      allAssetsInd: json['allAssetsInd'] as bool?,
      notificationTypeGroupID: json['notificationTypeGroupID'] as int?,
      notificationTypeID: json['notificationTypeID'] as int?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      notificationType: json['notificationType'] as String?,
      numberOfAssets: json['numberOfAssets'] as int?,
      numberOfAssetGroups: json['numberOfAssetGroups'] as int?,
      numberOfGeofences: json['numberOfGeofences'] as int?,
      alertCategoryID: json['alertCategoryID'] as int?,
      alertGroupID: json['alertGroupID'] as int?,
      operands: (json['operands'] as List<dynamic>?)
          ?.map((e) => OperandData.fromJson(e as Map<String, dynamic>))
          .toList(),
      siteOperands: (json['siteOperands'] as List<dynamic>?)
          ?.map((e) => SiteOperand.fromJson(e as Map<String, dynamic>))
          .toList(),
      assets: (json['assets'] as List<dynamic>?)
          ?.map((e) => Assets.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryConfig: (json['deliveryConfig'] as List<dynamic>?)
          ?.map((e) => DeliveryConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
          ?.map((e) => ScheduleDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      assetGroups: (json['assetGroups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      geofences: (json['geofences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ConfiguredAlertsToJson(ConfiguredAlerts instance) =>
    <String, dynamic>{
      'alertConfigID': instance.alertConfigID,
      'alertConfigUID': instance.alertConfigUID,
      'notificationTitle': instance.notificationTitle,
      'allAssetsInd': instance.allAssetsInd,
      'notificationTypeGroupID': instance.notificationTypeGroupID,
      'notificationTypeID': instance.notificationTypeID,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'notificationType': instance.notificationType,
      'numberOfAssets': instance.numberOfAssets,
      'numberOfAssetGroups': instance.numberOfAssetGroups,
      'numberOfGeofences': instance.numberOfGeofences,
      'alertCategoryID': instance.alertCategoryID,
      'assetGroups': instance.assetGroups,
      'geofences': instance.geofences,
      'alertGroupID': instance.alertGroupID,
      'operands': instance.operands?.map((e) => e.toJson()).toList(),
      'siteOperands': instance.siteOperands?.map((e) => e.toJson()).toList(),
      'assets': instance.assets?.map((e) => e.toJson()).toList(),
      'scheduleDetails':
          instance.scheduleDetails?.map((e) => e.toJson()).toList(),
      'deliveryConfig':
          instance.deliveryConfig?.map((e) => e.toJson()).toList(),
    };

OperandData _$OperandDataFromJson(Map<String, dynamic> json) => OperandData(
      operandID: json['operandID'] as int?,
      operandName: json['operandName'] as String?,
      operatorID: json['operatorID'] as int?,
      condition: json['condition'] as String?,
      value: json['value'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$OperandDataToJson(OperandData instance) =>
    <String, dynamic>{
      'operandID': instance.operandID,
      'operandName': instance.operandName,
      'operatorID': instance.operatorID,
      'condition': instance.condition,
      'value': instance.value,
      'unit': instance.unit,
    };

SiteOperand _$SiteOperandFromJson(Map<String, dynamic> json) => SiteOperand(
      operandID: json['operandID'] as int?,
      operandName: json['operandName'] as String?,
      geoFenceID: json['geoFenceID'] as int?,
      geoFenceUID: json['geoFenceUID'] as String?,
      condition: json['condition'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SiteOperandToJson(SiteOperand instance) =>
    <String, dynamic>{
      'operandID': instance.operandID,
      'operandName': instance.operandName,
      'geoFenceID': instance.geoFenceID,
      'geoFenceUID': instance.geoFenceUID,
      'name': instance.name,
      'condition': instance.condition,
    };
