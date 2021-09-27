import 'package:json_annotation/json_annotation.dart';
part 'admin_manage_user.g.dart';

@JsonSerializable()
class AdminManageUser {
  AdminManageUser({this.users, this.links, this.total});

  List<User> users;
  Links links;
  Total total;

  factory AdminManageUser.fromJson(Map<String, dynamic> json) =>
      _$AdminManageUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminManageUserToJson(this);
}

@JsonSerializable()
class User {
  User({
    this.first_name,
    this.last_name,
    this.loginId,
    this.job_type,
    this.user_type,
  });

  String first_name;
  String last_name;
  String loginId;
  String job_type;
  String user_type;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Links {
  String next;
  String last;

  Links({this.last, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Total {
  int items;
  int pages;

  Total({this.items, this.pages});
  factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}
