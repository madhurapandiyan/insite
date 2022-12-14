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

ReplacementGraphqlModel _$ReplacementGraphqlModelFromJson(
        Map<String, dynamic> json) =>
    ReplacementGraphqlModel(
      source: json['source'] as String?,
      userID: json['userID'] as int?,
      version: json['version'] as String?,
      device: (json['device'] as List<dynamic>?)
          ?.map((e) =>
              NewDeviceIdGrapgqlDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplacementGraphqlModelToJson(
    ReplacementGraphqlModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  writeNotNull('userID', instance.userID);
  writeNotNull('version', instance.version);
  writeNotNull('device', instance.device?.map((e) => e.toJson()).toList());
  return val;
}

NewDeviceIdGrapgqlDetail _$NewDeviceIdGrapgqlDetailFromJson(
        Map<String, dynamic> json) =>
    NewDeviceIdGrapgqlDetail(
      vin: json['vin'] as String?,
      oldDeviceId: json['oldDeviceId'] as String?,
      newDeviceId: json['newDeviceId'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$NewDeviceIdGrapgqlDetailToJson(
    NewDeviceIdGrapgqlDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('vin', instance.vin);
  writeNotNull('oldDeviceId', instance.oldDeviceId);
  writeNotNull('newDeviceId', instance.newDeviceId);
  writeNotNull('reason', instance.reason);
  return val;
}
