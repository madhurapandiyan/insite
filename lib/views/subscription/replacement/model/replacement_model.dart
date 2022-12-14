import 'package:json_annotation/json_annotation.dart';
part 'replacement_model.g.dart';

@JsonSerializable()
class ReplacementModel {
  final String? Source;
  final int? UserID;
  final double? Version;
  final List<NewDeviceIdDetail>? device;
  ReplacementModel({this.Source, this.UserID, this.Version, this.device});

  factory ReplacementModel.fromJson(Map<String, dynamic> json) =>
      _$ReplacementModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementModelToJson(this);
}

@JsonSerializable()
class NewDeviceIdDetail {
  final String? VIN;
  final String? OldDeviceId;
  final String? NewDeviceId;
  final String? Reason;
  NewDeviceIdDetail(
      {this.VIN, this.OldDeviceId, this.NewDeviceId, this.Reason});
  factory NewDeviceIdDetail.fromJson(Map<String, dynamic> json) =>
      _$NewDeviceIdDetailFromJson(json);

  Map<String, dynamic> toJson() => _$NewDeviceIdDetailToJson(this);
}

@JsonSerializable(explicitToJson: true,includeIfNull: false)
class ReplacementGraphqlModel {
  final String? source;
  final int? userID;
  final double? version;
  final List<NewDeviceIdGrapgqlDetail>? device;
  ReplacementGraphqlModel({this.source, this.userID, this.version, this.device});

  factory ReplacementGraphqlModel.fromJson(Map<String, dynamic> json) =>
      _$ReplacementGraphqlModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementGraphqlModelToJson(this);
}

@JsonSerializable(explicitToJson: true,includeIfNull: false)
class NewDeviceIdGrapgqlDetail {
  final String? vin;
  final String? oldDeviceId;
  final String? newDeviceId;
  final String? reason;
  NewDeviceIdGrapgqlDetail(
      {this.vin, this.oldDeviceId, this.newDeviceId, this.reason});
  factory NewDeviceIdGrapgqlDetail.fromJson(Map<String, dynamic> json) =>
      _$NewDeviceIdGrapgqlDetailFromJson(json);

  Map<String, dynamic> toJson() => _$NewDeviceIdGrapgqlDetailToJson(this);
}
