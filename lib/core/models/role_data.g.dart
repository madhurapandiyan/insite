// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleData _$RoleDataFromJson(Map<String, dynamic> json) => RoleData(
      description: json['description'] as String?,
      provider_id: json['provider_id'] as String?,
      role_id: json['role_id'] as int?,
      role_name: json['role_name'] as String?,
    );

Map<String, dynamic> _$RoleDataToJson(RoleData instance) => <String, dynamic>{
      'role_name': instance.role_name,
      'role_id': instance.role_id,
      'provider_id': instance.provider_id,
      'description': instance.description,
    };

RoleDataResponse _$RoleDataResponseFromJson(Map<String, dynamic> json) =>
    RoleDataResponse(
      role_list: (json['role_list'] as List<dynamic>?)
          ?.map((e) => RoleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleDataResponseToJson(RoleDataResponse instance) =>
    <String, dynamic>{
      'role_list': instance.role_list,
    };
