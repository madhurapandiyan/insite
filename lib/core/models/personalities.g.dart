// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personality _$PersonalityFromJson(Map<String, dynamic> json) {
  return Personality(
    json['Name'] as String,
    json['Description'] as String,
    json['Value'] as String,
  );
}

Map<String, dynamic> _$PersonalityToJson(Personality instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'Description': instance.Description,
      'Value': instance.Value,
    };
