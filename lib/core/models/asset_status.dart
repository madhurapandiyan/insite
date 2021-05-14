import 'package:json_annotation/json_annotation.dart';
part 'asset_status.g.dart';

@JsonSerializable()
class AssetStatusData {
  List<CountDatum> countData;
  AssetStatusData({
    this.countData,
  });

  factory AssetStatusData.fromJson(Map<String, dynamic> json) =>
      _$AssetStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetStatusDataToJson(this);
}

@JsonSerializable()
class CountDatum {
  String countOf;
  int count;
  CountDatum({
    this.countOf,
    this.count,
  });

  factory CountDatum.fromJson(Map<String, dynamic> json) =>
      _$CountDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CountDatumToJson(this);
}
