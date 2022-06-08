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
    );

Map<String, dynamic> _$MaintenanceCheckListModelToJson(
        MaintenanceCheckListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'maintenanceCheckList': instance.maintenanceCheckList,
      'maintenanceServiceList': instance.maintenanceServiceList,
    };

MaitenanceCheckListData _$MaitenanceCheckListDataFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListData(
      checkListId: json['checkListId'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaitenanceCheckListDataToJson(
        MaitenanceCheckListData instance) =>
    <String, dynamic>{
      'checkListName': instance.checkListName,
      'checkListId': instance.checkListId,
      'isChecked': instance.isChecked,
      'partList': instance.partList,
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
      name: json['name'] as String?,
      partId: json['partId'] as int?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as int?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataToJson(PartListData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'partNo': instance.partNo,
      'quantity': instance.quantity,
      'partId': instance.partId,
      'description': instance.description,
      'units': instance.units,
    };
