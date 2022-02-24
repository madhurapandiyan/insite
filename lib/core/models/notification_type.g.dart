// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertTypes _$AlertTypesFromJson(Map<String, dynamic> json) => AlertTypes(
      notificationTypeGroups: (json['notificationTypeGroups'] as List<dynamic>?)
          ?.map(
              (e) => NotificationTypeGroups.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlertTypesToJson(AlertTypes instance) =>
    <String, dynamic>{
      'notificationTypeGroups': instance.notificationTypeGroups,
    };

NotificationTypeGroups _$NotificationTypeGroupsFromJson(
        Map<String, dynamic> json) =>
    NotificationTypeGroups(
      notificationTypeGroupID: json['notificationTypeGroupID'] as int?,
      notificationTypeGroupName: json['notificationTypeGroupName'] as String?,
      notificationTypes: (json['notificationTypes'] as List<dynamic>?)
          ?.map((e) => NotificationTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationTypeGroupsToJson(
        NotificationTypeGroups instance) =>
    <String, dynamic>{
      'notificationTypeGroupID': instance.notificationTypeGroupID,
      'notificationTypeGroupName': instance.notificationTypeGroupName,
      'notificationTypes': instance.notificationTypes,
    };

NotificationTypes _$NotificationTypesFromJson(Map<String, dynamic> json) =>
    NotificationTypes(
      notificationTypeID: json['notificationTypeID'] as int?,
      notificationTypeName: json['notificationTypeName'] as String?,
      appName: json['appName'] as String?,
      appURL: json['appURL'] as String?,
      operands: (json['operands'] as List<dynamic>?)
          ?.map((e) => Operands.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool? ?? false,
      siteOperands: (json['siteOperands'] as List<dynamic>?)
          ?.map((e) => SiteOperands.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationTypesToJson(NotificationTypes instance) =>
    <String, dynamic>{
      'notificationTypeID': instance.notificationTypeID,
      'notificationTypeName': instance.notificationTypeName,
      'appName': instance.appName,
      'appURL': instance.appURL,
      'operands': instance.operands,
      'siteOperands': instance.siteOperands,
      'isSelected': instance.isSelected,
    };

Operands _$OperandsFromJson(Map<String, dynamic> json) => Operands(
      operandName: json['operandName'] as String?,
      operandID: json['operandID'] as int?,
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxOccurrence: json['maxOccurrence'] as int?,
      minOccurrence: json['minOccurrence'] as int?,
      operators: (json['operators'] as List<dynamic>?)
          ?.map((e) => Operators.fromJson(e as Map<String, dynamic>))
          .toList(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$OperandsToJson(Operands instance) => <String, dynamic>{
      'operandName': instance.operandName,
      'operandID': instance.operandID,
      'maxValue': instance.maxValue,
      'minValue': instance.minValue,
      'maxOccurrence': instance.maxOccurrence,
      'minOccurrence': instance.minOccurrence,
      'operators': instance.operators,
      'unit': instance.unit,
    };

Operators _$OperatorsFromJson(Map<String, dynamic> json) => Operators(
      operatorID: json['operatorID'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$OperatorsToJson(Operators instance) => <String, dynamic>{
      'operatorID': instance.operatorID,
      'code': instance.code,
      'name': instance.name,
    };

SiteOperands _$SiteOperandsFromJson(Map<String, dynamic> json) => SiteOperands(
      operandName: json['operandName'] as String?,
      operandID: json['operandID'] as int?,
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxOccurrence: json['maxOccurrence'] as int?,
      minOccurrence: json['minOccurrence'] as int?,
      operators: (json['operators'] as List<dynamic>?)
          ?.map((e) => Operators.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SiteOperandsToJson(SiteOperands instance) =>
    <String, dynamic>{
      'operandName': instance.operandName,
      'operandID': instance.operandID,
      'maxValue': instance.maxValue,
      'minValue': instance.minValue,
      'maxOccurrence': instance.maxOccurrence,
      'minOccurrence': instance.minOccurrence,
      'operators': instance.operators,
    };

ZoneValues _$ZoneValuesFromJson(Map<String, dynamic> json) => ZoneValues(
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => Zones.fromJson(e as Map<String, dynamic>))
          .toList(),
      responseStatus: json['responseStatus'] as String?,
    );

Map<String, dynamic> _$ZoneValuesToJson(ZoneValues instance) =>
    <String, dynamic>{
      'zones': instance.zones,
      'responseStatus': instance.responseStatus,
    };

Zones _$ZonesFromJson(Map<String, dynamic> json) => Zones(
      zoneUID: json['zoneUID'] as String?,
      zoneName: json['zoneName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ZonesToJson(Zones instance) => <String, dynamic>{
      'zoneUID': instance.zoneUID,
      'zoneName': instance.zoneName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };

NotificationExist _$NotificationExistFromJson(Map<String, dynamic> json) =>
    NotificationExist(
      alertTitleExists: json['alertTitleExists'] as bool?,
      responseStatus: json['responseStatus'] as String?,
    );

Map<String, dynamic> _$NotificationExistToJson(NotificationExist instance) =>
    <String, dynamic>{
      'alertTitleExists': instance.alertTitleExists,
      'responseStatus': instance.responseStatus,
    };

NotificationAdded _$NotificationAddedFromJson(Map<String, dynamic> json) =>
    NotificationAdded(
      alertUID: json['alertUID'] as String?,
      responseStatus: json['responseStatus'] as String?,
    );

Map<String, dynamic> _$NotificationAddedToJson(NotificationAdded instance) =>
    <String, dynamic>{
      'alertUID': instance.alertUID,
      'responseStatus': instance.responseStatus,
    };
