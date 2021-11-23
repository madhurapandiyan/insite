import 'package:json_annotation/json_annotation.dart';
part 'asset_mileage_settings_list_data.g.dart';

@JsonSerializable()
class AssetMileageSettingsListData {
  List<AssetMileageSettings> assetMileageSettings;
 

  AssetMileageSettingsListData({this.assetMileageSettings});

 factory AssetMileageSettingsListData.fromJson(Map<String, dynamic> json)=>_$AssetMileageSettingsListDataFromJson(json);

  Map<String, dynamic> toJson() =>_$AssetMileageSettingsListDataToJson(this);
}


@JsonSerializable()
class AssetMileageSettings {
  double targetValue;
  String startDate;
  String assetUid;

  AssetMileageSettings({this.targetValue, this.startDate, this.assetUid});

 factory AssetMileageSettings.fromJson(Map<String, dynamic> json) =>_$AssetMileageSettingsFromJson(json);
  Map<String, dynamic> toJson() =>_$AssetMileageSettingsToJson(this);
}