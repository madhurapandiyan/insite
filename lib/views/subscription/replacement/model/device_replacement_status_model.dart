import 'package:json_annotation/json_annotation.dart';
part 'device_replacement_status_model.g.dart';



@JsonSerializable()
class TotalDeviceReplacementStatusModel {
  final String? code;
  final String? status;
  final List<List<DeviceReplacementStatusModel>>? result;
  TotalDeviceReplacementStatusModel({this.code, this.result, this.status});


    factory TotalDeviceReplacementStatusModel.fromJson(Map<String, dynamic> json) =>
      _$TotalDeviceReplacementStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDeviceReplacementStatusModelToJson(this);
}

@JsonSerializable()
class DeviceReplacementStatusModel {
  final int? count;
  final String? OldDeviceId;
  final String? NewDeviceId;
  final String? Reason;
  final String? VIN;
  final String? InsertUTC;
  final String? EmailID;
  final String? FirstName;
  final String? LastName;
  final String? State;
  final String? Description;
  DeviceReplacementStatusModel(
      {this.count,
      this.OldDeviceId,
      this.NewDeviceId,
      this.Reason,
      this.VIN,
      this.InsertUTC,
      this.EmailID,
      this.Description,
      this.FirstName,
      this.LastName,
      this.State});

        factory DeviceReplacementStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceReplacementStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReplacementStatusModelToJson(this);
}
