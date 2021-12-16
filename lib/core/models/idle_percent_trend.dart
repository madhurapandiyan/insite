import 'package:json_annotation/json_annotation.dart';

part 'idle_percent_trend.g.dart';

@JsonSerializable()
class IdlePercentTrend {
  IdlePercentTrend({
    this.cumulatives,
    this.intervals,
    this.pagination,
    this.code,
    this.message,
  });

  Cumulatives? cumulatives;
  List<Interval>? intervals;
  Pagination? pagination;
  int? code;
  String? message;

  factory IdlePercentTrend.fromJson(Map<String, dynamic> json) =>
      _$IdlePercentTrendFromJson(json);

  Map<String, dynamic> toJson() => _$IdlePercentTrendToJson(this);
}

@JsonSerializable()
class Cumulatives {
  Cumulatives({
    this.cumulativeIdlePercent,
    this.averageIdlePercent,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  double? cumulativeIdlePercent;
  double? averageIdlePercent;
  String? description;
  DateTime? startDateLocalTime;
  DateTime? endDateLocalTime;
  int? totalAssetCount;
  int? totalDayCount;
  String? intervalType;

  factory Cumulatives.fromJson(Map<String, dynamic> json) =>
      _$CumulativesFromJson(json);

  Map<String, dynamic> toJson() => _$CumulativesToJson(this);
}

@JsonSerializable()
class Interval {
  Interval({
    this.idlePercentage,
    this.idleHours,
    this.description,
    this.intervalStartDateLocalTime,
    this.intervalEndDateLocalTime,
    this.totalAssetCount,
    this.dayCount,
  });

  double? idlePercentage;
  double? idleHours;
  String? description;
  DateTime? intervalStartDateLocalTime;
  DateTime? intervalEndDateLocalTime;
  int? totalAssetCount;
  int? dayCount;

  factory Interval.fromJson(Map<String, dynamic> json) =>
      _$IntervalFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalToJson(this);
}

@JsonSerializable()
class Pagination {
  Pagination({
    this.totalCount,
  });

  int? totalCount;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
