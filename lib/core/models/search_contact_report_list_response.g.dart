// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_contact_report_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchContactReportListResponse _$SearchContactReportListResponseFromJson(
        Map<String, dynamic> json) =>
    SearchContactReportListResponse(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchContactReportListResponseToJson(
        SearchContactReportListResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'pageInfo': instance.pageInfo,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      email: json['email'] as String?,
      isVLUser: json['isVLUser'] as bool?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'isVLUser': instance.isVLUser,
      'isSelected': instance.isSelected,
    };
