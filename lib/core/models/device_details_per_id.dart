import 'package:json_annotation/json_annotation.dart';
part 'device_details_per_id.g.dart';

@JsonSerializable()
class DeviceDetailsPerId {
  List<ResultData>? result;

  DeviceDetailsPerId({this.result});
  factory DeviceDetailsPerId.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailsPerIdFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDetailsPerIdToJson(this);
}

@JsonSerializable()
class ResultData {
  @JsonKey(name: "VIN")
  String? serialNo;
  @JsonKey(name: "Model")
  String? model;

  ResultData({this.serialNo, this.model});
  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
