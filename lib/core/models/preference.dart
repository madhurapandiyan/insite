import 'package:json_annotation/json_annotation.dart';
part 'preference.g.dart';

@JsonSerializable()
class Preference {
  final String PreferenceKeyName;
  final String PreferenceJson;
  final String PreferenceKeyUID;
  final String SchemaVersion;
  Preference(
      {this.PreferenceKeyName,
      this.PreferenceJson,
      this.PreferenceKeyUID,
      this.SchemaVersion});

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceToJson(this);
}
