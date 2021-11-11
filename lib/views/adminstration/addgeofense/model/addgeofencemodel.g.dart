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
        : TargetData.fromJson(json['TargetInput'] as Map<String, dynamic>),
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

GetAddgeofenceModel _$GetAddgeofenceModelFromJson(Map<String, dynamic> json) {
  return GetAddgeofenceModel(
    Result: json['Result'] == null
        ? null
        : ResultData.fromJson(json['Result'] as Map<String, dynamic>),
    Code: json['Code'] as int,
    Message: json['Message'] as String,
  );
}

Map<String, dynamic> _$GetAddgeofenceModelToJson(
        GetAddgeofenceModel instance) =>
    <String, dynamic>{
      'Result': instance.Result?.toJson(),
      'Code': instance.Code,
      'Message': instance.Message,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
    BackfillDate: json['BackfillDate'] == null
        ? null
        : Backfill.fromJson(json['BackfillDate'] as Map<String, dynamic>),
    Geofence: json['Geofence'] == null
        ? null
        : Geofencepayload.fromJson(json['Geofence'] as Map<String, dynamic>),
    MaterialData: json['MaterialData'] == null
        ? null
        : Materials.fromJson(json['MaterialData'] as Map<String, dynamic>),
    Target: json['Target'] == null
        ? null
        : TargetData.fromJson(json['Target'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'Geofence': instance.Geofence?.toJson(),
      'Target': instance.Target?.toJson(),
      'BackfillDate': instance.BackfillDate?.toJson(),
      'MaterialData': instance.MaterialData?.toJson(),
    };

TargetData _$TargetDataFromJson(Map<String, dynamic> json) {
  return TargetData(
    TargetVolumeInCuMeter: (json['TargetVolumeInCuMeter'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TargetDataToJson(TargetData instance) =>
    <String, dynamic>{
      'TargetVolumeInCuMeter': instance.TargetVolumeInCuMeter,
    };

GeofenceModelWithMaterialData _$GeofenceModelWithMaterialDataFromJson(
    Map<String, dynamic> json) {
  return GeofenceModelWithMaterialData(
    Input: json['Input'] == null
        ? null
        : Geofenceinputs.fromJson(json['Input'] as Map<String, dynamic>),
    GeofenceUID: json['GeofenceUID'] as String,
  );
}

Map<String, dynamic> _$GeofenceModelWithMaterialDataToJson(
        GeofenceModelWithMaterialData instance) =>
    <String, dynamic>{
      'Input': instance.Input,
      'GeofenceUID': instance.GeofenceUID,
    };
