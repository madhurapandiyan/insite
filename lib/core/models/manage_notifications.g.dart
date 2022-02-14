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
      'configuredAlerts': instance.configuredAlerts,
      'links': instance.links,
      'total': instance.total,
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
          ?.map((e) => Operand.fromJson(e as Map<String, dynamic>))
          .toList(),
      siteOperands: (json['siteOperands'] as List<dynamic>?)
          ?.map((e) => SiteOperand.fromJson(e as Map<String, dynamic>))
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
      'alertGroupID': instance.alertGroupID,
      'operands': instance.operands,
      'siteOperands': instance.siteOperands,
    };

Operand _$OperandFromJson(Map<String, dynamic> json) => Operand(
      operandID: json['operandID'] as int?,
      operandName: json['operandName'] as String?,
      operatorID: json['operatorID'] as int?,
      condition: json['condition'] as String?,
      value: json['value'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$OperandToJson(Operand instance) => <String, dynamic>{
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
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SiteOperandToJson(SiteOperand instance) =>
    <String, dynamic>{
      'operandID': instance.operandID,
      'operandName': instance.operandName,
      'geoFenceID': instance.geoFenceID,
      'geoFenceUID': instance.geoFenceUID,
      'name': instance.name,
    };
