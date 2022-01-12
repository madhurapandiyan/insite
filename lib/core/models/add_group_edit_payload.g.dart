// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_edit_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddGroupEditPayload _$AddGroupEditPayloadFromJson(Map<String, dynamic> json) =>
    AddGroupEditPayload(
      GroupUid: json['GroupUid'] as String?,
      GroupName: json['GroupName'] as String?,
      Description: json['Description'] as String?,
      CustomerUID: json['CustomerUID'] as String?,
      AssociatedAssetUID: (json['AssociatedAssetUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      DissociatedAssetUID: (json['DissociatedAssetUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AddGroupEditPayloadToJson(
        AddGroupEditPayload instance) =>
    <String, dynamic>{
      'GroupUid': instance.GroupUid,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
      'CustomerUID': instance.CustomerUID,
      'AssociatedAssetUID': instance.AssociatedAssetUID,
      'DissociatedAssetUID': instance.DissociatedAssetUID,
    };
