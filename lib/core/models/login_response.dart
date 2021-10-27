import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String access_token;
  String refresh_token;
  String scope;
  String id_token;
  String token_type;
  int expires_in;

  LoginResponse(
      {this.access_token,
      this.refresh_token,
      this.expires_in,
      this.id_token,
      this.scope,
      this.token_type});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
