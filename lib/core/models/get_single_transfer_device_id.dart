import 'package:json_annotation/json_annotation.dart';
part 'get_single_transfer_device_id.g.dart';

@JsonSerializable()
class SingleTransferDeviceId {
  List<Result> result;

  SingleTransferDeviceId({this.result});

  factory SingleTransferDeviceId.fromJson(Map<String, dynamic> json) =>
      _$SingleTransferDeviceIdFromJson(json);

  Map<String, dynamic> toJson() => _$SingleTransferDeviceIdToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "GPSDeviceID")
  String gPSDeviceID;
  @JsonKey(name: "VIN")
  String vIN;

  Result({this.gPSDeviceID, this.vIN});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
