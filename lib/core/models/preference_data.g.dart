// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceData _$PreferenceDataFromJson(Map<String, dynamic> json) =>
    PreferenceData(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceDataToJson(PreferenceData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      getUserPreference: json['getUserPreference'] == null
          ? null
          : GetUserPreference.fromJson(
              json['getUserPreference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'getUserPreference': instance.getUserPreference,
    };

GetUserPreference _$GetUserPreferenceFromJson(Map<String, dynamic> json) =>
    GetUserPreference(
      preferenceJson: json['preferenceJson'] as String?,
      preferenceKeyName: json['preferenceKeyName'] as String?,
      preferenceKeyUID: json['preferenceKeyUID'] as String?,
      schemaVersion: json['schemaVersion'] as String?,
    );

Map<String, dynamic> _$GetUserPreferenceToJson(GetUserPreference instance) =>
    <String, dynamic>{
      'preferenceJson': instance.preferenceJson,
      'preferenceKeyName': instance.preferenceKeyName,
      'preferenceKeyUID': instance.preferenceKeyUID,
      'schemaVersion': instance.schemaVersion,
    };
