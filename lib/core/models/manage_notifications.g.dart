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
          ?.map((e) => Operands.fromJson(e as Map<String, dynamic>))
          .toList(),
      siteOperands: (json['siteOperands'] as List<dynamic>?)
          ?.map((e) => SiteOperands.fromJson(e as Map<String, dynamic>))
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

Operands _$OperandsFromJson(Map<String, dynamic> json) => Operands(
      operandID: json['operandID'] as int?,
      operandName: json['operandName'] as String?,
      operatorID: json['operatorID'] as int?,
      condition: json['condition'] as String?,
      value: json['value'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$OperandsToJson(Operands instance) => <String, dynamic>{
      'operandID': instance.operandID,
      'operandName': instance.operandName,
      'operatorID': instance.operatorID,
      'condition': instance.condition,
      'value': instance.value,
      'unit': instance.unit,
    };

SiteOperands _$SiteOperandsFromJson(Map<String, dynamic> json) => SiteOperands(
      operandID: json['operandID'] as int?,
      operandName: json['operandName'] as String?,
      geoFenceID: json['geoFenceID'] as int?,
      geoFenceUID: json['geoFenceUID'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SiteOperandsToJson(SiteOperands instance) =>
    <String, dynamic>{
      'operandID': instance.operandID,
      'operandName': instance.operandName,
      'geoFenceID': instance.geoFenceID,
      'geoFenceUID': instance.geoFenceUID,
      'name': instance.name,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      prev: json['prev'] as String?,
      next: json['next'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'prev': instance.prev,
      'next': instance.next,
      'last': instance.last,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      items: json['items'] as int?,
      pages: json['pages'] as int?,
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'items': instance.items,
      'pages': instance.pages,
    };
