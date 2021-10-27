import 'package:json_annotation/json_annotation.dart';
part 'idling_level.g.dart';

@JsonSerializable()
class IdlingLevelData {
  List<CountDatum> countData;
  IdlingLevelData({
    this.countData,
  });

  factory IdlingLevelData.fromJson(Map<String, dynamic> json) =>
      _$IdlingLevelDataFromJson(json);

  Map<String, dynamic> toJson() => _$IdlingLevelDataToJson(this);
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
