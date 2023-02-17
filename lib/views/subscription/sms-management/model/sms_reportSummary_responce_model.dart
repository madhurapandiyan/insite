import 'package:json_annotation/json_annotation.dart';
part 'sms_reportSummary_responce_model.g.dart';

@JsonSerializable()
class SmsReportSummaryModel {
  final String? code;
  final String? status;
  List<GetSmsSummaryReport>? getSMSSummaryReport;
  final List<List<ReportSummaryModel>>? result;

  SmsReportSummaryModel(
      {this.code, this.status, this.result, this.getSMSSummaryReport});
  factory SmsReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SmsReportSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmsReportSummaryModelToJson(this);
}

@JsonSerializable()
class ReportSummaryModel {
  final int? count;
  @JsonKey(name: "ID")
  final int? id;
  @JsonKey(name: "GPSDeviceID")
  final String? gpsDeviceId;
  @JsonKey(name: "SerialNumber")
  final String? serialNumber;
  @JsonKey(name: "Name")
  final String? name;
  @JsonKey(name: "Number")
  final String? number;
  @JsonKey(name: "StartDate")
  final String? startDate;
  @JsonKey(name: "Language")
  final String? language;
  bool? isSelected;

  ReportSummaryModel(
      {this.count,
      this.id,
      this.gpsDeviceId,
      this.serialNumber,
      this.name,
      this.number,
      this.startDate,
      this.isSelected = false,
      this.language});

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSummaryModelToJson(this);
}

@JsonSerializable()
class GetSmsSummaryReport {
   int? id;
   String? gpsDeviceId;
   String? serialNumber;
   String? name;
   String? number;
   String? startDate;
   String? language;

  GetSmsSummaryReport(
      {this.id,
      this.gpsDeviceId,
      this.serialNumber,
      this.name,
      this.number,
      this.startDate,
      this.language});

   factory GetSmsSummaryReport.fromJson(Map<String, dynamic> json) =>
      _$GetSmsSummaryReportFromJson(json);

  Map<String, dynamic> toJson() => _$GetSmsSummaryReportToJson(this);
}