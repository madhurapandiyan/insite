// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCount _$ReportCountFromJson(Map<String, dynamic> json) => ReportCount(
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => CountReportData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportCountToJson(ReportCount instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

CountReportData _$CountReportDataFromJson(Map<String, dynamic> json) =>
    CountReportData(
      groupName: json['groupName'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CountReportDataToJson(CountReportData instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };
