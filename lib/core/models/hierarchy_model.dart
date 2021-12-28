import 'package:json_annotation/json_annotation.dart';
part 'hierarchy_model.g.dart';

@JsonSerializable()
class SingleAssetRegistrationSearchModel {
  final String? code;
  final String? status;
  final List<List<HierarchyModel>>? result;

  SingleAssetRegistrationSearchModel({this.code, this.status, this.result});

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

  HierarchyModel({this.ID, this.Name, this.UserName, this.Email, this.Code});

  factory HierarchyModel.fromJson(Map<String, dynamic> json) =>
      _$HierarchyModelFromJson(json);

  Map<String, dynamic> toJson() => _$HierarchyModelToJson(this);
}
