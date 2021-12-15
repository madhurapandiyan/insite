// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserResponse _$CheckUserResponseFromJson(Map<String, dynamic> json) {
  return CheckUserResponse(
    isMultiUserAccount: json['isMultiUserAccount'] as bool,
    isUserExists: json['isUserExists'] as bool,
    users: (json['users'] as List)
        ?.map(
            (e) => e == null ? null : Users.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckUserResponseToJson(CheckUserResponse instance) =>
    <String, dynamic>{
      'isMultiUserAccount': instance.isMultiUserAccount,
      'isUserExists': instance.isUserExists,
      'users': instance.users,
    };
