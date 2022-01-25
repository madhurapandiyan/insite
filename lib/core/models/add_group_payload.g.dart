// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddGroupPayLoad _$AddGroupPayLoadFromJson(Map<String, dynamic> json) =>
    AddGroupPayLoad(
      AssetUID: (json['AssetUID'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      GroupName: json['GroupName'] as String?,
      Description: json['Description'] as String?,
    );

Map<String, dynamic> _$AddGroupPayLoadToJson(AddGroupPayLoad instance) =>
    <String, dynamic>{
      'AssetUID': instance.AssetUID,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
    };
