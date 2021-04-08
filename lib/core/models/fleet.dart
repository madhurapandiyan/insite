import 'package:insite/core/models/links.dart';
import 'package:insite/core/models/pagination.dart';
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
  final String customStateDescription;
  final double fuelLevelLastReported;
  final double lastReportedLocationLatitude;
  final double lastReportedLocationLongitude;
  final String lastReportedLocation;
  final String lastReportedUTC;
  final String lastPercentFuelRemainingUTC;
  final double lifetimeFuelLiters;
  final String lastLifetimeFuelLitersUTC;
  final double notifications;
  final String lastOperatorName;
  final String lastOperatorID;
  final double modelYear;

  Fleet(
      {this.assetIdentifier,
      this.assetId,
      this.modelYear,
      this.lifetimeFuelLiters,
      this.lastReportedUTC,
      this.lastLifetimeFuelLitersUTC,
      this.lastPercentFuelRemainingUTC,
      this.lastReportedLocationLatitude,
      this.notifications,
      this.lastOperatorID,
      this.lastReportedLocation,
      this.assetIcon,
      this.lastOperatorName,
      this.lastReportedLocationLongitude,
      this.assetSerialNumber,
      this.dealerCode,
      this.fuelLevelLastReported,
      this.dealerCustomerNumber,
      this.dealerCustomerName,
      this.customStateDescription,
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

@JsonSerializable()
class FleetSummaryResponse {
  final Links links;
  final Pagination pagination;
  final List<Fleet> fleetRecords;
  FleetSummaryResponse({this.fleetRecords, this.links, this.pagination});

  factory FleetSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$FleetSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FleetSummaryResponseToJson(this);
}

