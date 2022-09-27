// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_interval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditIntervalResponse _$EditIntervalResponseFromJson(
        Map<String, dynamic> json) =>
    EditIntervalResponse(
      updateMaintenanceIntervals: json['updateMaintenanceIntervals'] == null
          ? null
          : UpdateMaintenanceIntervals.fromJson(
              json['updateMaintenanceIntervals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditIntervalResponseToJson(
        EditIntervalResponse instance) =>
    <String, dynamic>{
      'updateMaintenanceIntervals': instance.updateMaintenanceIntervals,
    };

UpdateMaintenanceIntervals _$UpdateMaintenanceIntervalsFromJson(
        Map<String, dynamic> json) =>
    UpdateMaintenanceIntervals(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateMaintenanceIntervalsToJson(
        UpdateMaintenanceIntervals instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
