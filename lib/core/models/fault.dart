import 'package:json_annotation/json_annotation.dart';
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
  final FaultAsset asset;
  final FaultBasic basic;
  final FaultDetails details;

  Fault({this.asset, this.basic, this.details});

  factory Fault.fromJson(Map<String, dynamic> json) {
    return _$FaultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultToJson(this);
}

@JsonSerializable()
class FaultAsset {
  final int limit;
  final int total;
  final String uid;
  final dynamic basic;
  final dynamic details;
  FaultAsset({this.limit, this.total, this.uid, this.basic, this.details});

  factory FaultAsset.fromJson(Map<String, dynamic> json) {
    return _$FaultAssetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultAssetToJson(this);
}

@JsonSerializable()
class FaultBasic {
  final int limit;
  final int total;
  FaultBasic({this.limit, this.total});

  factory FaultBasic.fromJson(Map<String, dynamic> json) {
    return _$FaultBasicFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultBasicToJson(this);
}

@JsonSerializable()
class FaultDetails {
  final int limit;
  final int total;
  FaultDetails({this.limit, this.total});

  factory FaultDetails.fromJson(Map<String, dynamic> json) {
    return _$FaultDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FaultDetailsToJson(this);
}

@JsonSerializable()
class AssetFaultSummaryResponse {
  final List<Links> pageLinks;
  final List<Fault> faults;
  final int page;
  final int limit;
  final int total;
  AssetFaultSummaryResponse(
      {this.faults, this.pageLinks, this.limit, this.page, this.total});

  factory AssetFaultSummaryResponse.fromJson(Map<String, dynamic> json) {
    return _$AssetFaultSummaryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssetFaultSummaryResponseToJson(this);
}
