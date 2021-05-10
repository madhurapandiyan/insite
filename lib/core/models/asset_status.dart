import 'package:json_annotation/json_annotation.dart';
part 'asset_status.g.dart';


@JsonSerializable()
class AssetStatus {
  AssetStatus({
    this.countData,
  });

  List<CountDatum> countData;

  factory AssetStatus.fromJson(Map<String, dynamic> json) =>
      _$AssetStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AssetStatusToJson(this);
}


@JsonSerializable()
class CountDatum {
  CountDatum({
    this.countOf,
    this.count,
  });

  String countOf;
  int count;

  factory CountDatum.fromJson(Map<String, dynamic> json) =>
      _$CountDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CountDatumToJson(this);
}
