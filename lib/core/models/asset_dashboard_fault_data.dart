import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:json_annotation/json_annotation.dart';
part 'asset_dashboard_fault_data.g.dart';

@JsonSerializable()
class AssetDashboardFaultData {
  final List<FaultSummaryData>? summaryData;
  AssetDashboardFaultData({this.summaryData});
  factory AssetDashboardFaultData.fromJson(Map<String, dynamic> json) =>
      _$AssetDashboardFaultDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDashboardFaultDataToJson(this);
}

@JsonSerializable()
class FaultSummaryData {
  List<Count>? countData;
  FaultSummaryData({this.countData});
  factory FaultSummaryData.fromJson(Map<String, dynamic> json) =>
      _$FaultSummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$FaultSummaryDataToJson(this);
}
