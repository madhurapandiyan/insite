import 'package:json_annotation/json_annotation.dart';
part 'saving_sms_model.g.dart';

@JsonSerializable()
class SavingSmsModel {
  final String AssetSerial;
  final String Name;
  final String Mobile;
  final String Language;
  final String GPSDeviceID;
  final String StartDate;
  final String Model;
  final String img;
  final int UserID;
  SavingSmsModel(
      {this.AssetSerial,
      this.GPSDeviceID,
      this.Language,
      this.Mobile,
      this.Model,
      this.Name,
      this.StartDate,
      this.UserID,
      this.img = "../../../../assets/img/THC/EX200.png"});
  factory SavingSmsModel.fromJson(Map<String, dynamic> json) =>
      _$SavingSmsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavingSmsModelToJson(this);
}

@JsonSerializable()
class SavingSmsResponce {
  final int code;
  final String status;
  final String message;
  final List<SavingSmsModel> AssetSerialNo;

  SavingSmsResponce({this.AssetSerialNo, this.code, this.message, this.status});
  factory SavingSmsResponce.fromJson(Map<String, dynamic> json) =>
      _$SavingSmsResponceFromJson(json);

  Map<String, dynamic> toJson() => _$SavingSmsResponceToJson(this);
}
