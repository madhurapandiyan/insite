import 'package:json_annotation/json_annotation.dart';
import 'device_replacement_status_model.dart';
part 'replacement_deviceId_download.g.dart';

@JsonSerializable()
class ReplacementDeviceIdDownload {
  final String code;
  final String status;
  final List<DeviceReplacementStatusModel> result;

  ReplacementDeviceIdDownload({this.code, this.status, this.result});

  factory ReplacementDeviceIdDownload.fromJson(Map<String, dynamic> json) =>
      _$ReplacementDeviceIdDownloadFromJson(json);
  Map<String, dynamic> toJson() => _$ReplacementDeviceIdDownloadToJson(this);
}
