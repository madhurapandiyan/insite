import 'package:json_annotation/json_annotation.dart';
part 'device_replacement_details.g.dart';

@JsonSerializable()
class SubscriptionDeviceFleetList {
  int? count;
  List<ProvisioningInfo>? provisioningInfo;
  String? sTypename;

  SubscriptionDeviceFleetList(
      {this.count, this.provisioningInfo, this.sTypename});

  factory SubscriptionDeviceFleetList.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDeviceFleetListFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionDeviceFleetListToJson(this);
}

@JsonSerializable()
class ProvisioningInfo {
  final String? vin;
  final String? gpsDeviceID;
  final String? model;
  final String? subscriptionStartDate;
  final String? sTypename;

  ProvisioningInfo(
      {this.vin,
      this.gpsDeviceID,
      this.model,
      this.subscriptionStartDate,
      this.sTypename});

  factory ProvisioningInfo.fromJson(Map<String, dynamic> json) =>
      _$ProvisioningInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvisioningInfoToJson(this);
}
