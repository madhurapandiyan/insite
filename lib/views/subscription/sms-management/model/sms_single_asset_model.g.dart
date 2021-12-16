// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_single_asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetSmsSchedule _$SingleAssetSmsScheduleFromJson(
        Map<String, dynamic> json) =>
    SingleAssetSmsSchedule(
      AssetSerial: json['AssetSerial'] as String?,
      Name: json['Name'] as String?,
      Mobile: json['Mobile'] as String?,
      Language: json['Language'] as String?,
    );

Map<String, dynamic> _$SingleAssetSmsScheduleToJson(
        SingleAssetSmsSchedule instance) =>
    <String, dynamic>{
      'AssetSerial': instance.AssetSerial,
      'Name': instance.Name,
      'Mobile': instance.Mobile,
      'Language': instance.Language,
    };
