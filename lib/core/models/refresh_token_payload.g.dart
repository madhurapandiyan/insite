// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenPayload _$RefreshTokenPayloadFromJson(Map<String, dynamic> json) =>
    RefreshTokenPayload(
      client_id: json['client_id'] as String?,
      code_challenge: json['code_challenge'] as String?,
      code_challenge_method: json['code_challenge_method'] as String?,
      code_verifier: json['code_verifier'] as String?,
      grant_type: json['grant_type'] as String?,
      refresh_token: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$RefreshTokenPayloadToJson(
        RefreshTokenPayload instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'refresh_token': instance.refresh_token,
      'grant_type': instance.grant_type,
      'code_verifier': instance.code_verifier,
      'code_challenge': instance.code_challenge,
      'code_challenge_method': instance.code_challenge_method,
    };
