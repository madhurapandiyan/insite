import 'package:json_annotation/json_annotation.dart';
import 'asset_status.dart';
import 'links.dart';
part 'fault.g.dart';

@JsonSerializable()
class FaultSummaryResponse {
  final List<Links> pageLinks;
  final List<Fault> faults;
  final int page;
  final int limit;
  final int total;
  FaultSummaryResponse(
      {this.faults, this.pageLinks, this.limit, this.page, this.total});

  factory FaultSummaryResponse.fromJson(Map<String, dynamic> json) {
    return _$FaultSummaryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultSummaryResponseToJson(this);
}

@JsonSerializable()
class Fault {
  final dynamic asset;
  final String description;
  final String faultType;
  final double hours;
  final String severityLabel;
  final String faultOccuredUTC;
  final String source;
  final String faultCode;
  final FaultBasic basic;
  final FaultDetails details;
  final List<Count> countData;

  Fault(
      {this.asset,
      this.basic,
      this.details,
      this.countData,
      this.description,
      this.faultCode,
      this.hours,
      this.faultType,
      this.faultOccuredUTC,
      this.severityLabel,
      this.source});

  factory Fault.fromJson(Map<String, dynamic> json) {
    return _$FaultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultToJson(this);
}

@JsonSerializable()
class FaultAsset {
  final String uid;
  final dynamic basic;
  final dynamic details;
  FaultAsset({this.uid, this.basic, this.details});

  factory FaultAsset.fromJson(Map<String, dynamic> json) {
    return _$FaultAssetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultAssetToJson(this);
}

@JsonSerializable()
class FaultDynamic {
  final String status;
  final String location;
  final String locationReportedTimeUTC;
  final String hourMeter;
  final String odometer;
  FaultDynamic(
      {this.status,
      this.location,
      this.locationReportedTimeUTC,
      this.hourMeter,
      this.odometer});

  factory FaultDynamic.fromJson(Map<String, dynamic> json) {
    return _$FaultDynamicFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultDynamicToJson(this);
}

@JsonSerializable()
class FaultBasic {
  final String faultIdentifiers;
  final String description;
  final String source;
  final String severity;
  final String faultType;
  final String faultOccuredUTC;
  FaultBasic(
      {this.faultIdentifiers,
      this.description,
      this.source,
      this.faultOccuredUTC,
      this.faultType,
      this.severity});

  factory FaultBasic.fromJson(Map<String, dynamic> json) {
    return _$FaultBasicFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultBasicToJson(this);
}

@JsonSerializable()
class FaultDetails {
  final String faultReceivedUTC;
  FaultDetails({this.faultReceivedUTC});

  factory FaultDetails.fromJson(Map<String, dynamic> json) {
    return _$FaultDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultDetailsToJson(this);
}

@JsonSerializable()
class AssetFaultSummaryResponse {
  final List<Links> pageLinks;
  final List<Fault> assetFaults;
  final int page;
  final int limit;
  final int total;
  AssetFaultSummaryResponse(
      {this.assetFaults, this.pageLinks, this.limit, this.page, this.total});

  factory AssetFaultSummaryResponse.fromJson(Map<String, dynamic> json) {
    return _$AssetFaultSummaryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssetFaultSummaryResponseToJson(this);
}
