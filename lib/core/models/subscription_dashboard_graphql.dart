import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard_graphql.g.dart';

@JsonSerializable()
class DashboardData {
  double? activeSubscription;
  double? yetToBeActivated;
  double? totalDevicesSupplied;
  double? plantAssetCount;
  double? subscriptionEnded;
  double? assetActivationByDay;
  double? assetActivationByWeek;
  double? assetActivationByMonth;
  List<ModelFleetList?>? modelFleetList;

  DashboardData(
      {this.activeSubscription,
      this.yetToBeActivated,
      this.totalDevicesSupplied,
      this.plantAssetCount,
      this.subscriptionEnded,
      this.assetActivationByDay,
      this.assetActivationByWeek,
      this.assetActivationByMonth,
      this.modelFleetList});

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}

@JsonSerializable()
class ModelFleetList {
  @JsonKey(name: "ModelCount")
  double? modelCount;
  @JsonKey(name: "ModelName")
  String? modelName;

  ModelFleetList({this.modelCount, this.modelName});
  factory ModelFleetList.fromJson(Map<String, dynamic> json) =>
      _$ModelFleetListFromJson(json);
  Map<String, dynamic> toJson() => _$ModelFleetListToJson(this);
}
