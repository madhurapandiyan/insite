import 'package:json_annotation/json_annotation.dart';
part 'update_user_data.g.dart';

@JsonSerializable()
class UpdateResponse {
  final bool isUpdated;

  UpdateResponse({this.isUpdated});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseToJson(this);
}

@JsonSerializable()
class UpdateUserData {
  UpdateUserData({
    this.fname,
    this.lname,
    this.email,
    this.isCatssoUserCreation,
    this.address,
    this.details,
    this.roles,
    this.src,
  });

  String fname;
  String lname;
  String email;
  bool isCatssoUserCreation;
  Address address;
  Details details;
  List<Role> roles;
  String src;

  factory UpdateUserData.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataToJson(this);
}

@JsonSerializable()
class Address {
  Address();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Details {
  Details({
    this.jobTitle,
    this.jobType,
    this.userType,
  });

  String jobTitle;
  String jobType;
  String userType;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Role {
  Role({
    this.roleId,
    this.applicationName,
  });

  int roleId;
  String applicationName;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
