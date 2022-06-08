// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_refine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceRefineData _$MaintenanceRefineDataFromJson(
        Map<String, dynamic> json) =>
    MaintenanceRefineData(
      maintenanceRefine: json['maintenanceRefine'] == null
          ? null
          : MaintenanceRefine.fromJson(
              json['maintenanceRefine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaintenanceRefineDataToJson(
        MaintenanceRefineData instance) =>
    <String, dynamic>{
      'maintenanceRefine': instance.maintenanceRefine,
    };

MaintenanceRefine _$MaintenanceRefineFromJson(Map<String, dynamic> json) =>
    MaintenanceRefine(
      maintenanceRefine: (json['maintenanceRefine'] as List<dynamic>?)
          ?.map(
              (e) => MaintenanceRefineList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaintenanceRefineToJson(MaintenanceRefine instance) =>
    <String, dynamic>{
      'maintenanceRefine': instance.maintenanceRefine,
    };

MaintenanceRefineList _$MaintenanceRefineListFromJson(
        Map<String, dynamic> json) =>
    MaintenanceRefineList(
      typeAlias: json['typeAlias'] as String?,
      typeName: json['typeName'] as String?,
      typeValues: (json['typeValues'] as List<dynamic>?)
          ?.map((e) => TypeValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaintenanceRefineListToJson(
        MaintenanceRefineList instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'typeAlias': instance.typeAlias,
      'typeValues': instance.typeValues,
    };

TypeValues _$TypeValuesFromJson(Map<String, dynamic> json) => TypeValues(
      alias: json['alias'] as String?,
      count: json['count'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TypeValuesToJson(TypeValues instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'alias': instance.alias,
    };
