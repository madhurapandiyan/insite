import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard_details.g.dart';

@JsonSerializable()
class SubscriptionDashboardDetailResult {
  List<List<DetailResult>> result;
  SubscriptionDashboardDetailResult({this.result});
  factory SubscriptionDashboardDetailResult.fromJson(
          Map<String, dynamic> json) =>
      _$SubscriptionDashboardDetailResultFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SubscriptionDashboardDetailResultToJson(this);
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
class DetailResult {
  // to diplay key name as displayed on endpoint.
  @JsonKey(name: "totalDevice")
  double totalDevice;

  @JsonKey(name: "GPSDeviceID")
  String GPSDeviceID;

  @JsonKey(name: "VIN")
  String VIN;

  @JsonKey(name: "Model")
  String Model;

  @JsonKey(name: "ActualStartDate")
  String ActualStartDate;

  @JsonKey(name: "SubscriptionStartDate")
  String SubscriptionStartDate;

  @JsonKey(name: "SubscriptionEndDate")
  String SubscriptionEndDate;

  @JsonKey(name: "ProductFamily")
  String ProductFamily;

  @JsonKey(name: "CustomerName")
  String CustomerName;

  @JsonKey(name: "CustomerCode")
  String CustomerCode;

  @JsonKey(name: "DealerName")
  String DealerName;

  @JsonKey(name: "DealerCode")
  String DealerCode;

  @JsonKey(name: "NetworkProvider")
  String NetworkProvider;

  @JsonKey(name: "CommissioningDate")
  String CommissioningDate;

  @JsonKey(name: "SecondaryIndustry")
  String SecondaryIndustry;

  @JsonKey(name: "PrimaryIndustry")
  String PrimaryIndustry;

  @JsonKey(name: "OEMName")
  String OEMName;

  DetailResult(
      {this.totalDevice,
      this.ActualStartDate,
      this.CustomerCode,
      this.CustomerName,
      this.DealerCode,
      this.OEMName,
      this.DealerName,
      this.CommissioningDate,
      this.PrimaryIndustry,
      this.SecondaryIndustry,
      this.GPSDeviceID,
      this.Model,
      this.SubscriptionEndDate,
      this.SubscriptionStartDate,
      this.VIN,
      this.NetworkProvider,
      this.ProductFamily});

  factory DetailResult.fromJson(Map<String, dynamic> json) =>
      _$DetailResultFromJson(json);
  Map<String, dynamic> toJson() => _$DetailResultToJson(this);
}
