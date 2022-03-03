// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_group_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageGroupSummaryResponse _$ManageGroupSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    ManageGroupSummaryResponse(
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => Groups.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageGroupSummaryResponseToJson(
        ManageGroupSummaryResponse instance) =>
    <String, dynamic>{
      'links': instance.links,
      'total': instance.total,
      'groups': instance.groups,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      next: json['next'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'next': instance.next,
      'last': instance.last,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      items: json['items'] as int?,
      pages: json['pages'] as int?,
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'items': instance.items,
      'pages': instance.pages,
    };

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      GroupUid: json['GroupUid'] as String?,
      GroupName: json['GroupName'] as String?,
      Description: json['Description'] as String?,
      IsFavourite: json['IsFavourite'] as bool?,
      createdOnUTC: json['createdOnUTC'] as String?,
      CreatedByUserName: json['CreatedByUserName'] as String?,
      AssetUID: (json['AssetUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'GroupUid': instance.GroupUid,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
      'IsFavourite': instance.IsFavourite,
      'createdOnUTC': instance.createdOnUTC,
      'CreatedByUserName': instance.CreatedByUserName,
      'AssetUID': instance.AssetUID,
    };