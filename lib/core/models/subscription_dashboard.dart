import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard.g.dart';

@JsonSerializable(explicitToJson: true)
class DashboardResult {
  List<ResultData> resultData;
  DashboardResult({this.resultData});
  factory DashboardResult.fromJson(Map<String, dynamic> json) =>
      _$DashboardResultFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResultData {
  List<Results> result;
  ResultData({this.result});
  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}

@JsonSerializable()
class Results {
  // to diplay key name as displayed on endpoint.
  @JsonKey(name: "activelist")
  int activeList;

  @JsonKey(name: "inActiveList")
  int inActiveList;

  @JsonKey(name: "ModelCount")
  int modelCount;

  @JsonKey(name: "ModelName")
  String modelName;

  @JsonKey(name: "totalDevice")
  int totalDevice;

  @JsonKey(name: "PlantAssetCount")
  int plantAssetCount;

  @JsonKey(name: "subscriptionEndAsset")
  int subscriptionAndAsset;

  @JsonKey(name: "day_count")
  int dayCount;

  @JsonKey(name: "week_count")
  int weekCount;

  @JsonKey(name: "month_count")
  int monthCount;

  @JsonKey(name: "subscriptionEndingAsset_Month")
  int subscriptionEndingAsset;

  Results(
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

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
