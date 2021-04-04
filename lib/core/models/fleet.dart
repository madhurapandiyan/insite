import 'package:json_annotation/json_annotation.dart';
part 'fleet.g.dart';

@JsonSerializable()
class Fleet {
  final String assetIdentifier;
  final String assetId;
  final String assetSerialNumber;
  final String manufacturer;
  final String makeCode;
  final String model;
  final int assetIcon;
  final String productFamily;
  final String status;
  final double hourMeter;
  final String lastHourMeterUTC;
  final String lastOdometerUTC;
  final double odometer;
  final String dealerCustomerName;
  final String dealerCode;
  final String dealerName;
  final String universalCustomerIdentifier;
  final String universalCustomerName;
  final String dealerCustomerNumber;
  final String lastLocationUpdateUTC;

  Fleet(
      {this.assetIdentifier,
      this.assetId,
      this.assetIcon,
      this.assetSerialNumber,
      this.dealerCode,
      this.dealerCustomerNumber,
      this.dealerCustomerName,
      this.dealerName,
      this.hourMeter,
      this.lastHourMeterUTC,
      this.lastLocationUpdateUTC,
      this.lastOdometerUTC,
      this.makeCode,
      this.manufacturer,
      this.model,
      this.odometer,
      this.productFamily,
      this.status,
      this.universalCustomerIdentifier,
      this.universalCustomerName});
  factory Fleet.fromJson(Map<String, dynamic> json) => _$FleetFromJson(json);

  Map<String, dynamic> toJson() => _$FleetToJson(this);
}
