import 'package:json_annotation/json_annotation.dart';
part 'device_replacement_status_model.g.dart';



@JsonSerializable()
class TotalDeviceReplacementStatusModel {
  final String? code;
  final String? status;
   List<ReplacementHistory>? replacementHistory;
  final List<List<DeviceReplacementStatusModel>>? result;
  TotalDeviceReplacementStatusModel({this.code, this.result, this.status,this.replacementHistory});


    factory TotalDeviceReplacementStatusModel.fromJson(Map<String, dynamic> json) =>
      _$TotalDeviceReplacementStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDeviceReplacementStatusModelToJson(this);
}

@JsonSerializable()
class DeviceReplacementStatusModel {
  final int? count;
  @JsonKey(name: "OldDeviceId")
  final String? oldDeviceId;
  @JsonKey(name: "NewDeviceId")
  final String? newDeviceId;
  @JsonKey(name: "Reason")
  final String? reason;
   @JsonKey(name: "VIN")
  final String? vin;
  @JsonKey(name: "InsertUTC")
  final String? insertUtc;
  @JsonKey(name: "EmailID")
  final String? emailId;
  @JsonKey(name: "FirstName")
  final String? firstName;
  @JsonKey(name: "LastName")
  final String? lastName;
  @JsonKey(name: "State")
  final String? state;
  @JsonKey(name: "Description")
  final String? description;
  DeviceReplacementStatusModel(
      {this.count,
      this.oldDeviceId,
      this.newDeviceId,
      this.reason,
      this.vin,
      this.insertUtc,
      this.emailId,
      this.description,
      this.firstName,
      this.lastName,
      this.state});

        factory DeviceReplacementStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceReplacementStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReplacementStatusModelToJson(this);
}

@JsonSerializable()
class ReplacementHistory {
  String? oldDeviceId;
  String? newDeviceId;
  String? reason;
  String? vin;
  @JsonKey(name: "insertUTC")
  String? insertUtc;
  @JsonKey(name: "emailID")
  String? emailId;
  String? firstName;
  String? lastName;
  String? state;
  String? description;
  @JsonKey(name: "__typename")
  String? sTypename;
  String? count;

  ReplacementHistory(
      {this.oldDeviceId,
      this.newDeviceId,
      this.reason,
      this.vin,
      this.insertUtc,
      this.emailId,
      this.firstName,
      this.lastName,
      this.state,
      this.description,
      this.sTypename,
      this.count
      });

  factory ReplacementHistory.fromJson(Map<String, dynamic> json) =>
      _$ReplacementHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementHistoryToJson(this);
}
