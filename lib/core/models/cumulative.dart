import 'package:json_annotation/json_annotation.dart';

part 'cumulative.g.dart';

@JsonSerializable()
class RunTimeCumulative {
  RunTimeCumulative({
    this.cumulatives,
    this.code,
    this.message,
  });

  Cumulatives cumulatives;
  int code;
  String message;

  factory RunTimeCumulative.fromJson(Map<String, dynamic> json) =>
      _$RunTimeCumulativeFromJson(json);

  Map<String, dynamic> toJson() => _$RunTimeCumulativeToJson(this);
}

@JsonSerializable()
class Cumulatives {
  Cumulatives({
    this.cumulativeHours,
    this.averageHours,
    this.totals,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  double cumulativeHours;
  double averageHours;
  Totals totals;
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
class FuelBurnedCumulative {
  FuelBurnedCumulative({
    this.cumulatives,
    this.code,
    this.message,
  });

  FuelBurnedCumulatives cumulatives;
  int code;
  String message;

  factory FuelBurnedCumulative.fromJson(Map<String, dynamic> json) =>
      _$FuelBurnedCumulativeFromJson(json);

  Map<String, dynamic> toJson() => _$FuelBurnedCumulativeToJson(this);
}

@JsonSerializable()
class FuelBurnedCumulatives {
  FuelBurnedCumulatives({
    this.totalFuelBurned,
    this.averageFuelBurned,
    this.totals,
    this.description,
    this.startDateLocalTime,
    this.endDateLocalTime,
    this.totalAssetCount,
    this.totalDayCount,
    this.intervalType,
  });

  double totalFuelBurned;
  double averageFuelBurned;
  FuelBurnedTotals totals;
  String description;
  DateTime startDateLocalTime;
  DateTime endDateLocalTime;
  int totalAssetCount;
  int totalDayCount;
  String intervalType;

  factory FuelBurnedCumulatives.fromJson(Map<String, dynamic> json) =>
      _$FuelBurnedCumulativesFromJson(json);

  Map<String, dynamic> toJson() => _$FuelBurnedCumulativesToJson(this);
}

@JsonSerializable()
class FuelBurnedTotals {
  FuelBurnedTotals({
    this.idleFuelBurned,
    this.workingFuelBurned,
    this.runtimeFuelBurned,
  });

  double idleFuelBurned;
  double workingFuelBurned;
  double runtimeFuelBurned;

  factory FuelBurnedTotals.fromJson(Map<String, dynamic> json) =>
      _$FuelBurnedTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$FuelBurnedTotalsToJson(this);
}
