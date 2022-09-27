import 'package:json_annotation/json_annotation.dart';
part 'maintenance_checkList.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaintenanceCheckListModel {
  final String? status;
  final String? serviceStatus;
  final String? dueInOverdueBy;
  final List<MaitenanceCheckListData>? maintenanceCheckList;
  final List<MaintenanceServiceList>? maintenanceServiceList;
  MaintenanceCheckListModel(
      {this.maintenanceCheckList,
      this.maintenanceServiceList,
      this.status,
      this.dueInOverdueBy,
      this.serviceStatus});

  factory MaintenanceCheckListModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceCheckListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceCheckListModelToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaintenanceCheckListModelPop {
  final String? status;
  final String? serviceStatus;
  final String? dueInOverdueBy;
  final List<MaitenanceCheckListDataPop>? maintenanceCheckList;
  final List<MaintenanceServiceList>? maintenanceServiceList;
  MaintenanceCheckListModelPop(
      {this.maintenanceCheckList,
      this.maintenanceServiceList,
      this.status,
      this.dueInOverdueBy,
      this.serviceStatus});

  factory MaintenanceCheckListModelPop.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceCheckListModelPopFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceCheckListModelPopToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaitenanceCheckListData {
  final String? checkListName;
  final int? checkListID;
  final bool? isChecked;
  final List<PartListData>? partList;
  final String? checkListDescription;
  MaitenanceCheckListData(
      {this.checkListID,
      this.checkListName,
      this.isChecked,
      this.partList,
      this.checkListDescription});

  factory MaitenanceCheckListData.fromJson(Map<String, dynamic> json) =>
      _$MaitenanceCheckListDataFromJson(json);

  Map<String, dynamic> toJson() => _$MaitenanceCheckListDataToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaitenanceCheckListDataPop {
  final String? checkListName;
  final int? checkListID;
  final bool? isChecked;
  final List<PartListDataPop>? partList;
  final String? checkListDescription;
  MaitenanceCheckListDataPop(
      {this.checkListID,
      this.checkListName,
      this.isChecked,
      this.partList,
      this.checkListDescription});

  factory MaitenanceCheckListDataPop.fromJson(Map<String, dynamic> json) =>
      _$MaitenanceCheckListDataPopFromJson(json);

  Map<String, dynamic> toJson() => _$MaitenanceCheckListDataPopToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaintenanceServiceList {
  final String? serviceName;
  final int? serviceId;
  MaintenanceServiceList({this.serviceId, this.serviceName});

  factory MaintenanceServiceList.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceServiceListFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceServiceListToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PartListData {
  final String? partName;
  final String? partNo;
  final String? description;
  final String? units;
  final int? quantity;
  final int? partId;

  PartListData(
      {this.description,
      this.partName,
      this.partId,
      this.partNo,
      this.quantity,
      this.units});

  factory PartListData.fromJson(Map<String, dynamic> json) =>
      _$PartListDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartListDataToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PartListDataPop {
  final String? name;
  final String? partNo;
  final int? quantity;
  final int? partId;
  final String? description;
  final String? units;
  PartListDataPop(
      {this.description,
      this.name,
      this.partId,
      this.partNo,
      this.quantity,
      this.units});

  factory PartListDataPop.fromJson(Map<String, dynamic> json) =>
      _$PartListDataPopFromJson(json);

  Map<String, dynamic> toJson() => _$PartListDataPopToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaintenanceIntervals {
  final String? status;
  final int? totalCount;
  final List<IntervalList>? intervalList;
  MaintenanceIntervals({this.intervalList, this.status, this.totalCount});

  factory MaintenanceIntervals.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceIntervalsFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceIntervalsToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class IntervalList {
  final int? intervalID;
  final String? intervalName;
  final int? firstOccurrences;
  final String? intervalDescription;
  final bool? editable;
  final List<MaitenanceCheckListData>? checkList;
  IntervalList(
      {this.checkList,
      this.editable,
      this.firstOccurrences,
      this.intervalDescription,
      this.intervalID,
      this.intervalName});

  factory IntervalList.fromJson(Map<String, dynamic> json) =>
      _$IntervalListFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalListToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AddMaintenanceIntervalPayload {
  String? intervalName;
  int? initialOccurence;
  String? description;
  List<MaitenanceCheckListDataPayLoad>? checklist;
  String? assetId;
  String? serialNumber;
  String? make;
  String? model;
  double? currentHourMeter;
  String? units;
  AddMaintenanceIntervalPayload(
      {this.assetId,
      this.checklist,
      this.currentHourMeter,
      this.description,
      this.initialOccurence,
      this.intervalName,
      this.make,
      this.model,
      this.serialNumber,
      this.units});
  factory AddMaintenanceIntervalPayload.fromJson(Map<String, dynamic> json) =>
      _$AddMaintenanceIntervalPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$AddMaintenanceIntervalPayloadToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PartListDataPayLoad {
  final String? partName;
  final String? partNo;

  final String? units;
  final int? quantity;

  PartListDataPayLoad({this.partName, this.partNo, this.quantity, this.units});

  factory PartListDataPayLoad.fromJson(Map<String, dynamic> json) =>
      _$PartListDataPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$PartListDataPayLoadToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MaitenanceCheckListDataPayLoad {
  final String? checkListName;
  final int? checkListID;
  final bool? isChecked;
  final List<PartListDataPayLoad>? partList;
  final String? checkListDescription;
  MaitenanceCheckListDataPayLoad(
      {this.checkListID,
      this.checkListName,
      this.isChecked,
      this.partList,
      this.checkListDescription});

  factory MaitenanceCheckListDataPayLoad.fromJson(Map<String, dynamic> json) =>
      _$MaitenanceCheckListDataPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$MaitenanceCheckListDataPayLoadToJson(this);
}
