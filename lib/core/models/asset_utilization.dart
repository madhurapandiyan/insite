import 'package:json_annotation/json_annotation.dart';
part 'asset_utilization.g.dart';

@JsonSerializable()
class AssetUtilization {
  AssetUtilization({
    this.totalDay,
    this.totalWeek,
    this.totalMonth,
    this.targetDay,
    this.targetWeek,
    this.targetMonth,
    this.code,
    this.message,
  });

  Hours totalDay;
  Hours totalWeek;
  Hours totalMonth;
  Hours targetDay;
  Hours targetWeek;
  Hours targetMonth;
  int code;
  String message;

  factory AssetUtilization.fromJson(Map<String, dynamic> json) =>
      _$AssetUtilizationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetUtilizationToJson(this);
}

@JsonSerializable()
class Hours {
  Hours({
    this.idleHours,
    this.runtimeHours,
    this.workingHours,
    this.idleFuel,
    this.runtimeFuel,
    this.workingFuel,
  });

  double idleHours;
  double runtimeHours;
  double workingHours;
  double idleFuel;
  double runtimeFuel;
  double workingFuel;

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}
