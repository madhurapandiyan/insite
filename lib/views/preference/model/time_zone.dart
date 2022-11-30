import 'package:json_annotation/json_annotation.dart';
part 'time_zone.g.dart';

@JsonSerializable()
class TimeZone {
  final String display;
  final String value;
  final String localeValue;
  final String token;
  final String momentTimezone;

  const TimeZone({
    required this.display,
    required this.value,
    required this.localeValue,
    required this.token,
    required this.momentTimezone,
  });

  factory TimeZone.fromJson(Map<String, dynamic> json) =>
      _$TimeZoneFromJson(json);

  Map<String, dynamic> toJson() => _$TimeZoneToJson(this);
}

@JsonSerializable()
class UserPreferedData {
  TimeZone? zone;
  InsiteRadio? dateFormate;
  InsiteRadio? timeFormate;
  UserPreferedData({this.dateFormate, this.timeFormate, this.zone});

  factory UserPreferedData.fromJson(Map<String, dynamic> json) =>
      _$UserPreferedDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferedDataToJson(this);
}

@JsonSerializable()
class InsiteRadio {
  bool? isSelected;
  String? title;
  String? key;
  String? formateValue;

  InsiteRadio(
      {this.isSelected = false, this.title, this.key, this.formateValue});

  factory InsiteRadio.fromJson(Map<String, dynamic> json) =>
      _$InsiteRadioFromJson(json);

  Map<String, dynamic> toJson() => _$InsiteRadioToJson(this);
}
