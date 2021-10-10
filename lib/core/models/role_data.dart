import 'package:json_annotation/json_annotation.dart';
part 'role_data.g.dart';

@JsonSerializable()
class RoleData {
  final String role_name;
  final int role_id;
  final String provider_id;
  final String description;
  RoleData({this.description, this.provider_id, this.role_id, this.role_name});

  factory RoleData.fromJson(Map<String, dynamic> json) =>
      _$RoleDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoleDataToJson(this);
}

@JsonSerializable()
class RoleDataResponse {
  final List<RoleData> role_list;
  RoleDataResponse({this.role_list});
  factory RoleDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoleDataResponseToJson(this);
}
