// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenData _$GetTokenDataFromJson(Map<String, dynamic> json) => GetTokenData(
      grant_type: json['grant_type'] as String?,
      client_id: json['client_id'] as String?,
      redirect_uri: json['redirect_uri'] as String?,
      code: json['code'] as String?,
      code_challenge: json['code_challenge'] as String?,
      code_verifier: json['code_verifier'] as String?,
      tenantDomain: json['tenantDomain'] as String?,
    );

Map<String, dynamic> _$GetTokenDataToJson(GetTokenData instance) =>
    <String, dynamic>{
      'grant_type': instance.grant_type,
      'client_id': instance.client_id,
      'redirect_uri': instance.redirect_uri,
      'code': instance.code,
      'code_challenge': instance.code_challenge,
      'code_verifier': instance.code_verifier,
      'tenantDomain': instance.tenantDomain,
    };

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      access_token: json['access_token'] as String?,
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
    };
