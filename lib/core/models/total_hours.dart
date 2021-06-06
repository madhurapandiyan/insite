import 'package:json_annotation/json_annotation.dart';

part 'total_hours.g.dart';

@JsonSerializable()
class TotalHours {
  TotalHours({
    this.cumulatives,
    this.intervals,
    this.pagination,
    this.code,
    this.message,
  });

  Cumulatives cumulatives;
  List<Interval> intervals;
  Pagination pagination;
  int code;
  String message;

  factory TotalHours.fromJson(Map<String, dynamic> json) =>
      _$TotalHoursFromJson(json);

  Map<String, dynamic> toJson() => _$TotalHoursToJson(this);
}

@JsonSerializable()
class Cumulatives {
  Cumulatives({
    this.cumulativeHours,
    this.averageHours,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  double cumulativeHours;
  double averageHours;
  String description;
  DateTime startDateLocalTime;
  DateTime endDateLocalTime;
  int totalAssetCount;
  int totalDayCount;
  String intervalType;

  factory Cumulatives.fromJson(Map<String, dynamic> json) =>
      _$CumulativesFromJson(json);

  Map<String, dynamic> toJson() => _$CumulativesToJson(this);
}

@JsonSerializable()
class Interval {
  Interval({
    this.totalHours,
    this.averageHours,
    this.totals,
    this.description,
    this.intervalStartDateLocalTime,
    this.intervalEndDateLocalTime,
    this.totalAssetCount,
    this.dayCount,
  });

  double totalHours;
  double averageHours;
  Totals totals;
  String description;
  DateTime intervalStartDateLocalTime;
  DateTime intervalEndDateLocalTime;
  int totalAssetCount;
  int dayCount;

  factory Interval.fromJson(Map<String, dynamic> json) =>
      _$IntervalFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalToJson(this);
}

@JsonSerializable()
class Totals {
  Totals({
    this.idleHours,
    this.workingHours,
    this.runtimeHours,
  });

  double idleHours;
  double workingHours;
  double runtimeHours;

  factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsToJson(this);
}

@JsonSerializable()
class Pagination {
  Pagination({
    this.totalCount,
  });

  int totalCount;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
