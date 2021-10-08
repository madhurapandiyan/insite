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
    this.sso_id,
    this.phone,
    this.isCatssoUserCreation,
    this.address,
    this.details,
    this.roles,
    this.src,
  });

  String fname;
  String lname;
  String email;
  String phone;
  String sso_id;
  bool isCatssoUserCreation;
  AddressData address;
  Details details;
  List<Role> roles;
  String src;

  factory UpdateUserData.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataToJson(this);
}

@JsonSerializable()
class AddressData {
  String address;

  String country;
  String state;
  String zipcode;
  AddressData({this.address, this.country, this.state, this.zipcode});

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}

@JsonSerializable()
class Details {
  Details({
    this.jobTitle,
    this.jobType,
    this.user_type,
  });

  String jobTitle;
  String jobType;
  String user_type;

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
