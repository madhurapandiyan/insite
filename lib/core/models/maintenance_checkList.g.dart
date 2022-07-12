// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_checkList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceCheckListModel _$MaintenanceCheckListModelFromJson(
        Map<String, dynamic> json) =>
    MaintenanceCheckListModel(
      maintenanceCheckList: (json['maintenanceCheckList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      maintenanceServiceList: (json['maintenanceServiceList'] as List<dynamic>?)
          ?.map(
              (e) => MaintenanceServiceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      dueInOverdueBy: json['dueInOverdueBy'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
    );

Map<String, dynamic> _$MaintenanceCheckListModelToJson(
        MaintenanceCheckListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'serviceStatus': instance.serviceStatus,
      'dueInOverdueBy': instance.dueInOverdueBy,
      'maintenanceCheckList': instance.maintenanceCheckList,
      'maintenanceServiceList': instance.maintenanceServiceList,
    };

MaintenanceCheckListModelPop _$MaintenanceCheckListModelPopFromJson(
        Map<String, dynamic> json) =>
    MaintenanceCheckListModelPop(
      maintenanceCheckList: (json['maintenanceCheckList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListDataPop.fromJson(e as Map<String, dynamic>))
          .toList(),
      maintenanceServiceList: (json['maintenanceServiceList'] as List<dynamic>?)
          ?.map(
              (e) => MaintenanceServiceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      dueInOverdueBy: json['dueInOverdueBy'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
    );

Map<String, dynamic> _$MaintenanceCheckListModelPopToJson(
        MaintenanceCheckListModelPop instance) =>
    <String, dynamic>{
      'status': instance.status,
      'serviceStatus': instance.serviceStatus,
      'dueInOverdueBy': instance.dueInOverdueBy,
      'maintenanceCheckList': instance.maintenanceCheckList,
      'maintenanceServiceList': instance.maintenanceServiceList,
    };

MaitenanceCheckListData _$MaitenanceCheckListDataFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListData(
      checkListID: json['checkListID'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkListDescription: json['checkListDescription'] as String?,
    );

Map<String, dynamic> _$MaitenanceCheckListDataToJson(
        MaitenanceCheckListData instance) =>
    <String, dynamic>{
      'checkListName': instance.checkListName,
      'checkListID': instance.checkListID,
      'isChecked': instance.isChecked,
      'partList': instance.partList,
      'checkListDescription': instance.checkListDescription,
    };

MaitenanceCheckListDataPop _$MaitenanceCheckListDataPopFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListDataPop(
      checkListID: json['checkListID'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListDataPop.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkListDescription: json['checkListDescription'] as String?,
    );

Map<String, dynamic> _$MaitenanceCheckListDataPopToJson(
        MaitenanceCheckListDataPop instance) =>
    <String, dynamic>{
      'checkListName': instance.checkListName,
      'checkListID': instance.checkListID,
      'isChecked': instance.isChecked,
      'partList': instance.partList,
      'checkListDescription': instance.checkListDescription,
    };

MaintenanceServiceList _$MaintenanceServiceListFromJson(
        Map<String, dynamic> json) =>
    MaintenanceServiceList(
      serviceId: json['serviceId'] as int?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$MaintenanceServiceListToJson(
        MaintenanceServiceList instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceName,
      'serviceId': instance.serviceId,
    };

PartListData _$PartListDataFromJson(Map<String, dynamic> json) => PartListData(
      description: json['description'] as String?,
      partName: json['partName'] as String?,
      partId: json['partId'] as int?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as int?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataToJson(PartListData instance) =>
    <String, dynamic>{
      'partName': instance.partName,
      'partNo': instance.partNo,
      'quantity': instance.quantity,
      'partId': instance.partId,
      'description': instance.description,
      'units': instance.units,
    };

PartListDataPop _$PartListDataPopFromJson(Map<String, dynamic> json) =>
    PartListDataPop(
      description: json['description'] as String?,
      name: json['name'] as String?,
      partId: json['partId'] as int?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as int?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataPopToJson(PartListDataPop instance) =>
    <String, dynamic>{
      'name': instance.name,
      'partNo': instance.partNo,
      'quantity': instance.quantity,
      'partId': instance.partId,
      'description': instance.description,
      'units': instance.units,
    };

MaintenanceIntervals _$MaintenanceIntervalsFromJson(
        Map<String, dynamic> json) =>
    MaintenanceIntervals(
      intervalList: (json['intervalList'] as List<dynamic>?)
          ?.map((e) => IntervalList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      totalCount: json['totalCount'] as int?,
    );

Map<String, dynamic> _$MaintenanceIntervalsToJson(
        MaintenanceIntervals instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalCount': instance.totalCount,
      'intervalList': instance.intervalList,
    };

IntervalList _$IntervalListFromJson(Map<String, dynamic> json) => IntervalList(
      checkList: (json['checkList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      editable: json['editable'] as bool?,
      firstOccurrences: json['firstOccurrences'] as int?,
      intervalDescription: json['intervalDescription'] as String?,
      intervalID: json['intervalID'] as int?,
      intervalName: json['intervalName'] as String?,
    );

Map<String, dynamic> _$IntervalListToJson(IntervalList instance) =>
    <String, dynamic>{
      'intervalID': instance.intervalID,
      'intervalName': instance.intervalName,
      'firstOccurrences': instance.firstOccurrences,
      'intervalDescription': instance.intervalDescription,
      'editable': instance.editable,
      'checkList': instance.checkList,
    };
