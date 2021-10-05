// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateResponse _$UpdateResponseFromJson(Map<String, dynamic> json) {
  return UpdateResponse(
    isUpdated: json['isUpdated'] as bool,
  );
}

Map<String, dynamic> _$UpdateResponseToJson(UpdateResponse instance) =>
    <String, dynamic>{
      'isUpdated': instance.isUpdated,
    };

UpdateUserData _$UpdateUserDataFromJson(Map<String, dynamic> json) {
  return UpdateUserData(
    fname: json['fname'] as String,
    lname: json['lname'] as String,
    email: json['email'] as String,
    isCatssoUserCreation: json['isCatssoUserCreation'] as bool,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    details: json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>),
    roles: (json['roles'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    src: json['src'] as String,
  );
}

Map<String, dynamic> _$UpdateUserDataToJson(UpdateUserData instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'isCatssoUserCreation': instance.isCatssoUserCreation,
      'address': instance.address,
      'details': instance.details,
      'roles': instance.roles,
      'src': instance.src,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address();
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{};

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details(
    jobTitle: json['jobTitle'] as String,
    jobType: json['jobType'] as String,
    userType: json['userType'] as String,
  );
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'jobType': instance.jobType,
      'userType': instance.userType,
    };

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    roleId: json['roleId'] as int,
    applicationName: json['applicationName'] as String,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'roleId': instance.roleId,
      'applicationName': instance.applicationName,
    };
