import 'package:json_annotation/json_annotation.dart';
part 'hierachy_graphql.g.dart';

@JsonSerializable()
class DeviceDataValues {
  List<AssetOrHierarchyByTypeAndId>? assetOrHierarchyByTypeAndId;

  DeviceDataValues({this.assetOrHierarchyByTypeAndId});

  factory DeviceDataValues.fromJson(Map<String, dynamic> json) =>
      _$DeviceDataValuesFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDataValuesToJson(this);
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
