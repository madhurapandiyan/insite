import 'package:json_annotation/json_annotation.dart';
part 'admin_manage_user.g.dart';

@JsonSerializable()
class AdminManageUser {
  Links links;
  Total total;
  List<Users> users;

  AdminManageUser({this.links, this.total, this.users});

  factory AdminManageUser.fromJson(Map<String, dynamic> json) =>
      _$AdminManageUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminManageUserToJson(this);
}

@JsonSerializable()
class Links {
  String next;
  String last;

  Links({this.next, this.last});

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

@JsonSerializable()
class Users {
  String userUid;
  String first_name;
  String last_name;
  String loginId;
  String job_type;
  String job_title;
  String user_type;
  Address address;
  List<ApplicationAccess> application_access;
  String createdOn;
  String lastLoginDate;
  String createdBy;
  String emailVerified;
  String phone;

  Users(
      {this.userUid,
      this.first_name,
      this.last_name,
      this.loginId,
      this.job_type,
      this.job_title,
      this.user_type,
      this.address,
      this.application_access,
      this.createdOn,
      this.lastLoginDate,
      this.createdBy,
      this.emailVerified,
      this.phone});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class Address {
  String country;
  String zipcode;
  String city;

  Address({this.country, this.zipcode, this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class ApplicationAccess {
  String userUID;
  String roleName;
  String applicationIconUrl;
  String applicationName;

  ApplicationAccess({
    this.userUID,
    this.roleName,
    this.applicationIconUrl,
    this.applicationName,
  });

  factory ApplicationAccess.fromJson(Map<String, dynamic> json) =>
      _$ApplicationAccessFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationAccessToJson(this);
}
