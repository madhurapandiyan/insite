import 'package:json_annotation/json_annotation.dart';

part 'fuel_burn_rate_trend.g.dart';

@JsonSerializable()
class FuelBurnRateTrend {
  FuelBurnRateTrend({
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

  factory FuelBurnRateTrend.fromJson(Map<String, dynamic> json) =>
      _$FuelBurnRateTrendFromJson(json);

  Map<String, dynamic> toJson() => _$FuelBurnRateTrendToJson(this);
}

@JsonSerializable()
class Cumulatives {
  Cumulatives({
    this.cumulativeFuelBurnRate,
    this.averageFuelBurnRate,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  dynamic cumulativeFuelBurnRate;
  dynamic averageFuelBurnRate;
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
    this.burnrates,
    this.description,
    this.intervalStartDateLocalTime,
    this.intervalEndDateLocalTime,
    this.totalAssetCount,
    this.dayCount,
  });

  Burnrates? burnrates;
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
class Burnrates {
  Burnrates({
    this.runtimeFuelBurnRate,
    this.idleFuelBurnRate,
    this.workingFuelBurnRate,
  });

  double? runtimeFuelBurnRate;
  double? idleFuelBurnRate;
  double? workingFuelBurnRate;

  factory Burnrates.fromJson(Map<String, dynamic> json) =>
      _$BurnratesFromJson(json);

  Map<String, dynamic> toJson() => _$BurnratesToJson(this);
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
