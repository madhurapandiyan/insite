import 'package:json_annotation/json_annotation.dart';
part 'get_asset_details_by_serial_no.g.dart';

@JsonSerializable()
class AssetDetailsBySerialNo {
  List<ResultsValues>? result;
  AssetDetailsBySerialNo({this.result});

  factory AssetDetailsBySerialNo.fromJson(Map<String, dynamic> json) =>
      _$AssetDetailsBySerialNoFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDetailsBySerialNoToJson(this);
}

@JsonSerializable()
class ResultsValues {
  @JsonKey(name: "Model")
  String? model;

  @JsonKey(name: "GPSDeviceID")
  String? deviceId;

  ResultsValues({this.model, this.deviceId});

  factory ResultsValues.fromJson(Map<String, dynamic> json) =>
      _$ResultsValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsValuesToJson(this);
}
