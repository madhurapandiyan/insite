import 'package:json_annotation/json_annotation.dart';
part 'fault_code_type_search.g.dart';

@JsonSerializable()
class FaultCodeTypeSearch {
  final List<FaultCodeDetails>? descriptions;
  final String? reqId;
  final int? total;
  FaultCodeTypeSearch({this.descriptions, this.reqId, this.total});
  factory FaultCodeTypeSearch.fromJson(Map<String, dynamic> json) =>
      _$FaultCodeTypeSearchFromJson(json);

  Map<String, dynamic> toJson() => _$FaultCodeTypeSearchToJson(this);
}

@JsonSerializable()
class SingleFaultCodeTypeSearch {
  final List<FaultCodeDetails>? faults;
  final String? status;
  SingleFaultCodeTypeSearch({
    this.faults,
    this.status,
  });
  factory SingleFaultCodeTypeSearch.fromJson(Map<String, dynamic> json) =>
      _$SingleFaultCodeTypeSearchFromJson(json);

  Map<String, dynamic> toJson() => _$SingleFaultCodeTypeSearchToJson(this);
}

@JsonSerializable()
class FaultCodeDetails {
  final String? faultCodeIdentifier;
  final String? faultDescription;
  final String? faultCodeType;
  bool isExpanded;
  FaultCodeDetails(
      {this.faultCodeIdentifier,
      this.faultCodeType,
      this.faultDescription,
      this.isExpanded = false});

  factory FaultCodeDetails.fromJson(Map<String, dynamic> json) =>
      _$FaultCodeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FaultCodeDetailsToJson(this);
}
