// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) => ServiceItem(
      serviceName: json['serviceName'] as String?,
      serviceId: json['serviceId'] as num?,
      serviceDescription: json['serviceDescription'] as String?,
      serviceUID: json['serviceUID'] as String?,
      intervalCode: json['intervalCode'] as String?,
      intervalRank: json['intervalRank'] as num?,
      occurenceRank: json['occurenceRank'] as num?,
      datasource: json['datasource'] as String?,
      isManufacturerDefined: json['isManufacturerDefined'] as bool?,
      serviceType: json['serviceType'] as String?,
      smuType: json['smuType'] as String?,
      firstOccurrence: json['firstOccurrence'] as num?,
      nextOccurrence: json['nextOccurrence'] as num?,
      dueInfo: json['dueInfo'] == null
          ? null
          : DueInfo.fromJson(json['dueInfo'] as Map<String, dynamic>),
      checklists: (json['checklists'] as List<dynamic>?)
          ?.map((e) => Checklists.fromJson(e as Map<String, dynamic>))
          .toList(),
      checklist: json['checklist'] as String?,
      insertedUtc: json['insertedUtc'] as String?,
      updatedUtc: json['updatedUtc'] as String?,
      serviceSmuParams: json['serviceSmuParams'] as String?,
      intervalCreationDate: json['intervalCreationDate'] as String?,
    );

Map<String, dynamic> _$ServiceItemToJson(ServiceItem instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceName,
      'serviceId': instance.serviceId,
      'serviceDescription': instance.serviceDescription,
      'serviceUID': instance.serviceUID,
      'intervalCode': instance.intervalCode,
      'intervalRank': instance.intervalRank,
      'occurenceRank': instance.occurenceRank,
      'datasource': instance.datasource,
      'isManufacturerDefined': instance.isManufacturerDefined,
      'serviceType': instance.serviceType,
      'smuType': instance.smuType,
      'firstOccurrence': instance.firstOccurrence,
      'nextOccurrence': instance.nextOccurrence,
      'dueInfo': instance.dueInfo,
      'checklists': instance.checklists,
      'checklist': instance.checklist,
      'insertedUtc': instance.insertedUtc,
      'updatedUtc': instance.updatedUtc,
      'serviceSmuParams': instance.serviceSmuParams,
      'intervalCreationDate': instance.intervalCreationDate,
    };

DueInfo _$DueInfoFromJson(Map<String, dynamic> json) => DueInfo(
      occurrenceId: json['occurrenceId'] as num?,
      serviceStatus: json['serviceStatus'] as String?,
      dueAt: json['dueAt'] as num?,
      dueBy: json['dueBy'] as num?,
      dueDate: json['dueDate'] as String?,
      occrank: json['occrank'] as num?,
    );

Map<String, dynamic> _$DueInfoToJson(DueInfo instance) => <String, dynamic>{
      'occurrenceId': instance.occurrenceId,
      'serviceStatus': instance.serviceStatus,
      'dueAt': instance.dueAt,
      'dueBy': instance.dueBy,
      'dueDate': instance.dueDate,
      'occrank': instance.occrank,
    };

Checklists _$ChecklistsFromJson(Map<String, dynamic> json) => Checklists(
      checklistName: json['checklistName'] as String?,
      checklistId: json['checklistId'] as num?,
      isChecked: json['isChecked'] as bool?,
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => Parts.fromJson(e as Map<String, dynamic>))
          .toList(),
      checklistUID: json['checklistUID'] as String?,
      checklistCode: json['checklistCode'] as String?,
      isManufacturerDefined: json['isManufacturerDefined'] as bool?,
      datasource: json['datasource'] as String?,
      actionType: json['actionType'] as String?,
      insertedUtc: json['insertedUtc'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      updatedUtc: json['updatedUtc'] as String?,
    );

Map<String, dynamic> _$ChecklistsToJson(Checklists instance) =>
    <String, dynamic>{
      'checklistName': instance.checklistName,
      'checklistId': instance.checklistId,
      'isChecked': instance.isChecked,
      'parts': instance.parts,
      'checklistUID': instance.checklistUID,
      'checklistCode': instance.checklistCode,
      'isManufacturerDefined': instance.isManufacturerDefined,
      'datasource': instance.datasource,
      'actionType': instance.actionType,
      'insertedUtc': instance.insertedUtc,
      'updatedUtc': instance.updatedUtc,
      'isSelected': instance.isSelected,
    };

Parts _$PartsFromJson(Map<String, dynamic> json) => Parts(
      id: json['id'] as num?,
      quantity: json['quantity'] as num?,
      name: json['name'] as String?,
      partNo: json['partNo'] as String?,
      partUID: json['partUID'] as String?,
      datasource: json['datasource'] as String?,
      isManufacturerDefined: json['isManufacturerDefined'] as bool?,
      actionType: json['actionType'] as String?,
      insertedUtc: json['insertedUtc'] as String?,
      updatedUtc: json['updatedUtc'] as String?,
    );

Map<String, dynamic> _$PartsToJson(Parts instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'name': instance.name,
      'partNo': instance.partNo,
      'partUID': instance.partUID,
      'datasource': instance.datasource,
      'isManufacturerDefined': instance.isManufacturerDefined,
      'actionType': instance.actionType,
      'insertedUtc': instance.insertedUtc,
      'updatedUtc': instance.updatedUtc,
    };
