import 'package:insite/core/models/asset_settings.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_contact_report_list_response.g.dart';

@JsonSerializable()
class SearchContactReportListResponse {
  List<User>? Users;
  PageInfo? pageInfo;

  SearchContactReportListResponse({this.Users, this.pageInfo});

  factory SearchContactReportListResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchContactReportListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SearchContactReportListResponseToJson(this);
}

@JsonSerializable()
class User {
  String? name;
  String? email;
  bool? isVLUser;
  bool ? isSelected;

  User({this.name, this.email, this.isVLUser,this.isSelected=false});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// @JsonSerializable()
// class PageInfo {
//   int? totalRecords;
//   int? totalPages;
//   int? currentPageSize;
//   int? currentPageNumber;

//   PageInfo(
//       {this.totalRecords,
//       this.totalPages,
//       this.currentPageSize,
//       this.currentPageNumber});

//   factory PageInfo.fromJson(Map<String, dynamic> json) =>
//       _$PageInfoFromJson(json);

//   Map<String, dynamic> toJson() => _$PageInfoToJson(this);
// }
