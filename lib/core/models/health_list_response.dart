import 'package:json_annotation/json_annotation.dart';
part 'health_list_response.g.dart';

@JsonSerializable()
class HealthListResponse {
  FaultAssetData? assetData;
  HealthListResponse({this.assetData});
  factory HealthListResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HealthListResponseToJson(this);
}

@JsonSerializable()
class FaultAssetData {
  String? assetUid;
  List<Fault>? faults;
  FaultAssetData({this.faults, this.assetUid});
  factory FaultAssetData.fromJson(Map<String, dynamic> json) =>
      _$FaultAssetDataFromJson(json);
  Map<String, dynamic> toJson() => _$FaultAssetDataToJson(this);
}

@JsonSerializable()
class Fault {
  String? description;
  String? lastReportedLocation;
  double? hours;
  String? severityLabel;
  String? lastReportedTimeUTC;
  String? source;
  String? faultCode;
  double? lastReportedLocationLatitude;
  double? lastReportedLocationLongitude;
  String? faultIdentifiers;
  String? occurrences;
  Fault(
      {this.description,
      this.lastReportedLocation,
      this.lastReportedTimeUTC,
      this.hours,
      this.faultCode,
      this.severityLabel,
      this.lastReportedLocationLatitude,
      this.lastReportedLocationLongitude,
      this.faultIdentifiers,
      this.occurrences,
      this.source});

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);
  Map<String, dynamic> toJson() => _$FaultToJson(this);
}
