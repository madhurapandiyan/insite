import 'package:json_annotation/json_annotation.dart';
part 'subscription_dashboard_details.g.dart';

@JsonSerializable()
class SubscriptionDashboardDetailResult {
   DeviceTransferCount? deviceTransferCount ;
  List<DeviceTransfer>? deviceTransfer;
  List<List<DetailResult>>? result;
  SubscriptionFleetList? subscriptionFleetList;
  List<AssetOrHierarchyByTypeAndId>? assetOrHierarchyByTypeAndId;
  SubscriptionDashboardDetailResult(
      {this.result,
      this.subscriptionFleetList,
      this.assetOrHierarchyByTypeAndId,
      this.deviceTransfer,
      this.deviceTransferCount,
      });
  factory SubscriptionDashboardDetailResult.fromJson(
          Map<String, dynamic> json) =>
      _$SubscriptionDashboardDetailResultFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SubscriptionDashboardDetailResultToJson(this);
}

@JsonSerializable()
class AssetOrHierarchyByTypeAndId {
  String? name;
  String? userName;
  String? code;
  String? email;
  String? id;

  AssetOrHierarchyByTypeAndId(
      {this.name, this.userName, this.code, this.email, this.id});

  factory AssetOrHierarchyByTypeAndId.fromJson(Map<String, dynamic> json) =>
      _$AssetOrHierarchyByTypeAndIdFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOrHierarchyByTypeAndIdToJson(this);
}

@JsonSerializable()
class SubscriptionFleetList {
  int? count;
  List<ProvisioningInfo>? provisioningInfo;
  SubscriptionFleetList({this.count, this.provisioningInfo});
  factory SubscriptionFleetList.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFleetListFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionFleetListToJson(this);
}

@JsonSerializable()
class ProvisioningInfo {
  String? gpsDeviceID;
  String? model;
  String? vin;
  String? productFamily;
  String? customerCode;
  String? dealerName;
  String? dealerCode;
  String? customerName;
  dynamic status;
  dynamic description;
  String? networkProvider;
  String? subscriptionStartDate;
  String? actualStartDate;
  String? subscriptionEndDate;

  ProvisioningInfo(
      {this.gpsDeviceID,
      this.model,
      this.vin,
      this.productFamily,
      this.customerCode,
      this.dealerName,
      this.dealerCode,
      this.customerName,
      this.status,
      this.description,
      this.networkProvider,
      this.actualStartDate,
      this.subscriptionEndDate,
      this.subscriptionStartDate});

  factory ProvisioningInfo.fromJson(Map<String, dynamic> json) =>
      _$ProvisioningInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvisioningInfoToJson(this);
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
  double? totalDevice;

  @JsonKey(name: "GPSDeviceID")
  String? gpsDeviceId;

  String? vin;

  @JsonKey(name: "Model")
  String? model;

  @JsonKey(name: "ActualStartDate")
  String? actualStartDate;

  @JsonKey(name: "SubscriptionStartDate")
  String? subscriptionStartDate;

  @JsonKey(name: "SubscriptionEndDate")
  String? subscriptionEndDate;

  @JsonKey(name: "ProductFamily")
  String? productFamily;

  @JsonKey(name: "CustomerName")
  String? customerName;

  @JsonKey(name: "CustomerCode")
  String? customerCode;

  @JsonKey(name: "DealerName")
  String? dealerName;

  @JsonKey(name: "DealerCode")
  String? dealerCode;

  @JsonKey(name: "NetworkProvider")
  String? networkProvider;

  @JsonKey(name: "CommissioningDate")
  String? commissioningDate;

  @JsonKey(name: "SecondaryIndustry")
  String? secondaryIndustry;

  @JsonKey(name: "PrimaryIndustry")
  String? primaryIndustry;

  @JsonKey(name: "OEMName")
  String? oemName;

  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "UserName")
  String? userName;

  @JsonKey(name: "Email")
  String? email;

  @JsonKey(name: "Code")
  String? code;

 @JsonKey(name: "fk_AssetId")
  int? fkAssetId;

  @JsonKey(name: "fk_State")
  int? fkState;

  @JsonKey(name: "SourceName1")
  String? sourceName1;

  @JsonKey(name: "SourceName2")
  String? sourceName2;

  @JsonKey(name: "DestinationName1")
  String? destinationName1;

  @JsonKey(name: "DestinationName2")
  String? destinationName2;

  @JsonKey(name: "SourceCustomerType")
  String? sourceCustomerType;

  @JsonKey(name: "DestinationCustomerType")
  String? destinationCustomerType;

  @JsonKey(name: "Status")
  String? status;

  @JsonKey(name: "Description")
  String? description;

  @JsonKey(name: "InsertUTC")
  String? insertUtc;

  @JsonKey(name: "count")
  int? count;

  DetailResult(
      {this.totalDevice,
      this.actualStartDate,
      this.customerCode,
      this.customerName,
      this.dealerCode,
      this.code,
      this.email,
      this.id,
      this.name,
      this.userName,
      this.oemName,
      this.dealerName,
      this.commissioningDate,
      this.primaryIndustry,
      this.secondaryIndustry,
      this.gpsDeviceId,
      this.model,
      this.subscriptionEndDate,
      this.subscriptionStartDate,
      this.vin,
      this.networkProvider,
      this.productFamily,
      this.fkAssetId,
      this.sourceName1,
      this.sourceName2,
      this.destinationName1,
      this.destinationName2,
      this.destinationCustomerType,
      this.insertUtc,
      this.sourceCustomerType,
      this.status,
      this.count,
      this.description,
      this.fkState});

  factory DetailResult.fromJson(Map<String, dynamic> json) =>
      _$DetailResultFromJson(json);
  Map<String, dynamic> toJson() => _$DetailResultToJson(this);
}

// @JsonSerializable()
// class SubscriptionFleetList {
//   int? count;
//   List<ProvisioningInfo?>? provisioningInfo;

//   SubscriptionFleetList({this.count, this.provisioningInfo});

//   factory SubscriptionFleetList.fromJson(Map<String, dynamic> json) =>
//       _$SubscriptionFleetListFromJson(json);
//   Map<String, dynamic> toJson() => _$SubscriptionFleetListToJson(this);
// }

// @JsonSerializable()
// class ProvisioningInfo {
//   String? vin;
//   String? gpsDeviceID;
//   String? model;
//   String? subscriptionStartDate;

//   ProvisioningInfo(
//       {this.vin, this.gpsDeviceID, this.model, this.subscriptionStartDate});

//   factory ProvisioningInfo.fromJson(Map<String, dynamic> json) =>
//       _$ProvisioningInfoFromJson(json);
//   Map<String, dynamic> toJson() => _$ProvisioningInfoToJson(this);
// }
@JsonSerializable()
class DeviceTransfer {
  @JsonKey(name: "gpsDeviceID")
  String? gpsDeviceId;
  String? oemName;
  String? status;
  String? destinationCustomerType;
  String? sourceCustomerType;
  String? destinationName1;
  String? destinationName2;
  @JsonKey(name: "fk_AssetId")
  int? fkAssetId;
  @JsonKey(name: "insertUTC")
  String? insertUtc;
  String? sourceName1;
  String? sourceName2;
  String? vin;
  String? sTypename;

  DeviceTransfer(
      {this.gpsDeviceId,
      this.oemName,
      this.status,
      this.destinationCustomerType,
      this.destinationName1,
      this.destinationName2,
      this.fkAssetId,
      this.insertUtc,
      this.sourceName1,
      this.sourceName2,
      this.sourceCustomerType,
      this.vin,
      this.sTypename
      });

  factory DeviceTransfer.fromJson(Map<String, dynamic> json) =>
      _$DeviceTransferFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTransferToJson(this);
}
@JsonSerializable()
class DeviceTransferCount{
  String? count ;

  DeviceTransferCount({this.count});

  factory DeviceTransferCount.fromJson(Map<String, dynamic> json) =>
      _$DeviceTransferCountFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTransferCountToJson(this);
}