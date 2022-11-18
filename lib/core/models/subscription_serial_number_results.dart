import 'package:json_annotation/json_annotation.dart';

part 'subscription_serial_number_results.g.dart';

@JsonSerializable()
class SerialNumberResults {
  AssetModelByMachineSerialNumber? assetModelByMachineSerialNumber;
  ModelResult? result;
  String? status;
  String? message;

  SerialNumberResults({this.result, this.status, this.message,this.assetModelByMachineSerialNumber});
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
@JsonSerializable()
class AssetModelByMachineSerialNumber {
  String? startsWith;
  int? startRange;
  int? endRange;
  int? groupClusterId;
  String? modelName;

  AssetModelByMachineSerialNumber(
      {this.startsWith,
      this.startRange,
      this.endRange,
      this.groupClusterId,
      this.modelName});

  factory AssetModelByMachineSerialNumber.fromJson(Map<String, dynamic> json) =>
      _$AssetModelByMachineSerialNumberFromJson(json);

  Map<String, dynamic> toJson() => _$AssetModelByMachineSerialNumberToJson(this);
}
