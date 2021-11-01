import 'package:json_annotation/json_annotation.dart';
part 'estimated_cycle_volume_payload.g.dart';

@JsonSerializable()
class EstimatedCycleVolumePayLoad {
  List<AssetProductivitySettings> assetProductivitySettings;

  EstimatedCycleVolumePayLoad({this.assetProductivitySettings});

  factory EstimatedCycleVolumePayLoad.fromJson(Map<String, dynamic> json) =>
      _$EstimatedCycleVolumePayLoadFromJson(json);
  Map<String, dynamic> toJson() => _$EstimatedCycleVolumePayLoadToJson(this);
}

@JsonSerializable()
class AssetProductivitySettings {
  Cycles cycles;
  Volumes volumes;
  Cycles payload;
  String startDate;
  String endDate;
  String assetUid;

  AssetProductivitySettings(
      {this.cycles,
      this.volumes,
      this.payload,
      this.startDate,
      this.endDate,
      this.assetUid});

  factory AssetProductivitySettings.fromJson(Map<String, dynamic> json) =>
      _$AssetProductivitySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetProductivitySettingsToJson(this);
}

@JsonSerializable()
class Cycles {
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;

  Cycles(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  factory Cycles.fromJson(Map<String, dynamic> json) => _$CyclesFromJson(json);

  Map<String, dynamic> toJson() => _$CyclesToJson(this);
}

@JsonSerializable()
class Volumes {
  double sunday;
  double monday;
  double tuesday;
  double wednesday;
  double thursday;
  double friday;
  double saturday;

  Volumes(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  factory Volumes.fromJson(Map<String, dynamic> json) =>
      _$VolumesFromJson(json);

  Map<String, dynamic> toJson() => _$VolumesToJson(this);
}
