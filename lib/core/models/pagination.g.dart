// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      pagination: json['pagination'] as int?,
      assetsWithoutActiveCoreSubscription:
          json['assetsWithoutActiveCoreSubscription'] as int?,
      totalAssets: json['totalAssets'] as int?,
      totalCount: (json['totalCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalAssets': instance.totalAssets,
      'assetsWithoutActiveCoreSubscription':
          instance.assetsWithoutActiveCoreSubscription,
    };
