// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_manage_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminManageUser _$AdminManageUserFromJson(Map<String, dynamic> json) =>
    AdminManageUser(
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminManageUserToJson(AdminManageUser instance) =>
    <String, dynamic>{
      'links': instance.links,
      'total': instance.total,
      'users': instance.users,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      next: json['next'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'next': instance.next,
      'last': instance.last,
      'prev': instance.prev,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      items: json['items'] as int?,
      pages: json['pages'] as int?,
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'items': instance.items,
      'pages': instance.pages,
    };

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      userUid: json['userUid'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      loginId: json['loginId'] as String?,
      job_type: json['job_type'] as String?,
      job_title: json['job_title'] as String?,
      user_type: json['user_type'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      application_access: (json['application_access'] as List<dynamic>?)
          ?.map((e) => ApplicationAccess.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdOn: json['createdOn'] as String?,
      lastLoginDate: json['lastLoginDate'] as String?,
      createdBy: json['createdBy'] as String?,
      emailVerified: json['emailVerified'] as String?,
      phone: json['phone'] as String?,
    )..invitationUID = json['invitationUID'] as String?;

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'userUid': instance.userUid,
      'invitationUID': instance.invitationUID,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'loginId': instance.loginId,
      'job_type': instance.job_type,
      'job_title': instance.job_title,
      'user_type': instance.user_type,
      'address': instance.address,
      'application_access': instance.application_access,
      'createdOn': instance.createdOn,
      'lastLoginDate': instance.lastLoginDate,
      'createdBy': instance.createdBy,
      'emailVerified': instance.emailVerified,
      'phone': instance.phone,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      country: json['country'] as String?,
      zipcode: json['zipcode'] as String?,
      city: json['city'] as String?,
      addressline1: json['addressline1'] as String?,
      addressline2: json['addressline2'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country': instance.country,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'state': instance.state,
      'addressline1': instance.addressline1,
      'addressline2': instance.addressline2,
    };

ApplicationAccess _$ApplicationAccessFromJson(Map<String, dynamic> json) =>
    ApplicationAccess(
      userUID: json['userUID'] as String?,
      role_name: json['role_name'] as String?,
      applicationIconUrl: json['applicationIconUrl'] as String?,
      applicationName: json['applicationName'] as String?,
    );

Map<String, dynamic> _$ApplicationAccessToJson(ApplicationAccess instance) =>
    <String, dynamic>{
      'userUID': instance.userUID,
      'role_name': instance.role_name,
      'applicationIconUrl': instance.applicationIconUrl,
      'applicationName': instance.applicationName,
    };

ApplicationAccessData _$ApplicationAccessDataFromJson(
        Map<String, dynamic> json) =>
    ApplicationAccessData(
      application: json['application'] == null
          ? null
          : Application.fromJson(json['application'] as Map<String, dynamic>),
      isSelected: json['isSelected'] as bool? ?? false,
      isPermissionSelected: json['isPermissionSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ApplicationAccessDataToJson(
        ApplicationAccessData instance) =>
    <String, dynamic>{
      'application': instance.application,
      'isSelected': instance.isSelected,
      'isPermissionSelected': instance.isPermissionSelected,
    };

ManageUser _$ManageUserFromJson(Map<String, dynamic> json) => ManageUser(
      user: json['user'] == null
          ? null
          : Users.fromJson(json['user'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageUserToJson(ManageUser instance) =>
    <String, dynamic>{
      'user': instance.user,
      'users': instance.users,
    };
