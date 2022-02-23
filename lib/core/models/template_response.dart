import 'package:json_annotation/json_annotation.dart';
part 'template_response.g.dart';

@JsonSerializable()
class TemplateResponse {
  List<Reports>? reports;

  TemplateResponse({this.reports});

  factory TemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$TemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateResponseToJson(this);
}

@JsonSerializable()
class Reports {
  String? reportTypeId;
  String? reportName;
  String? reportTypeName;
  String? filterOptions;
  String? sourceApplicationID;
  String? sourceAppName;
  String? reportSourcePageName;
  int? birstReportInd;
  String? assetParameter;
  dynamic? defaultColumn;
  String? dateRange;

  Reports(
      {this.reportTypeId,
      this.reportName,
      this.reportTypeName,
      this.filterOptions,
      this.sourceApplicationID,
      this.sourceAppName,
      this.reportSourcePageName,
      this.birstReportInd,
      this.assetParameter,
      this.defaultColumn,
      this.dateRange});

  factory Reports.fromJson(Map<String, dynamic> json) =>
      _$ReportsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsToJson(this);
}
