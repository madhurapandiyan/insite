import 'package:json_annotation/json_annotation.dart';
part 'single_asset_fault_response.g.dart';

@JsonSerializable()
class SingleAssetFaultResponse {
 final List<SummaryData> summaryData;
  SingleAssetFaultResponse({this.summaryData});

  factory SingleAssetFaultResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetFaultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleAssetFaultResponseToJson(this);
}

@JsonSerializable()
class SummaryData {
  final List<CountData> countData;
  SummaryData({this.countData});
  factory SummaryData.fromJson(Map<String, dynamic> json) =>
      _$SummaryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryDataToJson(this);
}

@JsonSerializable()
class CountData {
  String countOf;
  int assetCount;
  int faultCount;

  CountData({this.countOf, this.assetCount, this.faultCount});

  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountDataToJson(this);
}
