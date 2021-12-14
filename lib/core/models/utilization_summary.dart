import 'package:json_annotation/json_annotation.dart';

part 'utilization_summary.g.dart';

@JsonSerializable()
class UtilizationSummary {
  UtilizationSummary({
    this.totalDay,
    this.totalWeek,
    this.totalMonth,
    this.averageDay,
    this.averageWeek,
    this.averageMonth,
  });

  AverageDay? totalDay;
  AverageDay? totalWeek;
  AverageDay? totalMonth;
  AverageDay? averageDay;
  AverageDay? averageWeek;
  AverageDay? averageMonth;

  factory UtilizationSummary.fromJson(Map<String, dynamic> json) =>
      _$UtilizationSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$UtilizationSummaryToJson(this);
}

@JsonSerializable()
class AverageDay {
  AverageDay({
    this.idleHours,
    this.runtimeHours,
    this.workingHours,
  });

  double? idleHours;
  double? runtimeHours;
  double? workingHours;

  factory AverageDay.fromJson(Map<String, dynamic> json) =>
      _$AverageDayFromJson(json);

  Map<String, dynamic> toJson() => _$AverageDayToJson(this);
}
