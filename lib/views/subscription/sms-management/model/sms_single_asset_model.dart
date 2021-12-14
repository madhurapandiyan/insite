import 'package:json_annotation/json_annotation.dart';
part 'sms_single_asset_model.g.dart';

@JsonSerializable()
class SingleAssetSmsSchedule {
  final String? AssetSerial;
  final String? Name;
  final String? Mobile;
  final String? Language;
  SingleAssetSmsSchedule({this.AssetSerial,this.Name,this.Mobile,this.Language});
    factory SingleAssetSmsSchedule.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetSmsScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$SingleAssetSmsScheduleToJson(this);
}
