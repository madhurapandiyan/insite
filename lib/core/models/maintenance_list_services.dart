import 'package:json_annotation/json_annotation.dart';
part 'maintenance_list_services.g.dart';

@JsonSerializable()
class MaintenanceListService {
  AssetData? assetData;
  List<Services>? services;
  num? limit;
  num? page;
  String? message;
  List<PageLinks>? pageLinks;
  num? total;
  String? assetPause;

  MaintenanceListService(
      {this.assetData,
      this.services,
      this.limit,
      this.page,
      this.message,
      this.pageLinks,
      this.total,
      this.assetPause});
  factory MaintenanceListService.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceListServiceFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceListServiceToJson(this);
}

@JsonSerializable()
class AssetData {
  String? assetUID;
  String? assetID;
  String? assetName;
  String? assetSerialNumber;
  String? makeCode;
  String? model;
  num? assetIcon;
  num? currentHourmeter;
  num? currentOdometer;
  bool? isAverageHourMeter;
  bool? isAverageOdometer;
  num? assetIdVal;
  num? trackStatusID;
  bool? isPaused;
  String? updateUTC;
  String? assetType;

  AssetData(
      {this.assetUID,
      this.assetID,
      this.assetName,
      this.assetSerialNumber,
      this.makeCode,
      this.model,
      this.assetIcon,
      this.currentHourmeter,
      this.currentOdometer,
      this.isAverageHourMeter,
      this.isAverageOdometer,
      this.assetIdVal,
      this.trackStatusID,
      this.isPaused,
      this.updateUTC,
      this.assetType});
  factory AssetData.fromJson(Map<String, dynamic> json) =>
      _$AssetDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDataToJson(this);
}

@JsonSerializable()
class Services {
  String? serviceName;
  int? serviceId;
  String? serviceDescription;
  String? serviceUID;
  String? intervalCode;
  num? intervalRank;
  num? occurenceRank;
  String? datasource;
  bool? isManufacturerDefined;
  String? serviceType;
  String? smuType;
  num? firstOccurrence;
  num? nextOccurrence;
  DueInfomation? dueInfo;
  String? checklists;
  String? checklist;
  String? insertedUtc;
  String? updatedUtc;
  String? serviceSmuParams;
  String? intervalCreationDate;

  Services(
      {this.serviceName,
      this.serviceId,
      this.serviceDescription,
      this.serviceUID,
      this.intervalCode,
      this.intervalRank,
      this.occurenceRank,
      this.datasource,
      this.isManufacturerDefined,
      this.serviceType,
      this.smuType,
      this.firstOccurrence,
      this.nextOccurrence,
      this.dueInfo,
      this.checklists,
      this.checklist,
      this.insertedUtc,
      this.updatedUtc,
      this.serviceSmuParams,
      this.intervalCreationDate});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable()
class DueInfomation {
  num? occurrenceId;
  String? serviceStatus;
  num? dueAt;
  num? dueBy;
  String? dueDate;
  num? occrank;

  DueInfomation(
      {this.occurrenceId,
      this.serviceStatus,
      this.dueAt,
      this.dueBy,
      this.dueDate,
      this.occrank});

  factory DueInfomation.fromJson(Map<String, dynamic> json) =>
      _$DueInfomationFromJson(json);

  Map<String, dynamic> toJson() => _$DueInfomationToJson(this);
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
