import 'package:json_annotation/json_annotation.dart';
part 'health_list_response.g.dart';

@JsonSerializable()
class HealthListResponse {
  AssetData assetData;
  HealthListResponse({this.assetData});
  factory HealthListResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HealthListResponseToJson(this);
}

@JsonSerializable()
class AssetData {
  List<Fault> faults;
  AssetData({this.faults});
  factory AssetData.fromJson(Map<String, dynamic> json) =>
      _$AssetDataFromJson(json);
  Map<String, dynamic> toJson() => _$AssetDataToJson(this);
}

@JsonSerializable()
class Fault {
  String description;
  String lastReportedLocation;
  double hours;
  String severityLabel;
  String lastReportedTimeUTC;
  String source;

  Fault(
      {this.description,
      this.lastReportedLocation,
      this.lastReportedTimeUTC,
      this.hours,
      this.severityLabel,
      this.source});

  factory Fault.fromJson(Map<String, dynamic> json) =>
      _$FaultFromJson(json);
  Map<String, dynamic> toJson() => _$FaultToJson(this);
}
