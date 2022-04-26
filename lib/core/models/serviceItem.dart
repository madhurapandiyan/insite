import 'package:json_annotation/json_annotation.dart';
part 'serviceItem.g.dart';

@JsonSerializable()
class ServiceItem {
  String? serviceName;
  num? serviceId;
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
  DueInfo? dueInfo;
  List<Checklists>? checklists;
  String? checklist;
  String? insertedUtc;
  String? updatedUtc;
  String? serviceSmuParams;
  String? intervalCreationDate;

  ServiceItem(
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

  factory ServiceItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceItemToJson(this);
}

@JsonSerializable()
class DueInfo {
  num? occurrenceId;
  String? serviceStatus;
  num? dueAt;
  num? dueBy;
  String? dueDate;
  num? occrank;

  DueInfo(
      {this.occurrenceId,
      this.serviceStatus,
      this.dueAt,
      this.dueBy,
      this.dueDate,
      this.occrank});

  factory DueInfo.fromJson(Map<String, dynamic> json) =>
      _$DueInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DueInfoToJson(this);
}

@JsonSerializable()
class Checklists {
  String? checklistName;
  num? checklistId;
  bool? isChecked;
  List<Parts>? parts;
  String? checklistUID;
  String? checklistCode;
  bool? isManufacturerDefined;
  String? datasource;
  String? actionType;
  String? insertedUtc;
  String? updatedUtc;
  final bool isSelected;

  Checklists(
      {this.checklistName,
      this.checklistId,
      this.isChecked,
      this.parts,
      this.checklistUID,
      this.checklistCode,
      this.isManufacturerDefined,
      this.datasource,
      this.actionType,
      this.insertedUtc,
      this.isSelected = false,
      this.updatedUtc});
  factory Checklists.fromJson(Map<String, dynamic> json) =>
      _$ChecklistsFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistsToJson(this);
}

@JsonSerializable()
class Parts {
  num? id;
  num? quantity;
  String? name;
  String? partNo;
  String? partUID;
  String? datasource;
  bool? isManufacturerDefined;
  String? actionType;
  String? insertedUtc;
  String? updatedUtc;

  Parts(
      {this.id,
      this.quantity,
      this.name,
      this.partNo,
      this.partUID,
      this.datasource,
      this.isManufacturerDefined,
      this.actionType,
      this.insertedUtc,
      this.updatedUtc});

  factory Parts.fromJson(Map<String, dynamic> json) => _$PartsFromJson(json);

  Map<String, dynamic> toJson() => _$PartsToJson(this);
}
