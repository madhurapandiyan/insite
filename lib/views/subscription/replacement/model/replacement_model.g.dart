// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replacement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplacementModel _$ReplacementModelFromJson(Map<String, dynamic> json) =>
    ReplacementModel(
      Source: json['Source'] as String?,
      UserID: json['UserID'] as int?,
      Version: (json['Version'] as num?)?.toDouble(),
      device: (json['device'] as List<dynamic>?)
          ?.map((e) => NewDeviceIdDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplacementModelToJson(ReplacementModel instance) =>
    <String, dynamic>{
      'Source': instance.Source,
      'UserID': instance.UserID,
      'Version': instance.Version,
      'device': instance.device,
    };

NewDeviceIdDetail _$NewDeviceIdDetailFromJson(Map<String, dynamic> json) =>
    NewDeviceIdDetail(
      VIN: json['VIN'] as String?,
      OldDeviceId: json['OldDeviceId'] as String?,
      NewDeviceId: json['NewDeviceId'] as String?,
      Reason: json['Reason'] as String?,
    );

Map<String, dynamic> _$NewDeviceIdDetailToJson(NewDeviceIdDetail instance) =>
    <String, dynamic>{
      'VIN': instance.VIN,
      'OldDeviceId': instance.OldDeviceId,
      'NewDeviceId': instance.NewDeviceId,
      'Reason': instance.Reason,
    };
