// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupSummaryResponse _$GroupSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GroupSummaryResponse(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      assetDetailsRecords: (json['assetDetailsRecords'] as List<dynamic>?)
          ?.map((e) => AssetDetailsRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupSummaryResponseToJson(
        GroupSummaryResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'links': instance.links,
      'assetDetailsRecords': instance.assetDetailsRecords,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalCount: json['totalCount'] as int?,
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      self: json['self'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
    };

AssetDetailsRecords _$AssetDetailsRecordsFromJson(Map<String, dynamic> json) =>
    AssetDetailsRecords(
      assetIdentifier: json['assetIdentifier'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      assetIcon: json['assetIcon'] as int?,
      assetId: json['assetId'] as String?,
    );

Map<String, dynamic> _$AssetDetailsRecordsToJson(
        AssetDetailsRecords instance) =>
    <String, dynamic>{
      'assetIdentifier': instance.assetIdentifier,
      'assetSerialNumber': instance.assetSerialNumber,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'assetIcon': instance.assetIcon,
      'assetId': instance.assetId,
    };
