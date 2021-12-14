import 'package:json_annotation/json_annotation.dart';
part 'personalities.g.dart';

@JsonSerializable()
class Personality {
  final String? Name;
  final String? Description;
  final String? Value;
  Personality(this.Name, this.Description, this.Value);
  factory Personality.fromJson(Map<String, dynamic> json) =>
      _$PersonalityFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalityToJson(this);
}
