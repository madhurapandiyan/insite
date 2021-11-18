import 'package:json_annotation/json_annotation.dart';
part 'asset_icon_payload.g.dart';

@JsonSerializable()
class AssetIconPayLoad {
  String assetUID;
  int legacyAssetID;
  int iconKey;
  int modelYear;
  String actionUTC;

  AssetIconPayLoad(
      {this.assetUID,
      this.legacyAssetID,
      this.iconKey,
      this.modelYear,
      this.actionUTC});

  factory AssetIconPayLoad.fromJson(Map<String, dynamic> json) =>
      _$AssetIconPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$AssetIconPayLoadToJson(this);
}
