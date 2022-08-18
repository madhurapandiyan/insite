import 'package:json_annotation/json_annotation.dart';
part 'plant_heirarchy.g.dart';

@JsonSerializable()
class HierarchyAssets {
  List<List<Result>>? result;
  PlantHierarchyDetails? plantHierarchyDetails;
  HierarchyAssets({this.result, this.plantHierarchyDetails});
  factory HierarchyAssets.fromJson(Map<String, dynamic> json) =>
      _$HierarchyAssetsFromJson(json);
  Map<String, dynamic> toJson() => _$HierarchyAssetsToJson(this);
}

@JsonSerializable()
class PlantHierarchyDetails {
  int? totalAssetCount;
  int? totalCustomerCount;
  int? totalDealerCount;
  int? totalPlantCount;

  PlantHierarchyDetails(
      {this.totalAssetCount,
      this.totalCustomerCount,
      this.totalDealerCount,
      this.totalPlantCount});

       factory PlantHierarchyDetails.fromJson(Map<String, dynamic> json) =>
      _$PlantHierarchyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PlantHierarchyDetailsToJson(this);

}

@JsonSerializable()
class Result {
  // to diplay key name as displayed on endpoint.
  @JsonKey(name: "Customer_Count")
  int? customerCount;

  @JsonKey(name: "Dealer_Count")
  int? dealerCount;

  @JsonKey(name: "Plant_Count")
  int? plantCount;

  @JsonKey(name: "TotelAssets")
  int? totalAssets;

  Result(
      {this.customerCount,
      this.dealerCount,
      this.plantCount,
      this.totalAssets});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
