import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard.g.dart';

@JsonSerializable()
class DashboardResult {
  List<List<Result>> result;
  DashboardResult({this.result});
  factory DashboardResult.fromJson(Map<String, dynamic> json) =>
      _$DashboardResultFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResultToJson(this);
}

// @JsonSerializable()
// class ResultData {
//   List<Results> resultList;
//   ResultData({this.resultList});
//   factory ResultData.fromJson(Map<String, dynamic> json) =>
//       _$ResultDataFromJson(json);
//   Map<String, dynamic> toJson() => _$ResultDataToJson(this);
// }

@JsonSerializable()
class Result {
  // to diplay key name as displayed on endpoint.
  @JsonKey(name: "activelist")
  double activeList;

  @JsonKey(name: "inActiveList")
  double inActiveList;

  @JsonKey(name: "ModelCount")
  double modelCount;

  @JsonKey(name: "ModelName")
  String modelName;

  @JsonKey(name: "totalDevice")
  double totalDevice;

  @JsonKey(name: "PlantAssetCount")
  double plantAssetCount;

  @JsonKey(name: "subscriptionEndAsset")
  double subscriptionAndAsset;

  @JsonKey(name: "day_count")
  double dayCount;

  @JsonKey(name: "week_count")
  double weekCount;

  @JsonKey(name: "month_count")
  double monthCount;

  @JsonKey(name: "subscriptionEndingAsset_Month")
  double subscriptionEndingAsset;

  Result(
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

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
