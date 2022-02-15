// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageReportResponse _$ManageReportResponseFromJson(
        Map<String, dynamic> json) =>
    ManageReportResponse(
      msg: json['msg'] as String?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      total: json['total'] as int?,
      pageLinks: (json['pageLinks'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledReports: (json['scheduledReports'] as List<dynamic>?)
          ?.map((e) => ScheduledReports.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      reqId: json['reqId'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageReportResponseToJson(
        ManageReportResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pageLinks': instance.pageLinks,
      'scheduledReports': instance.scheduledReports,
      'status': instance.status,
      'reqId': instance.reqId,
      'metadata': instance.metadata,
    };

ScheduledReports _$ScheduledReportsFromJson(Map<String, dynamic> json) =>
    ScheduledReports(
      reportUid: json['reportUid'] as String?,
      reportFormat: json['reportFormat'] as int?,
      reportPeriod: json['reportPeriod'] as int?,
      reportTitle: json['reportTitle'] as String?,
      reportType: json['reportType'] as String?,
      reportTypeName: json['reportTypeName'] as String?,
      reportCreationDate: json['reportCreationDate'] as String?,
      emailSubject: json['emailSubject'] as String?,
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
      assets: (json['assets'] as List<dynamic>?)
          ?.map((e) => Assets.fromJson(e as Map<String, dynamic>))
          .toList(),
      reportSourcePageName: json['reportSourcePageName'] as String?,
      scheduleEndDate: json['scheduleEndDate'] as String?,
      createdBy: json['createdBy'] as String?,
      reportGenerationCategory: json['reportGenerationCategory'] as int?,
      svcMethod: json['svcMethod'] as String?,
      assetFilterCategoryID: json['assetFilterCategoryID'] as int?,
      allAssets: json['allAssets'] as bool?,
      emailContent: json['emailContent'] as String?,
    );

Map<String, dynamic> _$ScheduledReportsToJson(ScheduledReports instance) =>
    <String, dynamic>{
      'reportUid': instance.reportUid,
      'reportFormat': instance.reportFormat,
      'reportPeriod': instance.reportPeriod,
      'reportTitle': instance.reportTitle,
      'reportType': instance.reportType,
      'reportTypeName': instance.reportTypeName,
      'reportCreationDate': instance.reportCreationDate,
      'emailSubject': instance.emailSubject,
      'emailRecipients': instance.emailRecipients,
      'queryUrl': instance.queryUrl,
      'reportColumns': instance.reportColumns,
      'link': instance.link,
      'assets': instance.assets,
      'reportSourcePageName': instance.reportSourcePageName,
      'scheduleEndDate': instance.scheduleEndDate,
      'createdBy': instance.createdBy,
      'reportGenerationCategory': instance.reportGenerationCategory,
      'svcMethod': instance.svcMethod,
      'assetFilterCategoryID': instance.assetFilterCategoryID,
      'allAssets': instance.allAssets,
      'emailContent': instance.emailContent,
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

Assets _$AssetsFromJson(Map<String, dynamic> json) => Assets(
      serialNumber: json['serialNumber'] as String?,
    );

Map<String, dynamic> _$AssetsToJson(Assets instance) => <String, dynamic>{
      'serialNumber': instance.serialNumber,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'msg': instance.msg,
    };
