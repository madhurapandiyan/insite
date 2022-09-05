import 'package:json_annotation/json_annotation.dart';
part 'add_report_payload.g.dart';

@JsonSerializable(includeIfNull: false)
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

  bool? allAssets;
  String? emailContent;
  // List<Null>? filterOptions;
  // List<Null>? filterTag;
  String? queryUrl;
  String? reportType;
  List<String>? reportColumns;
  List<String>? svcbody;
  List<String>? assetFilterUIDs;
  String? productfamily;
  String? model;
  String? assetstatus;
  String? fuelLevelPercentLT;
  String? idleEfficiencyGT;
  String? idleEfficiencyLTE;
  String? assetIDContains;
  String? snContains;
  String? Latitude;
  String? Longitude;
  String? radiuskm;
  String? manufacturer;
  SvcbodyResponse? svcbodyJson;
  String? reportUid;
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

      // this.filterOptions,
      // this.filterTag,
      this.queryUrl,
      this.emailContent,
      this.reportType,
      this.reportColumns,
      this.Latitude,
      this.Longitude,
      this.assetFilterUIDs,
      this.assetIDContains,
      this.assetstatus,
      this.fuelLevelPercentLT,
      this.idleEfficiencyGT,
      this.idleEfficiencyLTE,
      this.manufacturer,
      this.model,
      this.productfamily,
      this.radiuskm,
      this.snContains,
      this.svcbody,
      this.svcbodyJson,
      //this.svcBody
      this.reportUid});

  factory AddReportPayLoad.fromJson(Map<String, dynamic> json) =>
      _$AddReportPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$AddReportPayLoadToJson(this);
}

@JsonSerializable()
class SvcbodyResponse {
  List<String>? assetuids;
  List<String>? colFilters;
  SvcbodyResponse({this.assetuids, this.colFilters});
  factory SvcbodyResponse.fromJson(Map<String, dynamic> json) =>
      _$SvcbodyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SvcbodyResponseToJson(this);
}
