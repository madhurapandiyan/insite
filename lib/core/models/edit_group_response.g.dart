// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditGroupResponse _$EditGroupResponseFromJson(Map<String, dynamic> json) =>
    EditGroupResponse(
      GroupUid: json['GroupUid'] as String?,
      GroupName: json['GroupName'] as String?,
      AssetUID:
          (json['AssetUID'] as List<dynamic>).map((e) => e as String).toList(),
      CustomerUID: json['CustomerUID'] as String?,
      Description: json['Description'] as String?,
    );

Map<String, dynamic> _$EditGroupResponseToJson(EditGroupResponse instance) =>
    <String, dynamic>{
      'GroupUid': instance.GroupUid,
      'GroupName': instance.GroupName,
      'AssetUID': instance.AssetUID,
      'CustomerUID': instance.CustomerUID,
      'Description': instance.Description,
    };
