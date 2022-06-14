import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard.g.dart';

@JsonSerializable()
class SubscriptionDashboardResult {
  List<List<ResultSubscription>>? result;
  SubscriptionDashboardResult({this.result});
  factory SubscriptionDashboardResult.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDashboardResultFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionDashboardResultToJson(this);
}

@JsonSerializable()
class ResultSubscription {
  // to diplay key name as displayed on endpoint.
  @JsonKey(name: "activelist")
  double? activeList;

  @JsonKey(name: "inActiveList")
  double? inActiveList;

  @JsonKey(name: "ModelCount")
  double? modelCount;

  @JsonKey(name: "ModelName")
  String? modelName;

  @JsonKey(name: "totalDevice")
  double? totalDevice;

  @JsonKey(name: "PlantAssetCount")
  double? plantAssetCount;

  @JsonKey(name: "subscriptionEndAsset")
  double? subscriptionAndAsset;

  @JsonKey(name: "day_count")
  double? dayCount;

  @JsonKey(name: "week_count")
  double? weekCount;

  @JsonKey(name: "month_count")
  double? monthCount;

  @JsonKey(name: "subscriptionEndingAsset_Month")
  double? subscriptionEndingAsset;

  ResultSubscription(
      {this.activeList,
      this.inActiveList,
      this.modelCount,
      this.modelName,
      this.totalDevice,
      this.plantAssetCount,
      this.subscriptionAndAsset,
      this.dayCount,
      this.weekCount,
      this.monthCount,
      this.subscriptionEndingAsset});

  factory ResultSubscription.fromJson(Map<String, dynamic> json) =>
      _$ResultSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$ResultSubscriptionToJson(this);
}
