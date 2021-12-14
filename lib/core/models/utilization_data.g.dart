// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilization_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilizationData _$UtilizationDataFromJson(Map<String, dynamic> json) =>
    UtilizationData(
      date: json['date'] as String?,
      lastReportedTime: json['lastReportedTime'] as String?,
      targetRuntimePerformance:
          (json['targetRuntimePerformance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UtilizationDataToJson(UtilizationData instance) =>
    <String, dynamic>{
      'lastReportedTime': instance.lastReportedTime,
      'date': instance.date,
      'targetRuntimePerformance': instance.targetRuntimePerformance,
    };

UtilizationSummaryResponse _$UtilizationSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    UtilizationSummaryResponse(
      utilization: (json['utilization'] as List<dynamic>?)
          ?.map((e) => AssetResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UtilizationSummaryResponseToJson(
        UtilizationSummaryResponse instance) =>
    <String, dynamic>{
      'utilization': instance.utilization,
    };
