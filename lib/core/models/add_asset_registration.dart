import 'package:json_annotation/json_annotation.dart';
part 'add_asset_registration.g.dart';

@JsonSerializable()
class AddAssetRegistrationData {
  String? Source;

  String? Version;

  int? UserID;

  List<AssetValues>? asset;
AddAssetRegistrationData(
      {this.Source,
      this.Version,
      this.UserID,
      this.asset,
});

  factory AddAssetRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$AddAssetRegistrationDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddAssetRegistrationDataToJson(this);
}

@JsonSerializable()
class AssetValues {
  @JsonKey(name: "CustomerMobile")
  String? CustomerMobile;
  @JsonKey(name: "CustomerLanguage")
  String? CustomerLanguage;
  @JsonKey(name: "DealerMobile")
  String? DealerMobile;
  @JsonKey(name: "DealerLanguage")
  String? DealerLanguage;
  @JsonKey(name: "DeviceId")
  String? deviceId;
  @JsonKey(name: "MachineModel")
  String? machineModel;
  @JsonKey(name: "HMR")
  int? hMR;
  @JsonKey(name: "HMRDate")
  String? hMRDate;
  @JsonKey(name: "PrimaryIndustry")
  String? primaryIndustry;
  @JsonKey(name: "SecondaryIndustry")
  String? secondaryIndustry;
  @JsonKey(name: "MachineSlNo")
  String? machineSlNo;
  @JsonKey(name: "CommissioningDate")
  String? commissioningDate;
  @JsonKey(name: "PlantName")
  String? plantName;
  @JsonKey(name: "PlantCode")
  String? plantCode;
  @JsonKey(name: "PlantEmailID")
  String? plantEmailID;
  @JsonKey(name: "DealerName")
  String? dealerName;
  @JsonKey(name: "DealerCode")
  String? dealerCode;
  @JsonKey(name: "DealerEmailID")
  String? dealerEmailID;
  @JsonKey(name: "CustomerName")
  String? customerName;
  @JsonKey(name: "CustomerCode")
  String? customerCode;
  @JsonKey(name: "CustomerEmailID")
  String? customerEmailID;

  AssetValues(
      {this.deviceId,
      this.machineModel,
      this.hMR,
      this.hMRDate,
      this.primaryIndustry,
      this.secondaryIndustry,
      this.machineSlNo,
      this.commissioningDate,
      this.plantName,
      this.plantCode,
      this.plantEmailID,
      this.dealerName,
      this.dealerCode,
      this.dealerEmailID,
      this.customerName,
      this.customerCode,
      this.customerEmailID,
      this.CustomerLanguage,
      this.CustomerMobile,
      this.DealerLanguage,
      this.DealerMobile});
  factory AssetValues.fromJson(Map<String, dynamic> json) =>
      _$AssetValuesFromJson(json);

  Map<String, dynamic> toJson() => _$AssetValuesToJson(this);
}

@JsonSerializable()
class AssetTransfer {
  final String? Source;
  final String? Version;
  final int? UserID;
  final List<AssetValues>? transfer;
  AssetTransfer({this.Source,this.UserID,this.Version,this.transfer});

    factory AssetTransfer.fromJson(Map<String, dynamic> json) =>
      _$AssetTransferFromJson(json);

  Map<String, dynamic> toJson() => _$AssetTransferToJson(this);
}
