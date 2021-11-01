// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addgeofencemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addgeofencemodel _$AddgeofencemodelFromJson(Map<String, dynamic> json) {
  return Addgeofencemodel(
    Inputs: (json['Inputs'] as List)
        ?.map((e) => e == null
            ? null
            : Geofenceinputs.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ValidationConstraint: json['ValidationConstraint'] == null
        ? null
        : ValidationConstraintgeofence.fromJson(
            json['ValidationConstraint'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddgeofencemodelToJson(Addgeofencemodel instance) =>
    <String, dynamic>{
      'Inputs': instance.Inputs?.map((e) => e?.toJson())?.toList(),
      'ValidationConstraint': instance.ValidationConstraint?.toJson(),
    };

Geofenceinputs _$GeofenceinputsFromJson(Map<String, dynamic> json) {
  return Geofenceinputs(
    GeofenceInput: json['GeofenceInput'] == null
        ? null
        : Geofencepayload.fromJson(
            json['GeofenceInput'] as Map<String, dynamic>),
    TargetInput: json['TargetInput'] == null
        ? null
        : Target.fromJson(json['TargetInput'] as Map<String, dynamic>),
    Material: json['Material'] == null
        ? null
        : Materials.fromJson(json['Material'] as Map<String, dynamic>),
    BackfillInput: json['BackfillInput'] == null
        ? null
        : Backfill.fromJson(json['BackfillInput'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeofenceinputsToJson(Geofenceinputs instance) =>
    <String, dynamic>{
      'GeofenceInput': instance.GeofenceInput?.toJson(),
      'TargetInput': instance.TargetInput?.toJson(),
      'BackfillInput': instance.BackfillInput?.toJson(),
      'Material': instance.Material?.toJson(),
    };

Target _$TargetFromJson(Map<String, dynamic> json) {
  return Target(
    TargetVolumeInCuMeter: (json['TargetVolumeInCuMeter'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TargetToJson(Target instance) => <String, dynamic>{
      'TargetVolumeInCuMeter': instance.TargetVolumeInCuMeter,
    };

Backfill _$BackfillFromJson(Map<String, dynamic> json) {
  return Backfill(
    BackfillDate: json['BackfillDate'] as String,
  );
}

Map<String, dynamic> _$BackfillToJson(Backfill instance) => <String, dynamic>{
      'BackfillDate': instance.BackfillDate,
    };

Materials _$MaterialsFromJson(Map<String, dynamic> json) {
  return Materials(
    MaterialUID: json['MaterialUID'] as String,
  );
}

Map<String, dynamic> _$MaterialsToJson(Materials instance) => <String, dynamic>{
      'MaterialUID': instance.MaterialUID,
    };

ValidationConstraintgeofence _$ValidationConstraintgeofenceFromJson(
    Map<String, dynamic> json) {
  return ValidationConstraintgeofence(
    ValidationConstraint: json['ValidationConstraint'] as String,
  );
}

Map<String, dynamic> _$ValidationConstraintgeofenceToJson(
        ValidationConstraintgeofence instance) =>
    <String, dynamic>{
      'ValidationConstraint': instance.ValidationConstraint,
    };
