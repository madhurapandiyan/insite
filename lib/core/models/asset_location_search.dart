import 'package:insite/core/models/asset_location.dart';
import 'package:json_annotation/json_annotation.dart';
part 'asset_location_search.g.dart';

@JsonSerializable()
class AssetLocationSearch {
  AssetLocationData? assetLocation;
  AssetLocationSearch({this.assetLocation});
  factory AssetLocationSearch.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationSearchFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocationSearchToJson(this);
}
