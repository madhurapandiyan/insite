// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      PreferenceKeyName: json['PreferenceKeyName'] as String?,
      PreferenceJson: json['PreferenceJson'] as String?,
      PreferenceKeyUID: json['PreferenceKeyUID'] as String?,
      SchemaVersion: json['SchemaVersion'] as String?,
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'PreferenceKeyName': instance.PreferenceKeyName,
      'PreferenceJson': instance.PreferenceJson,
      'PreferenceKeyUID': instance.PreferenceKeyUID,
      'SchemaVersion': instance.SchemaVersion,
    };
