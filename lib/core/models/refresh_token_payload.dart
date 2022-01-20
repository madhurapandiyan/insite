import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_payload.g.dart';

@JsonSerializable()
class RefreshTokenPayload {
  final String? client_id;
  final String? refresh_token;
  final String? grant_type;
  final String? code_verifier;
  final String? code_challenge;
  final String? code_challenge_method;
  RefreshTokenPayload(
      {this.client_id,
      this.code_challenge,
      this.code_challenge_method,
      this.code_verifier,
      this.grant_type,
      this.refresh_token});

  factory RefreshTokenPayload.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenPayloadToJson(this);
}
