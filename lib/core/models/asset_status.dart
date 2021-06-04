import 'package:json_annotation/json_annotation.dart';
part 'asset_status.g.dart';

@JsonSerializable()
class AssetStatusData {
  List<CountData> countData;
  AssetStatusData({
    this.countData,
  });

  factory AssetStatusData.fromJson(Map<String, dynamic> json) =>
      _$AssetStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetStatusDataToJson(this);
}

@JsonSerializable()
class CountData {
  String countOf;
  int count;
  CountData({
    this.countOf,
    this.count,
  });

  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountDataToJson(this);
}
