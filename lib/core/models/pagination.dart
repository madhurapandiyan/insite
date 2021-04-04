import 'package:json_annotation/json_annotation.dart';
part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  final int pagination;
  final int pageNumber;
  final int pageSize;

  Pagination({this.pageNumber, this.pageSize, this.pagination});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class AssetPagination {
  final int assetsWithoutActiveCoreSubscription;
  final int pageNumber;
  final int pageSize;
  final int totalAssets;

  AssetPagination(
      {this.pageNumber,
      this.totalAssets,
      this.pageSize,
      this.assetsWithoutActiveCoreSubscription});

  factory AssetPagination.fromJson(Map<String, dynamic> json) =>
      _$AssetPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetPaginationToJson(this);
}
