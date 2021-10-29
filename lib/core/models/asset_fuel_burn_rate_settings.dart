import 'package:json_annotation/json_annotation.dart';
part 'asset_fuel_burn_rate_settings.g.dart';


@JsonSerializable()
class AddSettings {
    AddSettings({
        this.assetFuelBurnRateSettings,
        this.errors,
        
    });

    List<AssetFuelBurnRateSetting> assetFuelBurnRateSettings;
    List<dynamic> errors;
 

    factory AddSettings.fromJson(Map<String, dynamic> json) => _$AddSettingsFromJson(json);

    Map<String, dynamic> toJson() =>_$AddSettingsToJson(this); 
}

@JsonSerializable()
class AssetFuelBurnRateSetting {
    AssetFuelBurnRateSetting({
        this.idleTargetValue,
        this.workTargetValue,
        this.startDate,
        this.assetUIds
       
    });
    
    double idleTargetValue;
    double workTargetValue;
    DateTime startDate;
      List< String> assetUIds;
  

    factory AssetFuelBurnRateSetting.fromJson(Map<String, dynamic> json) => _$AssetFuelBurnRateSettingFromJson(json);

    Map<String, dynamic> toJson() => _$AssetFuelBurnRateSettingToJson(this);
}
