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
class DeleteUserData {
  List<String> users;
  DeleteUserData({this.users});
  factory DeleteUserData.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserDataToJson(this);
}

@JsonSerializable()
class AddUserData {
  AddUserData({
    this.fname,
    this.lname,
    this.cwsEmail,
    this.sso_id,
    this.phone,
    this.isCATSSOUserCreation,
    this.address,
    this.details,
    this.roles,
    this.src,
    this.company,
    this.language,
  });

  String fname;
  String lname;
  String cwsEmail;
  String phone;
  String sso_id;
  String company;
  bool isCATSSOUserCreation;
  AddressData address;
  Details details;
  List<Role> roles;
  String src;
  String language;

  factory AddUserData.fromJson(Map<String, dynamic> json) =>
      _$AddUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserDataToJson(this);
}

@JsonSerializable()
class UpdateUserData {
  UpdateUserData(
      {this.fname,
      this.lname,
      this.cwsEmail,
      this.sso_id,
      this.phone,
      this.isCatssoUserCreation,
      this.address,
      this.details,
      this.roles,
      this.src,
      this.company,
      this.language});

  String fname;
  String lname;
  String cwsEmail;
  String phone;
  String sso_id;
  bool isCatssoUserCreation;
  AddressData address;
  Details details;
  List<Role> roles;
  String src;
  String company;
  String language;

  factory UpdateUserData.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataToJson(this);
}

@JsonSerializable()
class AddressData {
  String addressline1;
  String addressline2;
  String country;
  String state;
  String zipcode;
  AddressData(
      {this.addressline1,
      this.addressline2,
      this.country,
      this.state,
      this.zipcode});

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}

@JsonSerializable()
class Details {
  Details({
    this.job_title,
    this.job_type,
    this.user_type,
  });

  String job_title;
  String job_type;
  String user_type;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Role {
  Role({
    this.role_id,
    this.application_name,
  });

  int role_id;
  String application_name;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
