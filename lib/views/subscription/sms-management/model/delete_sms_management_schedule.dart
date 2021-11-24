import 'package:json_annotation/json_annotation.dart';
part 'delete_sms_management_schedule.g.dart';

@JsonSerializable()
class DeleteSmsReport {
  final int ID;
  DeleteSmsReport({this.ID});
  factory DeleteSmsReport.fromJson(Map<String, dynamic> json) =>
      _$DeleteSmsReportFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteSmsReportToJson(this);
}
