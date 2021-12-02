// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetRegistrationSearchModel _$SingleAssetRegistrationSearchModelFromJson(
    Map<String, dynamic> json) {
  return SingleAssetRegistrationSearchModel(
    code: json['code'] as String,
    status: json['status'] as String,
    result: (json['result'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : HierarchyModel.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleAssetRegistrationSearchModelToJson(
        SingleAssetRegistrationSearchModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

HierarchyModel _$HierarchyModelFromJson(Map<String, dynamic> json) {
  return HierarchyModel(
    ID: json['ID'] as int,
    Name: json['Name'] as String,
    UserName: json['UserName'] as String,
    Email: json['Email'] as String,
    Code: json['Code'] as String,
  );
}

Map<String, dynamic> _$HierarchyModelToJson(HierarchyModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'UserName': instance.UserName,
      'Email': instance.Email,
      'Code': instance.Code,
    };
