import 'package:json_annotation/json_annotation.dart';

part 'subscription_serial_number_results.g.dart';

@JsonSerializable()
class SerialNumberResults {
  ModelResult? result;
  String? status;
  String? message;

  SerialNumberResults({this.result, this.status, this.message});
  factory SerialNumberResults.fromJson(Map<String, dynamic> json) =>
      _$SerialNumberResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SerialNumberResultsToJson(this);
}

@JsonSerializable()
class ModelResult {
  String? startsWith;
  int? startRange;
  int? endRange;
  int? groupClusterId;
  String? modelName;

  ModelResult(
      {this.startsWith,
      this.startRange,
      this.endRange,
      this.groupClusterId,
      this.modelName});

  factory ModelResult.fromJson(Map<String, dynamic> json) =>
      _$ModelResultFromJson(json);

  Map<String, dynamic> toJson() => _$ModelResultToJson(this);
}
