import 'package:json_annotation/json_annotation.dart';
part 'manage_group_summary_response.g.dart';

@JsonSerializable()
class ManageGroupSummaryResponse {
  Links? links;
  Total? total;
  List<Groups>? groups;

  ManageGroupSummaryResponse({this.links, this.total, this.groups});

  factory ManageGroupSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageGroupSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageGroupSummaryResponseToJson(this);
}

@JsonSerializable()
class Links {
  String? next;
  String? last;

  Links({this.next, this.last});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Total {
  int? items;
  int? pages;

  Total({this.items, this.pages});

  factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}

@JsonSerializable()
class Groups {
  @JsonKey(name: "groupUid")
  String? GroupUid;
  @JsonKey(name: "groupName")
  String? GroupName;
  @JsonKey(name: "description")
  String? Description;
  @JsonKey(name: "isFavourite")
  bool? IsFavourite;
  String? createdOnUTC;
  String? createdByUserName;
  @JsonKey(name: "assetUID")
  List<String>? assetUID;

  Groups(
      {this.GroupUid,
      this.GroupName,
      this.Description,
      this.IsFavourite,
      this.createdOnUTC,
      this.createdByUserName,
      this.assetUID});

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);
  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}

class GroupRow {
  final Groups? groups;
  bool? isSelected;
  GroupRow({this.groups, this.isSelected = false});
}
