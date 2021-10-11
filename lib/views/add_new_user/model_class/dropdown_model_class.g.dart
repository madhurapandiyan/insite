// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_model_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationSelectedDropDown _$ApplicationSelectedDropDownFromJson(
    Map<String, dynamic> json) {
  return ApplicationSelectedDropDown(
    accessData: json['accessData'] == null
        ? null
        : ApplicationAccessData.fromJson(
            json['accessData'] as Map<String, dynamic>),
    value: json['value'] as String,
    key: json['key'] as String,
    applicationName: json['applicationName'] as String,
  );
}

Map<String, dynamic> _$ApplicationSelectedDropDownToJson(
        ApplicationSelectedDropDown instance) =>
    <String, dynamic>{
      'accessData': instance.accessData,
      'value': instance.value,
      'key': instance.key,
      'applicationName': instance.applicationName,
    };
