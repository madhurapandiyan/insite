import 'package:json_annotation/json_annotation.dart';
part 'maintenance.g.dart';

@JsonSerializable()
class MaintenanceViewData {
  List<SummaryData>? summaryData;
  num? limit;
  num? page;
  String? message;
  List<PageLinks>? pageLinks;
  num? total;

  MaintenanceViewData(
      {this.summaryData,
      this.limit,
      this.page,
      this.message,
      this.pageLinks,
      this.total});

  factory MaintenanceViewData.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceViewDataFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceViewDataToJson(this);
}

@JsonSerializable()
class SummaryData {
  num? rowId;
  String? assetUID;
  num? assetIcon;
  String? assetID;
  String? assetSerialNumber;
  String? makeCode;
  String? model;
  String? serviceType;
  String? service;
  num? serviceId;
  num? currentHourMeter;
  Location? location;
  GeoLocation? geoLocation;
  String? lastReportedDate;
  num? currentOdometer;
  String? assetStatus;
  num? fuelConsumed;
  num? fuelPercentage;
  String? completedService;
  DueInfo? dueInfo;
  num? trackStatusID;
  bool? isPaused;
  String? smuType;
  num? nextOccurrence;
  String? dcnName;
  String? dcnNumber;
  String? ucid;
  String? customerName;
  String? customAssetState;
  String? dealerName;
  String? dealerCode;
  List<Devices>? devices;
  String? deviceType;
  List<GeofenceMaintenance>? geofence;
  @JsonKey(ignore: true)
  String? productFamily;
  @JsonKey(ignore: true)
  String? serviceCompletedDate;
  @JsonKey(ignore: true)
  String? fuelReportedTime;
  @JsonKey(ignore: true)
  String? telematicDeviceId;

  SummaryData(
      {this.rowId,
      this.serviceCompletedDate,
      this.fuelReportedTime,
      this.telematicDeviceId,
      this.assetUID,
      this.assetIcon,
      this.assetID,
      this.assetSerialNumber,
      this.makeCode,
      this.model,
      this.serviceType,
      this.service,
      this.serviceId,
      this.currentHourMeter,
      this.location,
      this.geoLocation,
      this.lastReportedDate,
      this.currentOdometer,
      this.assetStatus,
      this.fuelConsumed,
      this.fuelPercentage,
      this.completedService,
      this.dueInfo,
      this.trackStatusID,
      this.isPaused,
      this.smuType,
      this.nextOccurrence,
      this.dcnName,
      this.dcnNumber,
      this.ucid,
      this.customerName,
      this.customAssetState,
      this.dealerName,
      this.dealerCode,
      this.devices,
      this.deviceType,
      this.geofence,
      this.productFamily});

  factory SummaryData.fromJson(Map<String, dynamic> json) =>
      _$SummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryDataToJson(this);
}

@JsonSerializable()
class Location {
  String? streetAddress;
  String? city;
  String? state;
  String? zip;
  String? country;

  Location({this.streetAddress, this.city, this.state, this.zip, this.country});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class GeoLocation {
  num? latitude;
  num? longitude;

  GeoLocation({this.latitude, this.longitude});
  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}

@JsonSerializable()
class DueInfo {
  String? serviceStatus;
  num? dueAt;
  String? dueDate;
  num? dueBy;
  num? dueDays;

  DueInfo(
      {this.serviceStatus, this.dueAt, this.dueDate, this.dueBy, this.dueDays});
  factory DueInfo.fromJson(Map<String, dynamic> json) =>
      _$DueInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DueInfoToJson(this);
}

@JsonSerializable()
class Devices {
  String? deviceType;
  String? mainBoardSoftWareVersion;
  num? assetID;

  Devices({this.deviceType, this.mainBoardSoftWareVersion, this.assetID});

  factory Devices.fromJson(Map<String, dynamic> json) =>
      _$DevicesFromJson(json);

  Map<String, dynamic> toJson() => _$DevicesToJson(this);
}

@JsonSerializable()
class GeofenceMaintenance {
  String? siteName;
  num? assetID;

  GeofenceMaintenance({this.siteName, this.assetID});

  factory GeofenceMaintenance.fromJson(Map<String, dynamic> json) =>
      _$GeofenceMaintenanceFromJson(json);

  Map<String, dynamic> toJson() => _$GeofenceMaintenanceToJson(this);
}

@JsonSerializable()
class PageLinks {
  String? rel;
  String? href;
  String? method;

  PageLinks({this.rel, this.href, this.method});
  factory PageLinks.fromJson(Map<String, dynamic> json) =>
      _$PageLinksFromJson(json);

  Map<String, dynamic> toJson() => _$PageLinksToJson(this);
}
