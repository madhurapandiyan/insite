import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/links.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../views/adminstration/add_group/asset_selection_widget/asset_selection_widget_view_model.dart';
part 'asset_group_summary_response.g.dart';

@JsonSerializable()
class AssetGroupSummaryResponse {
  Pagination? pagination;
  Links? links;
  List<Asset>? assetDetailsRecords;

  AssetGroupSummaryResponse(
      {this.pagination, this.links, this.assetDetailsRecords});

  factory AssetGroupSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetGroupSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetGroupSummaryResponseToJson(this);
}

@JsonSerializable()
class Asset {
  String? assetIdentifier;
  String? assetSerialNumber;
  String? makeCode;
  String? model;
  int? assetIcon;
  String? assetId;
  @JsonKey(ignore: true)
  AssetCategoryType? type;

  Asset(
      {this.assetIdentifier,
      this.assetSerialNumber,
      this.makeCode,
      this.model,
      this.assetIcon,
      this.assetId,this.type});

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
