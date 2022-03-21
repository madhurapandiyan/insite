import 'package:json_annotation/json_annotation.dart';
part 'complete.g.dart';

@JsonSerializable()
class Complete {
  String? completionType;
  num? currentIntervalID;
  num? occurrenceID;
  String? currentIntervalName;
  bool? isHighest;
  DueInfos? dueInfos;
  List<RationalizationOptions>? rationalizationOptions;

  Complete(
      {this.completionType,
      this.currentIntervalID,
      this.occurrenceID,
      this.currentIntervalName,
      this.isHighest,
      this.dueInfos,
      this.rationalizationOptions});

  factory Complete.fromJson(Map<String, dynamic> json) =>
      _$CompleteFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteToJson(this);
}

@JsonSerializable()
class DueInfos {
  num? dueAt;
  String? smuType;
  num? completedAt;
  num? dueIn;
  String? dueDate;

  DueInfos(
      {this.dueAt, this.smuType, this.completedAt, this.dueIn, this.dueDate});

  factory DueInfos.fromJson(Map<String, dynamic> json) =>
      _$DueInfosFromJson(json);

  Map<String, dynamic> toJson() => _$DueInfosToJson(this);
}

@JsonSerializable()
class RationalizationOptions {
  num? intervalID;
  String? intervalName;
  String? smuType;
  num? minValue;
  num? maxValue;
  String? minDate;
  String? maxDate;
  String? resetType;
  String? completedBaseCyclePosition;
  NextBaseCyclePosition? nextBaseCyclePosition;

  RationalizationOptions(
      {this.intervalID,
      this.intervalName,
      this.smuType,
      this.minValue,
      this.maxValue,
      this.minDate,
      this.maxDate,
      this.resetType,
      this.completedBaseCyclePosition,
      this.nextBaseCyclePosition});
  factory RationalizationOptions.fromJson(Map<String, dynamic> json) =>
      _$RationalizationOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$RationalizationOptionsToJson(this);
}

@JsonSerializable()
class NextBaseCyclePosition {
  num? maintenanceIntervalRank;
  num? occurrenceRank;
  num? smuvalue;
  String? smuDate;

  NextBaseCyclePosition(
      {this.maintenanceIntervalRank,
      this.occurrenceRank,
      this.smuvalue,
      this.smuDate});
  factory NextBaseCyclePosition.fromJson(Map<String, dynamic> json) =>
      _$NextBaseCyclePositionFromJson(json);

  Map<String, dynamic> toJson() => _$NextBaseCyclePositionToJson(this);
}
