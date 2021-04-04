// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    pagination: json['pagination'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };

AssetPagination _$AssetPaginationFromJson(Map<String, dynamic> json) {
  return AssetPagination(
    pageNumber: json['pageNumber'] as int,
    totalAssets: json['totalAssets'] as int,
    pageSize: json['pageSize'] as int,
    assetsWithoutActiveCoreSubscription:
        json['assetsWithoutActiveCoreSubscription'] as int,
  );
}

Map<String, dynamic> _$AssetPaginationToJson(AssetPagination instance) =>
    <String, dynamic>{
      'assetsWithoutActiveCoreSubscription':
          instance.assetsWithoutActiveCoreSubscription,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalAssets': instance.totalAssets,
    };
