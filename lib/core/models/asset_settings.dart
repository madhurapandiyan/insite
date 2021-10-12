import 'package:json_annotation/json_annotation.dart';
part 'asset_settings.g.dart';

@JsonSerializable()
class ManageAssetConfiguration {
  ManageAssetConfiguration({
    this.assetSettings,
    this.pageInfo,
  });

  List<AssetSetting> assetSettings;
  PageInfo pageInfo;

  factory ManageAssetConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ManageAssetConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ManageAssetConfigurationToJson(this);
}

@JsonSerializable()
class AssetSetting {
  AssetSetting({
    this.assetUid,
    this.assetId,
    this.assetSerialNumber,
    this.assetModel,
    this.assetMakeCode,
    this.assetIconKey,
    this.deviceSerialNumber,
    this.devicetype,
    this.targetStatus,
    this.hoursMeter,
    this.movingOrStoppedThreshold,
    this.movingThresholdsDuration,
    this.movingThresholdsRadius,
    this.odometer,
    this.workDefinition,
    this.configuredSwitches,
    this.totalSwitches,
  });

  String assetUid;
  dynamic assetId;
  String assetSerialNumber;
  String assetModel;
  String assetMakeCode;
  int assetIconKey;
  String deviceSerialNumber;
  String devicetype;
  bool targetStatus;
  double hoursMeter;
  double movingOrStoppedThreshold;
  int movingThresholdsDuration;
  double movingThresholdsRadius;
  double odometer;
  int workDefinition;
  int configuredSwitches;
  int totalSwitches;

  factory AssetSetting.fromJson(Map<String, dynamic> json) =>
      _$AssetSettingFromJson(json);
  Map<String, dynamic> toJson() => _$AssetSettingToJson(this);
}

@JsonSerializable()
class PageInfo {
  PageInfo({
    this.totalRecords,
    this.totalPages,
    this.currentPageNumber,
    this.currentPageSize,
  });

  int totalRecords;
  int totalPages;
  int currentPageNumber;
  int currentPageSize;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}
