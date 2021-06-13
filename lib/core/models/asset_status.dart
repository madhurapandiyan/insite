import 'package:json_annotation/json_annotation.dart';
part 'asset_status.g.dart';

@JsonSerializable()
class AssetCountData {
  List<CountData> countData;
  AssetCountData({
    this.countData,
  });

  factory AssetCountData.fromJson(Map<String, dynamic> json) =>
      _$AssetCountDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetCountDataToJson(this);
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
