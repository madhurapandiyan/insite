// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_group_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditGroupPayLoad _$EditGroupPayLoadFromJson(Map<String, dynamic> json) =>
    EditGroupPayLoad(
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

Map<String, dynamic> _$EditGroupPayLoadToJson(EditGroupPayLoad instance) =>
    <String, dynamic>{
      'GroupUid': instance.GroupUid,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
      'CustomerUID': instance.CustomerUID,
      'AssociatedAssetUID': instance.AssociatedAssetUID,
      'DissociatedAssetUID': instance.DissociatedAssetUID,
    };
