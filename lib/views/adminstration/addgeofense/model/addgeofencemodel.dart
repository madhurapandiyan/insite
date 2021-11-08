import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:json_annotation/json_annotation.dart';
part 'addgeofencemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Addgeofencemodel {
  final List<Geofenceinputs> Inputs;
  final ValidationConstraintgeofence ValidationConstraint;
  Addgeofencemodel({this.Inputs, this.ValidationConstraint});
  factory Addgeofencemodel.fromJson(Map<String, dynamic> json) =>
      _$AddgeofencemodelFromJson(json);
  Map<String, dynamic> toJson() => _$AddgeofencemodelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Geofenceinputs {
  final Geofencepayload GeofenceInput;
  final TargetData TargetInput;
  final Backfill BackfillInput;
  final Materials Material;
  Geofenceinputs(
      {this.GeofenceInput,
      this.TargetInput,
      this.Material,
      this.BackfillInput});
  factory Geofenceinputs.fromJson(Map<String, dynamic> json) =>
      _$GeofenceinputsFromJson(json);
  Map<String, dynamic> toJson() => _$GeofenceinputsToJson(this);
}



@JsonSerializable()
class Backfill {
  final String BackfillDate;
  Backfill({this.BackfillDate});
  factory Backfill.fromJson(Map<String, dynamic> json) =>
      _$BackfillFromJson(json);
  Map<String, dynamic> toJson() => _$BackfillToJson(this);
}

@JsonSerializable()
class Materials {
  final String MaterialUID;
  Materials({this.MaterialUID});
  factory Materials.fromJson(Map<String, dynamic> json) =>
      _$MaterialsFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialsToJson(this);
}

@JsonSerializable()
class ValidationConstraintgeofence {
  final String ValidationConstraint;
  ValidationConstraintgeofence({this.ValidationConstraint});
  factory ValidationConstraintgeofence.fromJson(Map<String, dynamic> json) =>
      _$ValidationConstraintgeofenceFromJson(json);
  Map<String, dynamic> toJson() => _$ValidationConstraintgeofenceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetAddgeofenceModel {
  final ResultData Result;
  final int Code;
  final String Message;
  GetAddgeofenceModel({this.Result, this.Code, this.Message});
  factory GetAddgeofenceModel.fromJson(Map<String, dynamic> json) =>
      _$GetAddgeofenceModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAddgeofenceModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResultData {
  final Geofencepayload Geofence;
  final TargetData Target;
  final Backfill BackfillDate;
  final Materials MaterialData;
  ResultData({this.BackfillDate, this.Geofence, this.MaterialData, this.Target});
  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
@JsonSerializable()
class TargetData {
  final double TargetVolumeInCuMeter;
  TargetData({this.TargetVolumeInCuMeter});
  factory TargetData.fromJson(Map<String, dynamic> json) => _$TargetDataFromJson(json);
  Map<String, dynamic> toJson() => _$TargetDataToJson(this);
}
