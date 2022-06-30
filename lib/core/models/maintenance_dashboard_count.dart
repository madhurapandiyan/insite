import 'package:insite/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'maintenance_dashboard_count.g.dart';

@JsonSerializable()
class MaintenanceDashboardCount {
  final MaintenanceDashboard? maintenanceDashboard;

  MaintenanceDashboardCount({this.maintenanceDashboard});

  factory MaintenanceDashboardCount.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceDashboardCountFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceDashboardCountToJson(this);
}

@JsonSerializable()
class MaintenanceDashboard {
  final String? status;
  final List<DashboardData>? dashboardData;
  MaintenanceDashboard({this.dashboardData, this.status});
  factory MaintenanceDashboard.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceDashboardToJson(this);
}

@JsonSerializable()
class DashboardData {
  final String? displayName;
  final int? count;
  final String? alias;
  final List<DashboardData>? subCount;
  @JsonKey(ignore: true)
  MAINTENANCETOTAL? maintenanceTotal;
  DashboardData(
      {this.alias,
      this.count,
      this.displayName,
      this.subCount,
      this.maintenanceTotal});
  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
