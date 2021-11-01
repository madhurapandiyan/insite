import 'package:json_annotation/json_annotation.dart';
part 'asset_mileage_settings.g.dart';

@JsonSerializable()
class AssetMileageSettingData {
  List<String> assetUIds;
  double targetValue;

  AssetMileageSettingData({this.assetUIds, this.targetValue});

 factory AssetMileageSettingData.fromJson(Map<String, dynamic> json)=>_$AssetMileageSettingDataFromJson(json);

  Map<String, dynamic> toJson() =>_$AssetMileageSettingDataToJson(this);
}