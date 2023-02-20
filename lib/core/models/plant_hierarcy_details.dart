import 'package:json_annotation/json_annotation.dart';
part 'plant_hierarcy_details.g.dart';

@JsonSerializable()
class PlantHierarchyDetails {
  @JsonKey(name: "assetOrHierarchyByTypeAndId")
  List<AssetOrHierarchyByTypeAndIdDetail>? assetOrHierarchyByTypeAndIdDetail;
  PlantHierarchyDetails({this.assetOrHierarchyByTypeAndIdDetail});
  factory PlantHierarchyDetails.fromJson(Map<String, dynamic> json) =>
      _$PlantHierarchyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PlantHierarchyDetailsToJson(this);
}

@JsonSerializable()
class AssetOrHierarchyByTypeAndIdDetail {
    String? name;
    @JsonKey(name: "gpsDeviceID")
    String? gpsDeviceId;
    String? vin;
    String? model;
    String? productFamily;
    String? subscriptionStartDate;
    String? subscriptionEndDate;
    String? actualStartDate;
    String? typename;
  AssetOrHierarchyByTypeAndIdDetail({
    this.name, 
    this.gpsDeviceId,
    this.vin,
    this.model,
    this.productFamily,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.actualStartDate,
    this.typename
    });
  factory AssetOrHierarchyByTypeAndIdDetail.fromJson(Map<String, dynamic> json) =>
      _$AssetOrHierarchyByTypeAndIdDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOrHierarchyByTypeAndIdDetailToJson(this);
}