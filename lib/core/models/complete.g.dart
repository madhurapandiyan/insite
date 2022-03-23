// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complete _$CompleteFromJson(Map<String, dynamic> json) => Complete(
      completionType: json['completionType'] as String?,
      currentIntervalID: json['currentIntervalID'] as num?,
      occurrenceID: json['occurrenceID'] as num?,
      currentIntervalName: json['currentIntervalName'] as String?,
      isHighest: json['isHighest'] as bool?,
      dueInfos: json['dueInfos'] == null
          ? null
          : DueInfos.fromJson(json['dueInfos'] as Map<String, dynamic>),
      rationalizationOptions: (json['rationalizationOptions'] as List<dynamic>?)
          ?.map(
              (e) => RationalizationOptions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompleteToJson(Complete instance) => <String, dynamic>{
      'completionType': instance.completionType,
      'currentIntervalID': instance.currentIntervalID,
      'occurrenceID': instance.occurrenceID,
      'currentIntervalName': instance.currentIntervalName,
      'isHighest': instance.isHighest,
      'dueInfos': instance.dueInfos,
      'rationalizationOptions': instance.rationalizationOptions,
    };

DueInfos _$DueInfosFromJson(Map<String, dynamic> json) => DueInfos(
      dueAt: json['dueAt'] as num?,
      smuType: json['smuType'] as String?,
      completedAt: json['completedAt'] as num?,
      dueIn: json['dueIn'] as num?,
      dueDate: json['dueDate'] as String?,
    );

Map<String, dynamic> _$DueInfosToJson(DueInfos instance) => <String, dynamic>{
      'dueAt': instance.dueAt,
      'smuType': instance.smuType,
      'completedAt': instance.completedAt,
      'dueIn': instance.dueIn,
      'dueDate': instance.dueDate,
    };

RationalizationOptions _$RationalizationOptionsFromJson(
        Map<String, dynamic> json) =>
    RationalizationOptions(
      intervalID: json['intervalID'] as num?,
      intervalName: json['intervalName'] as String?,
      smuType: json['smuType'] as String?,
      minValue: json['minValue'] as num?,
      maxValue: json['maxValue'] as num?,
      minDate: json['minDate'] as String?,
      maxDate: json['maxDate'] as String?,
      resetType: json['resetType'] as String?,
      completedBaseCyclePosition: json['completedBaseCyclePosition'] as String?,
      nextBaseCyclePosition: json['nextBaseCyclePosition'] == null
          ? null
          : NextBaseCyclePosition.fromJson(
              json['nextBaseCyclePosition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RationalizationOptionsToJson(
        RationalizationOptions instance) =>
    <String, dynamic>{
      'intervalID': instance.intervalID,
      'intervalName': instance.intervalName,
      'smuType': instance.smuType,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'minDate': instance.minDate,
      'maxDate': instance.maxDate,
      'resetType': instance.resetType,
      'completedBaseCyclePosition': instance.completedBaseCyclePosition,
      'nextBaseCyclePosition': instance.nextBaseCyclePosition,
    };

NextBaseCyclePosition _$NextBaseCyclePositionFromJson(
        Map<String, dynamic> json) =>
    NextBaseCyclePosition(
      maintenanceIntervalRank: json['maintenanceIntervalRank'] as num?,
      occurrenceRank: json['occurrenceRank'] as num?,
      smuvalue: json['smuvalue'] as num?,
      smuDate: json['smuDate'] as String?,
    );

Map<String, dynamic> _$NextBaseCyclePositionToJson(
        NextBaseCyclePosition instance) =>
    <String, dynamic>{
      'maintenanceIntervalRank': instance.maintenanceIntervalRank,
      'occurrenceRank': instance.occurrenceRank,
      'smuvalue': instance.smuvalue,
      'smuDate': instance.smuDate,
    };
