import 'package:insite/core/models/links.dart';
import 'package:insite/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
part 'fleet.g.dart';

@JsonSerializable()
class Fleet {
  final String? assetIdentifier;
  final String? assetId;
  final String? assetSerialNumber;
  final String? manufacturer;
  final String? makeCode;
  final String? model;
  final int? assetIcon;
  final String? productFamily;
  final String? status;
  final hourMeter;
  final String? lastHourMeterUTC;
  final String? lastOdometerUTC;
  final double? odometer;
  final String? dealerCustomerName;
  final String? dealerCode;
  final String? dealerName;
  final String? universalCustomerIdentifier;
  final String? universalCustomerName;
  final String? dealerCustomerNumber;
  final String? lastLocationUpdateUTC;
  final String? customStateDescription;
  final double? fuelLevelLastReported;
  final double? lastReportedLocationLatitude;
  final double? lastReportedLocationLongitude;
  final String? lastReportedLocation;
  final String? lastReportedUTC;
  final String? lastPercentFuelRemainingUTC;
  final double? lifetimeFuelLiters;
  final String? lastLifetimeFuelLitersUTC;
  final double? notifications;
  final String? lastOperatorName;
  final String? lastOperatorID;
  final double? modelYear;
  final List<FleetGeofence>? geofences;
  final List<FleetDevices>? devices;

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
      this.universalCustomerName,
      this.geofences,
      this.devices});
  factory Fleet.fromJson(Map<String, dynamic> json) => _$FleetFromJson(json);

  Map<String, dynamic> toJson() => _$FleetToJson(this);
}

@JsonSerializable()
class FleetSummaryResponse {
  final Links? links;
  final Pagination? pagination;
  final List<Fleet>? fleetRecords;
  FleetSummaryResponse({this.fleetRecords, this.links, this.pagination});

  factory FleetSummaryResponse.fromJson(Map<String, dynamic>? json) {
    return _$FleetSummaryResponseFromJson(json!);
  }

  Map<String, dynamic> toJson() => _$FleetSummaryResponseToJson(this);
}

@JsonSerializable()
class FleetGeofence {
  final String? fenceIdentifier;
  final String? name;
  final String? areaSqM;
  FleetGeofence({this.areaSqM, this.fenceIdentifier, this.name});
  factory FleetGeofence.fromJson(Map<String, dynamic>? json) {
    return _$FleetGeofenceFromJson(json!);
  }

  Map<String, dynamic> toJson() => _$FleetGeofenceToJson(this);
}

@JsonSerializable()
class FleetDevices {
  final String? deviceType;
  final bool? isGpsRollOverAffected;
  final String? mainboardSoftwareVersion;
  final String? deviceSerialNumber;
  FleetDevices(
      {this.deviceSerialNumber,
      this.deviceType,
      this.isGpsRollOverAffected,
      this.mainboardSoftwareVersion});

  factory FleetDevices.fromJson(Map<String, dynamic>? json) {
    return _$FleetDevicesFromJson(json!);
  }
  Map<String, dynamic> toJson() => _$FleetDevicesToJson(this);
}
