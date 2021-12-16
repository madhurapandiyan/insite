import 'package:json_annotation/json_annotation.dart';
part 'plant_heirarchy.g.dart';

@JsonSerializable()
class HierarchyAssets {
  List<List<Result>>? result;
  HierarchyAssets({this.result});
  factory HierarchyAssets.fromJson(Map<String, dynamic> json) =>
      _$HierarchyAssetsFromJson(json);
  Map<String, dynamic> toJson() => _$HierarchyAssetsToJson(this);
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
