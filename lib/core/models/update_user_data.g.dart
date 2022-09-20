// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateResponse _$UpdateResponseFromJson(Map<String, dynamic> json) =>
    UpdateResponse(
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$UpdateResponseToJson(UpdateResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isDeleted', instance.isDeleted);
  return val;
}

DeleteUserData _$DeleteUserDataFromJson(Map<String, dynamic> json) =>
    DeleteUserData(
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DeleteUserDataToJson(DeleteUserData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users', instance.users);
  return val;
}

DeleteUserDataIndStack _$DeleteUserDataIndStackFromJson(
        Map<String, dynamic> json) =>
    DeleteUserDataIndStack(
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      customerUid: json['customerUid'] as String?,
    );

Map<String, dynamic> _$DeleteUserDataIndStackToJson(
    DeleteUserDataIndStack instance) {
  final val = <String, dynamic>{
    'users': instance.users,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('customerUid', instance.customerUid);
  return val;
}

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

Map<String, dynamic> _$AddUserDataToJson(AddUserData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fname', instance.fname);
  writeNotNull('lname', instance.lname);
  writeNotNull('cwsEmail', instance.cwsEmail);
  writeNotNull('phone', instance.phone);
  writeNotNull('sso_id', instance.sso_id);
  writeNotNull('company', instance.company);
  writeNotNull('isCATSSOUserCreation', instance.isCATSSOUserCreation);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('details', instance.details?.toJson());
  writeNotNull('roles', instance.roles?.map((e) => e.toJson()).toList());
  writeNotNull('src', instance.src);
  writeNotNull('language', instance.language);
  return val;
}

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

Map<String, dynamic> _$AddUserDataIndStackToJson(AddUserDataIndStack instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fname', instance.fname);
  writeNotNull('lname', instance.lname);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('company', instance.company);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('details', instance.details?.toJson());
  writeNotNull('roles', instance.roles?.map((e) => e.toJson()).toList());
  writeNotNull('src', instance.src);
  writeNotNull('language', instance.language);
  writeNotNull('customerUid', instance.customerUid);
  writeNotNull('isAssetSecurityEnabled', instance.isAssetSecurityEnabled);
  return val;
}

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
      JobType: json['JobType'] as int?,
      customerUid: json['customerUid'] as String?,
      email: json['email'] as String?,
      isAssetSecurityEnabled: json['isAssetSecurityEnabled'] as bool?,
    );

Map<String, dynamic> _$UpdateUserDataToJson(UpdateUserData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fname', instance.fname);
  writeNotNull('lname', instance.lname);
  writeNotNull('cwsEmail', instance.cwsEmail);
  writeNotNull('phone', instance.phone);
  writeNotNull('sso_id', instance.sso_id);
  writeNotNull('isCatssoUserCreation', instance.isCatssoUserCreation);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('details', instance.details?.toJson());
  writeNotNull('roles', instance.roles?.map((e) => e.toJson()).toList());
  writeNotNull('src', instance.src);
  writeNotNull('company', instance.company);
  writeNotNull('language', instance.language);
  writeNotNull('email', instance.email);
  writeNotNull('customerUid', instance.customerUid);
  writeNotNull('JobType', instance.JobType);
  writeNotNull('isAssetSecurityEnabled', instance.isAssetSecurityEnabled);
  return val;
}

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      addressline1: json['addressline1'] as String?,
      addressline2: json['addressline2'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      zipcode: json['zipcode'] as String?,
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('addressline1', instance.addressline1);
  writeNotNull('addressline2', instance.addressline2);
  writeNotNull('country', instance.country);
  writeNotNull('state', instance.state);
  writeNotNull('zipcode', instance.zipcode);
  return val;
}

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      job_title: json['job_title'] as String?,
      job_type: json['job_type'] as String?,
      user_type: json['user_type'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_title', instance.job_title);
  writeNotNull('job_type', instance.job_type);
  writeNotNull('user_type', instance.user_type);
  return val;
}

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      role_id: json['role_id'] as int?,
      application_name: json['application_name'] as String?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('role_id', instance.role_id);
  writeNotNull('application_name', instance.application_name);
  return val;
}
