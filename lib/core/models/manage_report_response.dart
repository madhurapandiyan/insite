import 'package:json_annotation/json_annotation.dart';
part 'manage_report_response.g.dart';

@JsonSerializable()
class ManageReportResponse {
  String? msg;
  int? page;
  int? limit;
  int? total;
  List<PageLinks>? pageLinks;
  List<ScheduledReports>? scheduledReports;
  int? status;
  String? reqId;
   Metadata? metadata;

  ManageReportResponse(
      {this.msg,
      this.page,
      this.limit,
      this.total,
      this.pageLinks,
      this.scheduledReports,
      this.status,
      this.reqId,
      this.metadata});

  factory ManageReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageReportResponseToJson(this);
}

@JsonSerializable()
class PageLinks {
  String? rel;
  String? href;
  String? method;

  PageLinks({this.rel, this.href, this.method});

  factory PageLinks.fromJson(Map<String, dynamic> json) =>
      _$PageLinksFromJson(json);
  Map<String, dynamic> toJson() => _$PageLinksToJson(this);
}

@JsonSerializable()
class ScheduledReports {
  String? reportUid;
  int? reportFormat;
  int? reportPeriod;
  String? reportTitle;
  String? reportType;
  String? reportTypeName;
  String? reportCreationDate;
  String? emailSubject;
  List<EmailRecipients>? emailRecipients;
  String? queryUrl;
  List<String>? reportColumns;
  PageLinks? link;
  List<Assets>? assets;
  String? reportSourcePageName;
  String? scheduleEndDate;
  String? createdBy;
  int? reportGenerationCategory;
  String? svcMethod;
  //SvcBody? svcBody;
  int? assetFilterCategoryID;
  bool? allAssets;
  String? emailContent;

  ScheduledReports(
      {this.reportUid,
      this.reportFormat,
      this.reportPeriod,
      this.reportTitle,
      this.reportType,
      this.reportTypeName,
      this.reportCreationDate,
      this.emailSubject,
      this.emailRecipients,
      this.queryUrl,
      this.reportColumns,
      this.link,
      this.assets,
      this.reportSourcePageName,
      this.scheduleEndDate,
      this.createdBy,
      this.reportGenerationCategory,
      this.svcMethod,
      //  this.svcBody,
      this.assetFilterCategoryID,
      this.allAssets,
      this.emailContent});

  factory ScheduledReports.fromJson(Map<String, dynamic> json) =>
      _$ScheduledReportsFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduledReportsToJson(this);
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
class Assets {
  String? serialNumber;

  Assets({this.serialNumber});

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsToJson(this);
}

class ScheduledReportsRow {
  ScheduledReports? scheduledReports;
  bool? isSelected;
  ScheduledReportsRow({this.scheduledReports, this.isSelected = false});
}

@JsonSerializable()
class Metadata {
  String? msg;

  Metadata({this.msg});

 factory Metadata.fromJson(Map<String, dynamic> json)=>_$MetadataFromJson(json); 

  Map<String, dynamic> toJson()=>_$MetadataToJson(this); 
}
