import 'package:json_annotation/json_annotation.dart';
part 'fuel_level.g.dart';

@JsonSerializable()
class FuelLevelData {
  List<CountDatum>? countData;

  FuelLevelData({
    this.countData,
  });

  factory FuelLevelData.fromJson(Map<String, dynamic> json) =>
      _$FuelLevelDataFromJson(json);

  Map<String, dynamic> toJson() => _$FuelLevelDataToJson(this);
}

@JsonSerializable()
class CountDatum {
  String? countOf;
  int? count;
  CountDatum({
    this.countOf,
    this.count,
  });

  factory CountDatum.fromJson(Map<String, dynamic> json) =>
      _$CountDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CountDatumToJson(this);
}
