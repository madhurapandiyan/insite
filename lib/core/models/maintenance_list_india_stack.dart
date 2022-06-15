import 'package:json_annotation/json_annotation.dart';
part 'maintenance_list_india_stack.g.dart';

@JsonSerializable()
class MaintenanceListData {
  String? status;
  List<MaintenanceList>? maintenanceList;
  int? count;

  MaintenanceListData({this.status, this.maintenanceList, this.count});

  factory MaintenanceListData.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceListDataToJson(this);
}

@JsonSerializable()
class MaintenanceList {
  int? serviceNumber;
  String? customerName;
  String? assetId;
  String? assetName;
  int? assetIcon;
  String? serialNumber;
  String? make;
  String? model;
  String? modelYear;
  String? productFamily;
  double? currentHourMeter;
  String? lastLocationReportedDate;
  double? longitude;
  double? latitude;
  String? streetAddress;
  String? city;
  String? state;
  String? county;
  String? country;
  String? zip;
  double? odometer;
  String? lastReportedDate;
  num? percentFuelRemaining;
  String? fuelLastReportedTime;
  String? serviceInterval;
  String? status;
  String? serviceName;
  int? dueAt;
  String? dueDate;
  String? serviceType;
  String? serviceStatus;
  String? assetType;
  String? telematicsDeviceId;
  String? deviceType;
  String? source;
  String? serviceDate;
  int? serviceMeter;
  String? performedBy;
  String? serviceNotes;
  double? dueInOverdueBy;
  String? completedService;
  String? address;
  String? workOrder;

  MaintenanceList(
      {this.serviceNumber,
      this.customerName,
      this.assetId,
      this.assetName,
      this.assetIcon,
      this.serialNumber,
      this.make,
      this.model,
      this.modelYear,
      this.productFamily,
      this.currentHourMeter,
      this.lastLocationReportedDate,
      this.longitude,
      this.latitude,
      this.streetAddress,
      this.city,
      this.state,
      this.county,
      this.country,
      this.zip,
      this.odometer,
      this.lastReportedDate,
      this.percentFuelRemaining,
      this.fuelLastReportedTime,
      this.serviceInterval,
      this.status,
      this.serviceName,
      this.dueAt,
      this.dueDate,
      this.serviceType,
      this.serviceStatus,
      this.assetType,
      this.telematicsDeviceId,
      this.deviceType,
      this.source,
      this.serviceDate,
      this.serviceMeter,
      this.performedBy,
      this.serviceNotes,
      this.dueInOverdueBy,
      this.completedService,
      this.address,
      this.workOrder});

  factory MaintenanceList.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceListFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceListToJson(this);
}
