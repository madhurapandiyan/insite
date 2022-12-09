// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierachy_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDataValues _$DeviceDataValuesFromJson(Map<String, dynamic> json) =>
    DeviceDataValues(
      assetOrHierarchyByTypeAndId: (json['assetOrHierarchyByTypeAndId']
              as List<dynamic>?)
          ?.map((e) =>
              AssetOrHierarchyByTypeAndId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceDataValuesToJson(DeviceDataValues instance) =>
    <String, dynamic>{
      'assetOrHierarchyByTypeAndId': instance.assetOrHierarchyByTypeAndId,
    };

AssetOrHierarchyByTypeAndId _$AssetOrHierarchyByTypeAndIdFromJson(
        Map<String, dynamic> json) =>
    AssetOrHierarchyByTypeAndId(
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      code: json['code'] as String?,
      sTypename: json['sTypename'] as String?,
    );

Map<String, dynamic> _$AssetOrHierarchyByTypeAndIdToJson(
        AssetOrHierarchyByTypeAndId instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userName': instance.userName,
      'email': instance.email,
      'code': instance.code,
      'sTypename': instance.sTypename,
    };
