// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_list_services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceListService _$MaintenanceListServiceFromJson(
        Map<String, dynamic> json) =>
    MaintenanceListService(
      assetData: json['assetData'] == null
          ? null
          : AssetData.fromJson(json['assetData'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Services.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as num?,
      page: json['page'] as num?,
      message: json['message'] as String?,
      pageLinks: (json['pageLinks'] as List<dynamic>?)
          ?.map((e) => PageLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as num?,
      assetPause: json['assetPause'] as String?,
    );

Map<String, dynamic> _$MaintenanceListServiceToJson(
        MaintenanceListService instance) =>
    <String, dynamic>{
      'assetData': instance.assetData,
      'services': instance.services,
      'limit': instance.limit,
      'page': instance.page,
      'message': instance.message,
      'pageLinks': instance.pageLinks,
      'total': instance.total,
      'assetPause': instance.assetPause,
    };

AssetData _$AssetDataFromJson(Map<String, dynamic> json) => AssetData(
      assetUID: json['assetUID'] as String?,
      assetID: json['assetID'] as String?,
      assetName: json['assetName'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      assetIcon: json['assetIcon'] as num?,
      currentHourmeter: json['currentHourmeter'] as num?,
      currentOdometer: json['currentOdometer'] as num?,
      isAverageHourMeter: json['isAverageHourMeter'] as bool?,
      isAverageOdometer: json['isAverageOdometer'] as bool?,
      assetIdVal: json['assetIdVal'] as num?,
      trackStatusID: json['trackStatusID'] as num?,
      isPaused: json['isPaused'] as bool?,
      updateUTC: json['updateUTC'] as String?,
      assetType: json['assetType'] as String?,
    );

Map<String, dynamic> _$AssetDataToJson(AssetData instance) => <String, dynamic>{
      'assetUID': instance.assetUID,
      'assetID': instance.assetID,
      'assetName': instance.assetName,
      'assetSerialNumber': instance.assetSerialNumber,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'assetIcon': instance.assetIcon,
      'currentHourmeter': instance.currentHourmeter,
      'currentOdometer': instance.currentOdometer,
      'isAverageHourMeter': instance.isAverageHourMeter,
      'isAverageOdometer': instance.isAverageOdometer,
      'assetIdVal': instance.assetIdVal,
      'trackStatusID': instance.trackStatusID,
      'isPaused': instance.isPaused,
      'updateUTC': instance.updateUTC,
      'assetType': instance.assetType,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
      serviceName: json['serviceName'] as String?,
      serviceId: json['serviceId'] as int?,
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
          : DueInfomation.fromJson(json['dueInfo'] as Map<String, dynamic>),
      checklists: json['checklists'] as String?,
      checklist: json['checklist'] as String?,
      insertedUtc: json['insertedUtc'] as String?,
      updatedUtc: json['updatedUtc'] as String?,
      serviceSmuParams: json['serviceSmuParams'] as String?,
      intervalCreationDate: json['intervalCreationDate'] as String?,
    );

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
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

DueInfomation _$DueInfomationFromJson(Map<String, dynamic> json) =>
    DueInfomation(
      occurrenceId: json['occurrenceId'] as num?,
      serviceStatus: json['serviceStatus'] as String?,
      dueAt: json['dueAt'] as num?,
      dueBy: json['dueBy'] as num?,
      dueDate: json['dueDate'] as String?,
      occrank: json['occrank'] as num?,
    );

Map<String, dynamic> _$DueInfomationToJson(DueInfomation instance) =>
    <String, dynamic>{
      'occurrenceId': instance.occurrenceId,
      'serviceStatus': instance.serviceStatus,
      'dueAt': instance.dueAt,
      'dueBy': instance.dueBy,
      'dueDate': instance.dueDate,
      'occrank': instance.occrank,
    };

PageLinks _$PageLinksFromJson(Map<String, dynamic> json) => PageLinks(
      rel: json['rel'] as String?,
      href: json['href'] as String?,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$PageLinksToJson(PageLinks instance) => <String, dynamic>{
      'rel': instance.rel,
      'href': instance.href,
      'method': instance.method,
    };
