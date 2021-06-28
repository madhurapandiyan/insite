import 'package:json_annotation/json_annotation.dart';
part 'asset_status.g.dart';

@JsonSerializable()
class AssetCount {
  List<Count> countData;
  AssetCount({
    this.countData,
  });

  factory AssetCount.fromJson(Map<String, dynamic> json) =>
      _$AssetCountFromJson(json);

  Map<String, dynamic> toJson() => _$AssetCountToJson(this);
}

@JsonSerializable()
class Count {
  String countOf;
  int count;
  Count({
    this.countOf,
    this.count,
  });

  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);

  Map<String, dynamic> toJson() => _$CountToJson(this);
}
