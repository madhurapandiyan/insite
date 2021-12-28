import 'package:json_annotation/json_annotation.dart';
part 'permission.g.dart';

@JsonSerializable()
class Permission {
  final double? permission_id;
  final String? action;
  final String? resource;
  final String? provider_id;
  Permission(
      {this.permission_id, this.action, this.resource, this.provider_id});
  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}

@JsonSerializable()
class PermissionResponse {
  final List<Permission>? permission_list;
  PermissionResponse({this.permission_list});
  factory PermissionResponse.fromJson(Map<String, dynamic> json) =>
      _$PermissionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionResponseToJson(this);
}
