import 'package:json_annotation/json_annotation.dart';
part 'zone.g.dart';

@JsonSerializable(explicitToJson: true)
class ZoneCreating {
  final double? latitude;
  final double? longitude;
  final double? radius;
  final String? zoneName;
  ZoneCreating({this.latitude, this.longitude, this.radius, this.zoneName});
  factory ZoneCreating.fromJson(Map<String, dynamic> json) =>
      _$ZoneCreatingFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneCreatingToJson(this);
}
