import 'package:json_annotation/json_annotation.dart';
part 'maintenance_checkList.g.dart';

@JsonSerializable()
class MaintenanceCheckListModel {
  final String? status;
  final List<MaitenanceCheckListData>? maintenanceCheckList;
  final List<MaintenanceServiceList>? maintenanceServiceList;
  MaintenanceCheckListModel(
      {this.maintenanceCheckList, this.maintenanceServiceList, this.status});

  factory MaintenanceCheckListModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceCheckListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceCheckListModelToJson(this);
}

@JsonSerializable()
class MaitenanceCheckListData {
  final String? checkListName;
  final int? checkListId;
  final bool? isChecked;
  final List<PartListData>? partList;
  MaitenanceCheckListData(
      {this.checkListId, this.checkListName, this.isChecked, this.partList});

  factory MaitenanceCheckListData.fromJson(Map<String, dynamic> json) =>
      _$MaitenanceCheckListDataFromJson(json);

  Map<String, dynamic> toJson() => _$MaitenanceCheckListDataToJson(this);
}

@JsonSerializable()
class MaintenanceServiceList {
  final String? serviceName;
  final int? serviceId;
  MaintenanceServiceList({this.serviceId, this.serviceName});

  factory MaintenanceServiceList.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceServiceListFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceServiceListToJson(this);
}

@JsonSerializable()
class PartListData {
  final String? name;
  final String? partNo;
  final int? quantity;
  final int? partId;
  final String? description;
  final String? units;
  PartListData(
      {this.description,
      this.name,
      this.partId,
      this.partNo,
      this.quantity,
      this.units});

  factory PartListData.fromJson(Map<String, dynamic> json) =>
      _$PartListDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartListDataToJson(this);
}
