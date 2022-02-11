import 'package:json_annotation/json_annotation.dart';

import 'admin_manage_user.dart';
part 'user.g.dart';

@JsonSerializable()
class CheckUserResponse {
  final bool? isMultiUserAccount;
  final bool? isUserExists;
  final List<Users?>? users;
  CheckUserResponse({this.isMultiUserAccount, this.isUserExists, this.users});

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserResponseToJson(this);
}
