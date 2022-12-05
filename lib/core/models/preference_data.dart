import 'package:insite/core/models/preference.dart';
import 'package:json_annotation/json_annotation.dart';
part 'preference_data.g.dart';

@JsonSerializable()
class PreferenceData {
  Data? data;

  PreferenceData({this.data});

  factory PreferenceData.fromJson(Map<String, dynamic> json) =>
      _$PreferenceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceDataToJson(this);
}

@JsonSerializable()
class Data {
  GetUserPreference? getUserPreference;

  Data({this.getUserPreference});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GetUserPreference {
  String? preferenceJson;
  String? preferenceKeyName;
  String? preferenceKeyUID;
  String? schemaVersion;

  GetUserPreference(
      {this.preferenceJson,
      this.preferenceKeyName,
      this.preferenceKeyUID,
      this.schemaVersion});

  factory GetUserPreference.fromJson(Map<String, dynamic> json) =>
      _$GetUserPreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserPreferenceToJson(this);
}


