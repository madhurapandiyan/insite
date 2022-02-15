import 'package:json_annotation/json_annotation.dart';
part 'add_report_payload.g.dart';

@JsonSerializable()
class AddReportPayLoad {
  int? assetFilterCategoryID;
  int? reportCategoryID;
  int? reportFormat;
  int? reportPeriod;
  String? reportTitle;
  String? reportScheduledDate;
  String? reportStartDate;
  String? reportEndDate;
  String? emailSubject;
  List<String>? emailRecipients;
  String? svcMethod;
  List<String>? svcbody;
  bool? allAssets;
  // List<Null>? filterOptions;
  // List<Null>? filterTag;
  String? queryUrl;
  String? reportType;
  List<String>? reportColumns;

  AddReportPayLoad(
      {this.assetFilterCategoryID,
      this.reportCategoryID,
      this.reportFormat,
      this.reportPeriod,
      this.reportTitle,
      this.reportScheduledDate,
      this.reportStartDate,
      this.reportEndDate,
      this.emailSubject,
      this.emailRecipients,
      this.svcMethod,
      this.allAssets,
      this.svcbody,
      // this.filterOptions,
      // this.filterTag,
      this.queryUrl,
      this.reportType,
      this.reportColumns});

 factory AddReportPayLoad.fromJson(Map<String, dynamic> json)=>_$AddReportPayLoadFromJson(json);

  Map<String, dynamic> toJson()=>_$AddReportPayLoadToJson(this); 
}