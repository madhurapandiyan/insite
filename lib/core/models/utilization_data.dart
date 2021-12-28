import 'package:insite/core/models/utilization.dart';
import 'package:json_annotation/json_annotation.dart';
part 'utilization_data.g.dart';

@JsonSerializable()
class UtilizationData {
  final String? lastReportedTime;
  final String? date;
  final double? targetRuntimePerformance;
  UtilizationData(
      {this.date, this.lastReportedTime, this.targetRuntimePerformance});
  factory UtilizationData.fromJson(Map<String, dynamic> json) =>
      _$UtilizationDataFromJson(json);

  Map<String, dynamic> toJson() => _$UtilizationDataToJson(this);
}

@JsonSerializable()
class UtilizationSummaryResponse {
  final List<AssetResult>? utilization;
  UtilizationSummaryResponse({this.utilization});
  factory UtilizationSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$UtilizationSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UtilizationSummaryResponseToJson(this);
}
