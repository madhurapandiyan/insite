// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      permission_id: (json['permission_id'] as num?)?.toDouble(),
      action: json['action'] as String?,
      resource: json['resource'] as String?,
      provider_id: json['provider_id'] as String?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'permission_id': instance.permission_id,
      'action': instance.action,
      'resource': instance.resource,
      'provider_id': instance.provider_id,
    };

PermissionResponse _$PermissionResponseFromJson(Map<String, dynamic> json) =>
    PermissionResponse(
      permission_list: (json['permission_list'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PermissionResponseToJson(PermissionResponse instance) =>
    <String, dynamic>{
      'permission_list': instance.permission_list,
    };
