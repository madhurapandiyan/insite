import 'package:json_annotation/json_annotation.dart';
part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  final int? pagination;
  final int? pageNumber;
  final int? pageSize;
  final double? totalCount;
  final int? totalAssets;
  final int? assetsWithoutActiveCoreSubscription;

  Pagination(
      {this.pageNumber,
      this.pageSize,
      this.pagination,
      this.assetsWithoutActiveCoreSubscription,
      this.totalAssets,
      this.totalCount});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
