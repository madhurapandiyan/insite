// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    deviceType: json['deviceType'] as String,
    deviceUID: json['deviceUID'] as String,
    activeServicePlans: (json['activeServicePlans'] as List)
        ?.map((e) =>
            e == null ? null : ServicePlan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isGpsRollOverAffected: json['isGpsRollOverAffected'] as bool,
    mainboardSoftwareVersion: json['mainboardSoftwareVersion'] as String,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'deviceType': instance.deviceType,
      'mainboardSoftwareVersion': instance.mainboardSoftwareVersion,
      'isGpsRollOverAffected': instance.isGpsRollOverAffected,
      'deviceUID': instance.deviceUID,
      'activeServicePlans': instance.activeServicePlans,
    };
