import 'package:json_annotation/json_annotation.dart';
part 'asset_fuel_burn_rate_settings_list_data.g.dart';

@JsonSerializable()
class AssetFuelBurnRateSettingsListData {
  List<AssetFuelBurnRateSettings>? assetFuelBurnRateSettings;
  

  AssetFuelBurnRateSettingsListData(
      {this.assetFuelBurnRateSettings});

 factory AssetFuelBurnRateSettingsListData.fromJson(Map<String, dynamic> json)=>_$AssetFuelBurnRateSettingsListDataFromJson(json);

  Map<String, dynamic> toJson()=>_$AssetFuelBurnRateSettingsListDataToJson(this); 
}

@JsonSerializable()
class AssetFuelBurnRateSettings {
  double? idleTargetValue;
  double? workTargetValue;
  String? startDate;
  String? assetUid;

  AssetFuelBurnRateSettings(
      {this.idleTargetValue,
      this.workTargetValue,
      this.startDate,
      this.assetUid});

 factory AssetFuelBurnRateSettings.fromJson(Map<String, dynamic> json)=>_$AssetFuelBurnRateSettingsFromJson(json); 
  Map<String, dynamic> toJson() =>_$AssetFuelBurnRateSettingsToJson(this);
}