import 'package:json_annotation/json_annotation.dart';

part 'total_fuel_burned.g.dart';

@JsonSerializable()
class TotalFuelBurned {
  TotalFuelBurned({
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

  factory TotalFuelBurned.fromJson(Map<String, dynamic> json) =>
      _$TotalFuelBurnedFromJson(json);

  Map<String, dynamic> toJson() => _$TotalFuelBurnedToJson(this);
}

@JsonSerializable()
class Cumulatives {
  Cumulatives({
    this.cumulativeFuelBurned,
    this.averageFuelBurned,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  double cumulativeFuelBurned;
  double averageFuelBurned;
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
    this.totalFuelBurned,
    this.averageFuelBurned,
    this.totals,
    this.description,
    this.intervalStartDateLocalTime,
    this.intervalEndDateLocalTime,
    this.totalAssetCount,
    this.dayCount,
  });

  double totalFuelBurned;
  double averageFuelBurned;
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
    this.idleFuelBurned,
    this.workingFuelBurned,
    this.runtimeFuelBurned,
  });

  double idleFuelBurned;
  double workingFuelBurned;
  double runtimeFuelBurned;

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
