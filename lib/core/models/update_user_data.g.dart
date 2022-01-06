// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateResponse _$UpdateResponseFromJson(Map<String, dynamic> json) =>
    UpdateResponse(
      isUpdated: json['isUpdated'] as bool?,
    );

Map<String, dynamic> _$UpdateResponseToJson(UpdateResponse instance) =>
    <String, dynamic>{
      'isUpdated': instance.isUpdated,
    };

DeleteUserData _$DeleteUserDataFromJson(Map<String, dynamic> json) =>
    DeleteUserData(
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DeleteUserDataToJson(DeleteUserData instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

DeleteUserDataIndStack _$DeleteUserDataIndStackFromJson(
        Map<String, dynamic> json) =>
    DeleteUserDataIndStack(
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      customerUid: json['customerUid'] as String?,
    );

Map<String, dynamic> _$DeleteUserDataIndStackToJson(
        DeleteUserDataIndStack instance) =>
    <String, dynamic>{
      'users': instance.users,
      'customerUid': instance.customerUid,
    };

AddUserData _$AddUserDataFromJson(Map<String, dynamic> json) => AddUserData(
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      cwsEmail: json['cwsEmail'] as String?,
      sso_id: json['sso_id'] as String?,
      phone: json['phone'] as String?,
      isCATSSOUserCreation: json['isCATSSOUserCreation'] as bool?,
      address: json['address'] == null
          ? null
          : AddressData.fromJson(json['address'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      src: json['src'] as String?,
      company: json['company'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$AddUserDataToJson(AddUserData instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'cwsEmail': instance.cwsEmail,
      'phone': instance.phone,
      'sso_id': instance.sso_id,
      'company': instance.company,
      'isCATSSOUserCreation': instance.isCATSSOUserCreation,
      'address': instance.address,
      'details': instance.details,
      'roles': instance.roles,
      'src': instance.src,
      'language': instance.language,
    };

AddUserDataIndStack _$AddUserDataIndStackFromJson(Map<String, dynamic> json) =>
    AddUserDataIndStack(
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : AddressData.fromJson(json['address'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      src: json['src'] as String?,
      isAssetSecurityEnabled: json['isAssetSecurityEnabled'] as bool?,
      company: json['company'] as String?,
      language: json['language'] as String?,
      customerUid: json['customerUid'] as String?,
    );

Map<String, dynamic> _$AddUserDataIndStackToJson(
        AddUserDataIndStack instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'address': instance.address,
      'details': instance.details,
      'roles': instance.roles,
      'src': instance.src,
      'language': instance.language,
      'customerUid': instance.customerUid,
      'isAssetSecurityEnabled': instance.isAssetSecurityEnabled,
    };

UpdateUserData _$UpdateUserDataFromJson(Map<String, dynamic> json) =>
    UpdateUserData(
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      cwsEmail: json['cwsEmail'] as String?,
      sso_id: json['sso_id'] as String?,
      phone: json['phone'] as String?,
      isCatssoUserCreation: json['isCatssoUserCreation'] as bool?,
      address: json['address'] == null
          ? null
          : AddressData.fromJson(json['address'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      src: json['src'] as String?,
      company: json['company'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$UpdateUserDataToJson(UpdateUserData instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'cwsEmail': instance.cwsEmail,
      'phone': instance.phone,
      'sso_id': instance.sso_id,
      'isCatssoUserCreation': instance.isCatssoUserCreation,
      'address': instance.address,
      'details': instance.details,
      'roles': instance.roles,
      'src': instance.src,
      'company': instance.company,
      'language': instance.language,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      addressline1: json['addressline1'] as String?,
      addressline2: json['addressline2'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      zipcode: json['zipcode'] as String?,
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'addressline1': instance.addressline1,
      'addressline2': instance.addressline2,
      'country': instance.country,
      'state': instance.state,
      'zipcode': instance.zipcode,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      job_title: json['job_title'] as String?,
      job_type: json['job_type'] as String?,
      user_type: json['user_type'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'job_title': instance.job_title,
      'job_type': instance.job_type,
      'user_type': instance.user_type,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      role_id: json['role_id'] as int?,
      application_name: json['application_name'] as String?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'role_id': instance.role_id,
      'application_name': instance.application_name,
    };
