import 'package:json_annotation/json_annotation.dart';
part 'sms_smmary.g.dart';

@JsonSerializable()
class SmsSummaryModel {
  List<GetSMSSummaryReport>? getSMSSummaryReport;
  SmsSummaryModel({this.getSMSSummaryReport});

  factory SmsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SmsSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmsSummaryModelToJson(this);
}

@JsonSerializable()
class GetSMSSummaryReport {
   int? id;
   String? gpsDeviceId;
   String? serialNumber;
   String? name;
   String? number;
   String? startDate;
   String? language;

  GetSMSSummaryReport(
      {this.id,
      this.gpsDeviceId,
      this.serialNumber,
      this.name,
      this.number,
      this.startDate,
      this.language});

  factory GetSMSSummaryReport.fromJson(Map<String, dynamic> json) =>
      _$GetSMSSummaryReportFromJson(json);

  Map<String, dynamic> toJson() => _$GetSMSSummaryReportToJson(this);
}
