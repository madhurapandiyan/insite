import 'package:json_annotation/json_annotation.dart';
part 'estimated_asset_setting.g.dart';

@JsonSerializable()
class EstimatedAssetSetting {
  List<AssetTargetSettings>? assetTargetSettings;

  EstimatedAssetSetting({this.assetTargetSettings});

  factory EstimatedAssetSetting.fromJson(Map<String, dynamic> json) =>
      _$EstimatedAssetSettingFromJson(json);

  Map<String, dynamic> toJson() => _$EstimatedAssetSettingToJson(this);
}

@JsonSerializable()
class AssetTargetSettings {
  Runtime? runtime;
  Idle? idle;
  String? startDate;
  String? endDate;
  String? assetUid;

  AssetTargetSettings(
      {this.runtime, this.idle, this.startDate, this.endDate, this.assetUid});

  factory AssetTargetSettings.fromJson(Map<String, dynamic> json) =>
      _$AssetTargetSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetTargetSettingsToJson(this);
}

@JsonSerializable()
class Runtime {
  double? sunday;
  double? monday;
  double? tuesday;
  double? wednesday;
  double? thursday;
  double? friday;
  double? saturday;

  Runtime(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  factory Runtime.fromJson(Map<String, dynamic> json) =>
      _$RuntimeFromJson(json);

  Map<String, dynamic> toJson() => _$RuntimeToJson(this);
}

@JsonSerializable()
class Idle {
  double? sunday;
  double? monday;
  double? tuesday;
  double? wednesday;
  double? thursday;
  double? friday;
  double? saturday;

  Idle(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  factory Idle.fromJson(Map<String, dynamic> json) => _$IdleFromJson(json);

  Map<String, dynamic> toJson() => _$IdleToJson(this);
}
