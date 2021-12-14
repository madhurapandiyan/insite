import 'package:json_annotation/json_annotation.dart';
part 'add_asset_transfer.g.dart';

@JsonSerializable()
class AssetTransferData {
  @JsonKey(name: "Source")
  String? source;
  @JsonKey(name: "Version")
  String? version;
  @JsonKey(name: "UserID")
  int? userID;
  @JsonKey(name: "transfer")
  List<Transfer>? transfer;
  @JsonKey(name: "status")
  String? status;
  AssetTransferData(
      {this.source, this.transfer, this.userID, this.version, this.status});

  factory AssetTransferData.fromJson(Map<String, dynamic> json) =>
      _$AssetTransferDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetTransferDataToJson(this);
}

@JsonSerializable()
class Transfer {
  @JsonKey(name: "DeviceId")
  String? deviceId;
  @JsonKey(name: "MachineModel")
  String? machineModel;
  @JsonKey(name: "HMR")
  String? hMR;
  @JsonKey(name: "HMRDate")
  String? hMRDate;
  @JsonKey(name: "PlantName")
  String? plantName;
  @JsonKey(name: "PlantCode")
  String? plantCode;
  @JsonKey(name: "PlantEmailID")
  String? plantEmailID;
  @JsonKey(name: "PrimaryIndustry")
  String? primaryIndustry;
  @JsonKey(name: "SecondaryIndustry")
  String? secondaryIndustry;
  @JsonKey(name: "DealerLanguage")
  String? dealerLanguage;
  @JsonKey(name: "DealerMobile")
  String? dealerMobile;
  @JsonKey(name: "CustomerLanguage")
  String? customerLanguage;
  @JsonKey(name: "CustomerMobile")
  String? customerMobile;
  @JsonKey(name: "MachineSlNo")
  String? machineSlNo;
  @JsonKey(name: "CommissioningDate")
  String? commissioningDate;
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

  Transfer(
      {this.deviceId,
      this.machineModel,
      this.hMR,
      this.hMRDate,
      this.plantName,
      this.plantCode,
      this.plantEmailID,
      this.primaryIndustry,
      this.secondaryIndustry,
      this.dealerLanguage,
      this.dealerMobile,
      this.customerLanguage,
      this.customerMobile,
      this.machineSlNo,
      this.commissioningDate,
      this.dealerName,
      this.dealerCode,
      this.dealerEmailID,
      this.customerName,
      this.customerCode,
      this.customerEmailID});
  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);
}
