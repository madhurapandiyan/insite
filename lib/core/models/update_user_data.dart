import 'package:json_annotation/json_annotation.dart';
part 'update_user_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UpdateResponse {
  final bool? isDeleted;

  UpdateResponse({this.isDeleted});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class DeleteUserData {
  List<String>? users;
  DeleteUserData({
    this.users,
  });
  factory DeleteUserData.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserDataToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class DeleteUserDataIndStack {
  List<String> users;
  String? customerUid;
  DeleteUserDataIndStack({required this.users, this.customerUid});
  factory DeleteUserDataIndStack.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserDataIndStackFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserDataIndStackToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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

  String? fname;
  String? lname;
  String? cwsEmail;
  String? phone;
  String? sso_id;
  String? company;
  bool? isCATSSOUserCreation;
  AddressData? address;
  Details? details;
  List<Role>? roles;
  String? src;
  String? language;

  factory AddUserData.fromJson(Map<String, dynamic> json) =>
      _$AddUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserDataToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AddUserDataIndStack {
  AddUserDataIndStack(
      {this.fname,
      this.lname,
      this.email,
      this.phone,
      this.address,
      this.details,
      this.roles,
      this.src,
      this.isAssetSecurityEnabled,
      this.company,
      this.language,
      this.customerUid});

  String? fname;
  String? lname;
  String? email;
  String? phone;
  String? company;
  AddressData? address;
  Details? details;
  List<Role>? roles;
  String? src;
  String? language;
  String? customerUid;
  bool? isAssetSecurityEnabled;
  factory AddUserDataIndStack.fromJson(Map<String, dynamic> json) =>
      _$AddUserDataIndStackFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserDataIndStackToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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
      this.language,
      this.JobType,
      this.customerUid,
      this.email,
      this.isAssetSecurityEnabled});

  String? fname;
  String? lname;
  String? cwsEmail;
  String? phone;
  String? sso_id;
  bool? isCatssoUserCreation;
  AddressData? address;
  Details? details;
  List<Role>? roles;
  String? src;
  String? company;
  String? language;

  String? email;

  String? customerUid;

  int? JobType;
  bool? isAssetSecurityEnabled;

  factory UpdateUserData.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AddressData {
  String? addressline1;
  String? addressline2;
  String? country;
  String? state;
  String? zipcode;
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

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Details {
  Details({
    this.job_title,
    this.job_type,
    this.user_type,
  });

  String? job_title;
  String? job_type;
  String? user_type;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Role {
  Role({
    this.role_id,
    this.application_name,
  });

  int? role_id;
  String? application_name;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
