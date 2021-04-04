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
