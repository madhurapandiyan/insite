// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: json['code'] as int?,
      message: json['message'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'description': instance.description,
    };
