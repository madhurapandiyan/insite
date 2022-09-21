import 'package:json_annotation/json_annotation.dart';
part 'tranfer_history.g.dart';

@JsonSerializable()
class TranferHistory{
  List<DeviceTransfer>? deviceTransfer;

  TranferHistory({this.deviceTransfer});

  factory TranferHistory.fromJson(Map<String, dynamic> json) =>
      _$TranferHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$TranferHistoryToJson(this);
}
@JsonSerializable()
class DeviceTransfer {
  @JsonKey(name: "gpsDeviceID")
  String? gpsDeviceId;
  String? oemName;
  String? status;
  String? destinationCustomerType;
  String? sourceCustomerType;
  String? destinationName1;
  String? destinationName2;
  @JsonKey(name: "fk_AssetId")
  int? fkAssetId;
  @JsonKey(name: "insertUTC")
  String? insertUtc;
  String? sourceName1;
  String? sourceName2;
  String? vin;
  String? sTypename;

  DeviceTransfer(
      {this.gpsDeviceId,
      this.oemName,
      this.status,
      this.destinationCustomerType,
      this.destinationName1,
      this.destinationName2,
      this.fkAssetId,
      this.insertUtc,
      this.sourceName1,
      this.sourceName2,
      this.sourceCustomerType,
      this.vin,
      this.sTypename
      });

  factory DeviceTransfer.fromJson(Map<String, dynamic> json) =>
      _$DeviceTransferFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTransferToJson(this);
}

