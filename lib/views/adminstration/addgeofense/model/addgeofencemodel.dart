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
  final Target TargetInput;
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
class Target {
  final double TargetVolumeInCuMeter;
  Target({this.TargetVolumeInCuMeter});
  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
  Map<String, dynamic> toJson() => _$TargetToJson(this);
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
