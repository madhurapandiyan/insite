import 'package:json_annotation/json_annotation.dart';
part 'asset_settings_data.g.dart';

@JsonSerializable()
class AssetSettingsData{

final List<dynamic> assetUids;

AssetSettingsData({this.assetUids});
 factory AssetSettingsData.fromJson(Map<String, dynamic> json) =>
      _$AssetSettingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$AssetSettingsDataToJson(this);
}