import 'package:json_annotation/json_annotation.dart';
part 'sms_reportSummary_responce_model.g.dart';

@JsonSerializable()
class SmsReportSummaryModel {
  final String? code;
  final String? status;
  final List<List<ReportSummaryModel>>? result;

  SmsReportSummaryModel({this.code, this.status, this.result});
  factory SmsReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SmsReportSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmsReportSummaryModelToJson(this);
}

@JsonSerializable()
class ReportSummaryModel {
  final int? count;
  final int? ID;
  final String? GPSDeviceID;
  final String? SerialNumber;
  final String? Name;
  final String? Number;
  final String? StartDate;
  final String? Language;
  bool? isSelected;

  ReportSummaryModel(
      {this.count,
      this.ID,
      this.GPSDeviceID,
      this.SerialNumber,
      this.Name,
      this.Number,
      this.StartDate,
      this.isSelected=false,
      this.Language});

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSummaryModelToJson(this);
}
