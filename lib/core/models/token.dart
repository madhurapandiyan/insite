import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@JsonSerializable()
class GetTokenData {
  final String grant_type;
  final String client_id;
  final String redirect_uri;
  final String code;
  final String code_challenge;
  final String code_verifier;
  final String tenantDomain;

  GetTokenData(
      {this.grant_type,
      this.client_id,
      this.redirect_uri,
      this.code,
      this.code_challenge,
      this.code_verifier,
      this.tenantDomain});

  factory GetTokenData.fromJson(Map<String, dynamic> json) =>
      _$GetTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetTokenDataToJson(this);
}

@JsonSerializable()
class AccessToken {
  final String access_token;

  AccessToken({this.access_token});

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}
