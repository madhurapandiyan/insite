// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditReportResponse _$EditReportResponseFromJson(Map<String, dynamic> json) =>
    EditReportResponse(
      msg: json['msg'] as String?,
      scheduledReport: json['scheduledReport'] == null
          ? null
          : ScheduledReport.fromJson(
              json['scheduledReport'] as Map<String, dynamic>),
      status: json['status'] as int?,
      reqId: json['reqId'] as String?,
    );

Map<String, dynamic> _$EditReportResponseToJson(EditReportResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'scheduledReport': instance.scheduledReport,
      'status': instance.status,
      'reqId': instance.reqId,
    };

ScheduledReport _$ScheduledReportFromJson(Map<String, dynamic> json) =>
    ScheduledReport(
      reportUid: json['reportUid'] as String?,
      reportFormat: json['reportFormat'] as int?,
      reportPeriod: json['reportPeriod'] as int?,
      reportTitle: json['reportTitle'] as String?,
      reportType: json['reportType'] as String?,
      reportCreationDate: json['reportCreationDate'] as String?,
      emailSubject: json['emailSubject'] as String?,
      emailContent: json['emailContent'] as String?,
      emailRecipients: (json['emailRecipients'] as List<dynamic>?)
          ?.map((e) => EmailRecipients.fromJson(e as Map<String, dynamic>))
          .toList(),
      queryUrl: json['queryUrl'] as String?,
      reportColumns: (json['reportColumns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      link: json['link'] == null
          ? null
          : Link.fromJson(json['link'] as Map<String, dynamic>),
      reportSourcePageName: json['reportSourcePageName'] as String?,
      scheduleEndDate: json['scheduleEndDate'] as String?,
      createdBy: json['createdBy'] as String?,
      reportGenerationCategory: json['reportGenerationCategory'] as int?,
      svcMethod: json['svcMethod'] as String?,
      assetFilterCategoryID: json['assetFilterCategoryID'] as int?,
      allAssets: json['allAssets'] as bool?,
      svcBody:
          (json['svcBody'] as List<dynamic>?)?.map((e) => e as String).toList(),
      assetFilterUIDs: (json['assetFilterUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ScheduledReportToJson(ScheduledReport instance) =>
    <String, dynamic>{
      'reportUid': instance.reportUid,
      'reportFormat': instance.reportFormat,
      'reportPeriod': instance.reportPeriod,
      'reportTitle': instance.reportTitle,
      'reportType': instance.reportType,
      'reportCreationDate': instance.reportCreationDate,
      'emailSubject': instance.emailSubject,
      'emailRecipients': instance.emailRecipients,
      'queryUrl': instance.queryUrl,
      'reportColumns': instance.reportColumns,
      'link': instance.link,
      'reportSourcePageName': instance.reportSourcePageName,
      'scheduleEndDate': instance.scheduleEndDate,
      'createdBy': instance.createdBy,
      'reportGenerationCategory': instance.reportGenerationCategory,
      'svcMethod': instance.svcMethod,
      'assetFilterCategoryID': instance.assetFilterCategoryID,
      'emailContent': instance.emailContent,
      'allAssets': instance.allAssets,
      'svcBody': instance.svcBody,
      'assetFilterUIDs': instance.assetFilterUIDs,
    };

EmailRecipients _$EmailRecipientsFromJson(Map<String, dynamic> json) =>
    EmailRecipients(
      email: json['email'] as String?,
      isVLUser: json['isVLUser'] as bool?,
    );

Map<String, dynamic> _$EmailRecipientsToJson(EmailRecipients instance) =>
    <String, dynamic>{
      'email': instance.email,
      'isVLUser': instance.isVLUser,
    };
