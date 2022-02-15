import 'package:json_annotation/json_annotation.dart';
part 'edit_report_response.g.dart';

@JsonSerializable()
class EditReportResponse {
  String? msg;
  ScheduledReport? scheduledReport;
  int? status;
  String? reqId;

  EditReportResponse({this.msg, this.scheduledReport, this.status, this.reqId});

  factory EditReportResponse.fromJson(Map<String, dynamic> json) =>
      _$EditReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditReportResponseToJson(this);
}

@JsonSerializable()
class ScheduledReport {
  String? reportUid;
  int? reportFormat;
  int? reportPeriod;
  String? reportTitle;
  String? reportType;
  String? reportCreationDate;
  String? emailSubject;
  List<EmailRecipients>? emailRecipients;
  String? queryUrl;
  List<String>? reportColumns;
  Link? link;
  String? reportSourcePageName;
  String? scheduleEndDate;
  String? createdBy;
  int? reportGenerationCategory;
  String? svcMethod;
  int? assetFilterCategoryID;
  String ? emailContent;
  bool? allAssets;

  ScheduledReport({
    this.reportUid,
    this.reportFormat,
    this.reportPeriod,
    this.reportTitle,
    this.reportType,
    this.reportCreationDate,
    this.emailSubject,
    this.emailContent,
    this.emailRecipients,
    this.queryUrl,
    this.reportColumns,
    this.link,
    this.reportSourcePageName,
    this.scheduleEndDate,
    this.createdBy,
    this.reportGenerationCategory,
    this.svcMethod,
    this.assetFilterCategoryID,
    this.allAssets,
  });

  factory ScheduledReport.fromJson(Map<String, dynamic> json) =>
      _$ScheduledReportFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledReportToJson(this);
}

@JsonSerializable()
class EmailRecipients {
  String? email;
  bool? isVLUser;

  EmailRecipients({this.email, this.isVLUser});

  factory EmailRecipients.fromJson(Map<String, dynamic> json) =>
      _$EmailRecipientsFromJson(json);

  Map<String, dynamic> toJson() => _$EmailRecipientsToJson(this);
}

@JsonSerializable()
class Link {
  String? rel;
  String? href;
  String? method;

  Link({this.rel, this.href, this.method});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
