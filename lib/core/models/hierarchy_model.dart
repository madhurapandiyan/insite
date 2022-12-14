import 'package:json_annotation/json_annotation.dart';
part 'hierarchy_model.g.dart';

@JsonSerializable()
class SingleAssetRegistrationSearchModel {
  final List<AssetOrHierarchyByTypeAndId>? assetOrHierarchyByTypeAndId;
  final String? code;
  final String? status;
  final List<List<HierarchyModel>>? result;

  SingleAssetRegistrationSearchModel({this.code, this.status, this.result,this.assetOrHierarchyByTypeAndId});

  factory SingleAssetRegistrationSearchModel.fromJson(
          Map<String, dynamic> json) =>
      _$SingleAssetRegistrationSearchModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SingleAssetRegistrationSearchModelToJson(this);
}

@JsonSerializable()
class HierarchyModel {
  final int? ID;
  final String? Name;
  final String? UserName;
  final String? Email;
  final String? Code;
  final int? count;

  HierarchyModel({this.ID, this.Name, this.UserName, this.Email, this.Code,this.count});

  factory HierarchyModel.fromJson(Map<String, dynamic> json) =>
      _$HierarchyModelFromJson(json);

  Map<String, dynamic> toJson() => _$HierarchyModelToJson(this);
}


@JsonSerializable()
class AssetOrHierarchyByTypeAndId {
  String? name;
  String? userName;
  String? email;
  String? code;
  String? sTypename;

  AssetOrHierarchyByTypeAndId(
      {this.name, this.userName, this.email, this.code, this.sTypename});
  factory AssetOrHierarchyByTypeAndId.fromJson(Map<String, dynamic> json) =>
      _$AssetOrHierarchyByTypeAndIdFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOrHierarchyByTypeAndIdToJson(this);
}
