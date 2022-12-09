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
@JsonSerializable()
class AssetOperation {
 String? code;
    String? status;
    @JsonKey(name: "requestID")
    String? requestId;
    @JsonKey(name: "__typename")
    String? typename;
  AssetOperation({this.code,this.status,this.requestId,this.typename});

    factory AssetOperation.fromJson(Map<String, dynamic> json) =>
      _$AssetOperationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOperationToJson(this);
}

@JsonSerializable(explicitToJson: true,includeIfNull: false)
class  AssetOperationInput {
final String? source;
   @JsonKey(name: "userID")
  final int? userId;
  final String? version;
  final List<Asset>? asset;
  AssetOperationInput({this.source,this.userId,this.version,this.asset});

    factory AssetOperationInput.fromJson(Map<String, dynamic> json) =>
      _$AssetOperationInputFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOperationInputToJson(this);
}

@JsonSerializable(explicitToJson: true,includeIfNull: false)
class  TranferAssetOperationInput {
final String? source;
   @JsonKey(name: "userID")
  final int? userId;
  final String? version;
  final List<Asset>? transfer;
  TranferAssetOperationInput({this.source,this.userId,this.version,this.transfer});

    factory TranferAssetOperationInput.fromJson(Map<String, dynamic> json) =>
      _$TranferAssetOperationInputFromJson(json);

  Map<String, dynamic> toJson() => _$TranferAssetOperationInputToJson(this);
}
@JsonSerializable(explicitToJson: true,includeIfNull: false)
class Asset {
  
  String? customerMobile;

  String? customerLanguage;
  
  String? dealerMobile;
  
  String? dealerLanguage;
 
  String? deviceId;
 
  String? machineModel;
  
  int? hmr;
  
  String? hmrDate;
  
  String? primaryIndustry;
  
  String? secondaryIndustry;
 
  String? machineSlNo;
  
  String? commissioningDate;
  
  String? plantName;
  
  String? plantCode;
  @JsonKey(name: "plantEmailID")
  String? plantEmailId;
  
  String? dealerName;
  
  String? dealerCode;
  @JsonKey(name: "dealerEmailID")
  String? dealerEmailId;

  String? customerName;

  String? customerCode;
  @JsonKey(name: "customerEmailID")
  String? customerEmailId;

  Asset(
      {this.deviceId,
      this.machineModel,
      this.hmr,
      this.hmrDate,
      this.primaryIndustry,
      this.secondaryIndustry,
      this.machineSlNo,
      this.commissioningDate,
      this.plantName,
      this.plantCode,
      this.plantEmailId,
      this.dealerName,
      this.dealerCode,
      this.dealerEmailId,
      this.customerName,
      this.customerCode,
      this.customerEmailId,
      this.customerLanguage,
      this.customerMobile,
      this.dealerLanguage,
      this.dealerMobile});
  factory Asset.fromJson(Map<String, dynamic> json) =>
      _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
