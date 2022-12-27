import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/db/asset_count_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'links.dart';
part 'fault.g.dart';

@JsonSerializable()
class FaultSummaryResponse {
  final List<Links>? pageLinks;
  final List<Fault>? faults;
  final int? page;
  final int? limit;
  final int? total;
  FaultSummaryResponse(
      {this.faults, this.pageLinks, this.limit, this.page, this.total});

  factory FaultSummaryResponse.fromJson(Map<String, dynamic> json) {
    return _$FaultSummaryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultSummaryResponseToJson(this);
}

@JsonSerializable()
class Fault {
  Asset? asset;
  String? faultUid;
  Basic? basic;
  FaultDetails? details;

  Fault({this.asset, this.faultUid, this.basic, this.details});

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);

  Map<String, dynamic> toJson() => _$FaultToJson(this);
}

@JsonSerializable()
class FaultDetails {
  String? faultCode;
  String? faultReceivedUTC;
  String? dataLinkType;
  int? occurrences;
  String? url;

  FaultDetails(
      {this.dataLinkType,
      this.faultCode,
      this.faultReceivedUTC,
      this.occurrences,
      this.url});

  factory FaultDetails.fromJson(Map<String, dynamic> json) =>
      _$FaultDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FaultDetailsToJson(this);
}

@JsonSerializable()
class Asset {
  String? uid;
  Details? details;
  Basic? basic;
  List<Count>? countData;

  @JsonKey(name: "dynamic")
  FaultDynamic? faultDynamic;

  Asset(
      {this.uid, this.basic, this.details, this.faultDynamic, this.countData});

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class Basic {
  String? serialNumber;
  String? faultIdentifiers;
  String? description;
  String? severityLabel;
  String? severity;
  String? faultType;
  String? source;
  String? faultOccuredUTC;
  String? sourceIdentifierCode;
  bool? isResponseReceived;

  Basic(
      {this.serialNumber,
      this.description,
      this.faultIdentifiers,
      this.faultOccuredUTC,
      this.faultType,
      this.isResponseReceived,
      this.severity,
      this.severityLabel,
      this.source,
      this.sourceIdentifierCode});

  factory Basic.fromJson(Map<String, dynamic> json) => _$BasicFromJson(json);

  Map<String, dynamic> toJson() => _$BasicToJson(this);
}

@JsonSerializable()
class Details {
  String? makeCode;
  String? model;
  String? productFamily;
  int? assetIcon;
  List<Devices>? devices;
  String? dealerCode;
  String? dealerName;
  String? dealerCustomerName;
  String? universalCustomerName;

  Details({
    this.makeCode,
    this.model,
    this.productFamily,
    this.assetIcon,
    this.devices,
    this.dealerCode,
    this.dealerName,
    this.dealerCustomerName,
    this.universalCustomerName,
  });

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Devices {
  String? deviceType;
  String? deviceSerialNumber;
  String? firmwareVersion;

  Devices({this.deviceType, this.deviceSerialNumber, this.firmwareVersion});

  factory Devices.fromJson(Map<String, dynamic> json) =>
      _$DevicesFromJson(json);

  Map<String, dynamic> toJson() => _$DevicesToJson(this);
}

@JsonSerializable()
class FaultDynamic {
  String? status;
  double? locationLatitude;
  double? locationLongitude;
  String? locationReportedTimeUTC;
  String? location;
  double? hourMeter;
  double? odometer;

  FaultDynamic(
      {this.status,
      this.locationLatitude,
      this.locationLongitude,
      this.locationReportedTimeUTC,
      this.location,
      this.hourMeter,
      this.odometer});

  factory FaultDynamic.fromJson(Map<String, dynamic> json) =>
      _$FaultDynamicFromJson(json);
  Map<String, dynamic> toJson() => _$FaultDynamicToJson(this);
}

@JsonSerializable()
class AssetFaultSummaryResponse {
  final List<Links>? pageLinks;
  final List<Fault>? assetFaults;
  final int? page;
  final int? limit;
  final int? total;
  AssetFaultSummaryResponse(
      {this.assetFaults, this.pageLinks, this.limit, this.page, this.total});

  factory AssetFaultSummaryResponse.fromJson(Map<String, dynamic> json) {
    return _$AssetFaultSummaryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssetFaultSummaryResponseToJson(this);
}
