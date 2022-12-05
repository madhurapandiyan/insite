// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeZone _$TimeZoneFromJson(Map<String, dynamic> json) => TimeZone(
      display: json['display'] as String,
      value: json['value'] as String,
      localeValue: json['localeValue'] as String,
      token: json['token'] as String,
      momentTimezone: json['momentTimezone'] as String,
    );

Map<String, dynamic> _$TimeZoneToJson(TimeZone instance) => <String, dynamic>{
      'display': instance.display,
      'value': instance.value,
      'localeValue': instance.localeValue,
      'token': instance.token,
      'momentTimezone': instance.momentTimezone,
    };

UserPreferedData _$UserPreferedDataFromJson(Map<String, dynamic> json) =>
    UserPreferedData(
      dateFormate: json['dateFormate'] == null
          ? null
          : InsiteRadio.fromJson(json['dateFormate'] as Map<String, dynamic>),
      timeFormate: json['timeFormate'] == null
          ? null
          : InsiteRadio.fromJson(json['timeFormate'] as Map<String, dynamic>),
      zone: json['zone'] == null
          ? null
          : TimeZone.fromJson(json['zone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserPreferedDataToJson(UserPreferedData instance) =>
    <String, dynamic>{
      'zone': instance.zone,
      'dateFormate': instance.dateFormate,
      'timeFormate': instance.timeFormate,
    };

InsiteRadio _$InsiteRadioFromJson(Map<String, dynamic> json) => InsiteRadio(
      isSelected: json['isSelected'] as bool? ?? false,
      title: json['title'] as String?,
      key: json['key'] as String?,
      formateValue: json['formateValue'] as String?,
    );

Map<String, dynamic> _$InsiteRadioToJson(InsiteRadio instance) =>
    <String, dynamic>{
      'isSelected': instance.isSelected,
      'title': instance.title,
      'key': instance.key,
      'formateValue': instance.formateValue,
    };
