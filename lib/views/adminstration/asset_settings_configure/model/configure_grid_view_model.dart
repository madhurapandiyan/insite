import 'package:json_annotation/json_annotation.dart';
part 'configure_grid_view_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetListSettings {
  final List<AssetListSettingsData>? assetListSettings;
  AssetListSettings({this.assetListSettings});

  factory AssetListSettings.fromJson(Map<String, dynamic> json) =>
      _$AssetListSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetListSettingsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AssetListSettingsData {
  final String? assetUID;
  final String? assetName;
  final String? assetTypeName;
  final String? makeCode;
  final String? model;
  final int? modelYear;
  final bool? statusInd;
  final String? serialNumber;
  final String? equipmentVIN;
  final int? legacyAssetID;
  final int? iconKey;
  AssetListSettingsData(
      {this.assetUID,
      this.assetName,
      this.assetTypeName,
      this.equipmentVIN,
      this.iconKey,
      this.makeCode,
      this.model,
      this.serialNumber,
      this.statusInd,
      this.legacyAssetID,
      this.modelYear});

  factory AssetListSettingsData.fromJson(Map<String, dynamic> json) =>
      _$AssetListSettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetListSettingsDataToJson(this);
}

class ConfigureGridViewModel {
  final String? image;
  final String? modelName;
  final dynamic assetIconKey;
  ConfigureGridViewModel({this.image, this.modelName, this.assetIconKey});
}
