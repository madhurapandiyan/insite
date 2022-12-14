import 'package:json_annotation/json_annotation.dart';
part 'subscription_fleet_graphql.g.dart';

@JsonSerializable()
class SubscriptionFleetGraph {
  FleetProvisionStatus? fleetProvisionStatus;
  SubscriptionFleetGraph({this.fleetProvisionStatus});
  factory SubscriptionFleetGraph.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFleetGraphFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionFleetGraphToJson(this);
}

@JsonSerializable()
class FleetProvisionStatus {
  int? count;
  List<FleetProvisionStatusInfo>? fleetProvisionStatusInfo;
  String? sTypename;

  FleetProvisionStatus(
      {this.count, this.fleetProvisionStatusInfo, this.sTypename});

  factory FleetProvisionStatus.fromJson(Map<String, dynamic> json) =>
      _$FleetProvisionStatusFromJson(json);
  Map<String, dynamic> toJson() => _$FleetProvisionStatusToJson(this);
}

@JsonSerializable()
class FleetProvisionStatusInfo {
  String? gpsDeviceID;
  String? vin;
  String? model;
  String? oemName;
  String? subscriptionStartDate;
  String? actualStartDate;
  String? subscriptionEndDate;
  String? productFamily;
  String? customerName;
  String? customerCode;
  String? dealerName;
  String? dealerCode;
  String? commissioningDate;
  String? secondaryIndustry;
  String? primaryIndustry;
  String? networkProvider;
  int? status;
  String? description;
  String? sTypename;

  FleetProvisionStatusInfo(
      {this.gpsDeviceID,
      this.vin,
      this.model,
      this.oemName,
      this.subscriptionStartDate,
      this.actualStartDate,
      this.subscriptionEndDate,
      this.productFamily,
      this.customerName,
      this.customerCode,
      this.dealerName,
      this.dealerCode,
      this.commissioningDate,
      this.secondaryIndustry,
      this.primaryIndustry,
      this.networkProvider,
      this.status,
      this.description,
      this.sTypename});

  factory FleetProvisionStatusInfo.fromJson(Map<String, dynamic> json) =>
      _$FleetProvisionStatusInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FleetProvisionStatusInfoToJson(this);
}
