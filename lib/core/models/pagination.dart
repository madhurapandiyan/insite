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
