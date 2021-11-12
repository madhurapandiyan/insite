import 'package:json_annotation/json_annotation.dart';
part 'sms_single_asset_responce_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleAssetResponce {
  final String code;
  final String status;
  final List<SingleAssetModelResponce> result;
  SingleAssetResponce({this.code, this.status, this.result});

    factory SingleAssetResponce.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetResponceFromJson(json);

  Map<String, dynamic> toJson() => _$SingleAssetResponceToJson(this);
}

@JsonSerializable()
class SingleAssetModelResponce {
  final String GPSDeviceID;
  final String SerialNumber;
  final String Model;
  final String StartDate;
  SingleAssetModelResponce({this.GPSDeviceID,this.SerialNumber,this.Model,this.StartDate});

  factory SingleAssetModelResponce.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetModelResponceFromJson(json);

  Map<String, dynamic> toJson() => _$SingleAssetModelResponceToJson(this);
}
