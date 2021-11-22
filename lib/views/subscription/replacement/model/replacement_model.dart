import 'package:json_annotation/json_annotation.dart';
part 'replacement_model.g.dart';

@JsonSerializable()
class ReplacementModel {
  final String Source;
  final int UserID;
  final double Version;
  final List<NewDeviceIdDetail> device;
  ReplacementModel({this.Source, this.UserID, this.Version, this.device});

  factory ReplacementModel.fromJson(Map<String, dynamic> json) =>
      _$ReplacementModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementModelToJson(this);
}

@JsonSerializable()
class NewDeviceIdDetail {
  final String VIN;
  final String OldDeviceId;
  final String NewDeviceId;
  final String Reason;
  NewDeviceIdDetail(
      {this.VIN, this.OldDeviceId, this.NewDeviceId, this.Reason});
  factory NewDeviceIdDetail.fromJson(Map<String, dynamic> json) =>
      _$NewDeviceIdDetailFromJson(json);

  Map<String, dynamic> toJson() => _$NewDeviceIdDetailToJson(this);
}
