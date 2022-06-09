// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_asset_india_stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceAssetList _$MaintenanceAssetListFromJson(
        Map<String, dynamic> json) =>
    MaintenanceAssetList(
      status: json['status'] as String?,
      assetMaintenanceList: (json['assetMaintenanceList'] as List<dynamic>?)
          ?.map((e) => AssetMaintenanceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$MaintenanceAssetListToJson(
        MaintenanceAssetList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'assetMaintenanceList': instance.assetMaintenanceList,
      'count': instance.count,
    };

AssetMaintenanceList _$AssetMaintenanceListFromJson(
        Map<String, dynamic> json) =>
    AssetMaintenanceList(
      count: json['count'] as int?,
      customerAssetID: json['customerAssetID'] as int?,
      assetId: json['assetId'] as String?,
      assetName: json['assetName'] as String?,
      serialNumber: json['serialNumber'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      currentHourMeter: json['currentHourMeter'] as num?,
      servicedescription: json['servicedescription'] as String?,
      serviceStatusName: json['serviceStatusName'] as String?,
      serviceName: json['serviceName'] as String?,
      maintenanceTotals: (json['maintenanceTotals'] as List<dynamic>?)
          ?.map((e) => MaintenanceTotals.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetMaintenanceListToJson(
        AssetMaintenanceList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'customerAssetID': instance.customerAssetID,
      'assetId': instance.assetId,
      'assetName': instance.assetName,
      'serialNumber': instance.serialNumber,
      'make': instance.make,
      'model': instance.model,
      'currentHourMeter': instance.currentHourMeter,
      'servicedescription': instance.servicedescription,
      'serviceStatusName': instance.serviceStatusName,
      'serviceName': instance.serviceName,
      'maintenanceTotals': instance.maintenanceTotals,
    };

MaintenanceTotals _$MaintenanceTotalsFromJson(Map<String, dynamic> json) =>
    MaintenanceTotals(
      count: json['count'] as int?,
      name: json['name'] as String?,
      alias: json['alias'] as String?,
    );

Map<String, dynamic> _$MaintenanceTotalsToJson(MaintenanceTotals instance) =>
    <String, dynamic>{
      'count': instance.count,
      'name': instance.name,
      'alias': instance.alias,
    };
