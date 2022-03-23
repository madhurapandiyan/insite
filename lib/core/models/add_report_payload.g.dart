// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_report_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReportPayLoad _$AddReportPayLoadFromJson(Map<String, dynamic> json) =>
    AddReportPayLoad(
      assetFilterCategoryID: json['assetFilterCategoryID'] as int?,
      reportCategoryID: json['reportCategoryID'] as int?,
      reportFormat: json['reportFormat'] as int?,
      reportPeriod: json['reportPeriod'] as int?,
      reportTitle: json['reportTitle'] as String?,
      reportScheduledDate: json['reportScheduledDate'] as String?,
      reportStartDate: json['reportStartDate'] as String?,
      reportEndDate: json['reportEndDate'] as String?,
      emailSubject: json['emailSubject'] as String?,
      emailRecipients: (json['emailRecipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      svcMethod: json['svcMethod'] as String?,
      allAssets: json['allAssets'] as bool?,
      svcbody: json['svcbody'],
      queryUrl: json['queryUrl'] as String?,
      emailContent: json['emailContent'] as String?,
      reportType: json['reportType'] as String?,
      reportColumns: (json['reportColumns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AddReportPayLoadToJson(AddReportPayLoad instance) =>
    <String, dynamic>{
      'assetFilterCategoryID': instance.assetFilterCategoryID,
      'reportCategoryID': instance.reportCategoryID,
      'reportFormat': instance.reportFormat,
      'reportPeriod': instance.reportPeriod,
      'reportTitle': instance.reportTitle,
      'reportScheduledDate': instance.reportScheduledDate,
      'reportStartDate': instance.reportStartDate,
      'reportEndDate': instance.reportEndDate,
      'emailSubject': instance.emailSubject,
      'emailRecipients': instance.emailRecipients,
      'svcMethod': instance.svcMethod,
      'svcbody': instance.svcbody,
      'allAssets': instance.allAssets,
      'emailContent': instance.emailContent,
      'queryUrl': instance.queryUrl,
      'reportType': instance.reportType,
      'reportColumns': instance.reportColumns,
    };
