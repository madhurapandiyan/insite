// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_manage_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminManageUser _$AdminManageUserFromJson(Map<String, dynamic> json) {
  return AdminManageUser(
    users: (json['users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    total: json['total'] == null
        ? null
        : Total.fromJson(json['total'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdminManageUserToJson(AdminManageUser instance) =>
    <String, dynamic>{
      'users': instance.users,
      'links': instance.links,
      'total': instance.total,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    loginId: json['loginId'] as String,
    job_type: json['job_type'] as String,
    user_type: json['user_type'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'loginId': instance.loginId,
      'job_type': instance.job_type,
      'user_type': instance.user_type,
    };

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    last: json['last'] as String,
    next: json['next'] as String,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'next': instance.next,
      'last': instance.last,
    };

Total _$TotalFromJson(Map<String, dynamic> json) {
  return Total(
    items: json['items'] as int,
    pages: json['pages'] as int,
  );
}

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'items': instance.items,
      'pages': instance.pages,
    };
