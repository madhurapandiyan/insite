import 'package:json_annotation/json_annotation.dart';
part 'asset_utilization.g.dart';

@JsonSerializable()
class AssetUtilization {
  final Hours totalDay;
  final Hours totalWeek;
  final Hours totalMonth;
  final Hours averageDay;
  final Hours averageWeek;
  final Hours averageMonth;

  AssetUtilization(this.totalDay, this.totalWeek, this.totalMonth,
      this.averageWeek, this.averageMonth, this.averageDay);

  factory AssetUtilization.fromJson(Map<String, dynamic> json) =>
      _$AssetUtilizationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetUtilizationToJson(this);
}

@JsonSerializable()
class Hours {
  Hours(
    this.idleHours,
    this.runtimeHours,
    this.workingHours,
  );

  final double idleHours;
  final double runtimeHours;
  final double workingHours;

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}
