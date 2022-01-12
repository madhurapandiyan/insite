import 'package:json_annotation/json_annotation.dart';
part 'group_summary_response.g.dart';

@JsonSerializable()
class GroupSummaryResponse {
  Pagination? pagination;
  Links ?links;
  List<AssetDetailsRecords>? assetDetailsRecords;

  GroupSummaryResponse({this.pagination, this.links, this.assetDetailsRecords});

  factory GroupSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSummaryResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  int? totalCount;
  int? pageNumber;
  int? pageSize;

  Pagination({this.totalCount, this.pageNumber, this.pageSize});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class Links {
  String ? self;
 
  Links({this.self});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}


@JsonSerializable()
class AssetDetailsRecords {
  String ? assetIdentifier;
  String? assetSerialNumber;
  String ?makeCode;
  String? model;
  int? assetIcon;
  String? assetId;

  AssetDetailsRecords(
      {this.assetIdentifier,
      this.assetSerialNumber,
      this.makeCode,
      this.model,
      this.assetIcon,
      this.assetId});

 factory AssetDetailsRecords.fromJson(Map<String, dynamic> json) =>_$AssetDetailsRecordsFromJson(json);

  Map<String, dynamic> toJson() =>_$AssetDetailsRecordsToJson(this);
}
