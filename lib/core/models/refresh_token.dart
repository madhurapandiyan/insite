import 'package:json_annotation/json_annotation.dart';
part 'refresh_token.g.dart';

@JsonSerializable()
class RefreshToken {
  final String? client_id;
  final String? refresh_token;
  final String? grant_type;
  final String? code_verifier;
  final String? code_challenge;
  final String? code_challenge_method;
  RefreshToken(
      {this.client_id,
      this.code_challenge,
      this.code_challenge_method,
      this.code_verifier,
      this.grant_type,
      this.refresh_token});

  factory RefreshToken.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
}
