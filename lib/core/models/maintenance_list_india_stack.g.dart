// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_list_india_stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceListData _$MaintenanceListDataFromJson(Map<String, dynamic> json) =>
    MaintenanceListData(
      status: json['status'] as String?,
      maintenanceList: (json['maintenanceList'] as List<dynamic>?)
          ?.map((e) => MaintenanceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$MaintenanceListDataToJson(
        MaintenanceListData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'maintenanceList': instance.maintenanceList,
      'count': instance.count,
    };

MaintenanceList _$MaintenanceListFromJson(Map<String, dynamic> json) =>
    MaintenanceList(
      serviceNumber: json['serviceNumber'] as int?,
      customerName: json['customerName'] as String?,
      assetId: json['assetId'] as String?,
      assetName: json['assetName'] as String?,
      assetIcon: json['assetIcon'] as int?,
      serialNumber: json['serialNumber'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      modelYear: json['modelYear'] as String?,
      productFamily: json['productFamily'] as String?,
      currentHourMeter: (json['currentHourMeter'] as num?)?.toDouble(),
      lastLocationReportedDate: json['lastLocationReportedDate'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      streetAddress: json['streetAddress'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      county: json['county'] as String?,
      country: json['country'] as String?,
      zip: json['zip'] as String?,
      odometer: (json['odometer'] as num?)?.toDouble(),
      lastReportedDate: json['lastReportedDate'] as String?,
      percentFuelRemaining: json['percentFuelRemaining'] as int?,
      fuelLastReportedTime: json['fuelLastReportedTime'] as String?,
      serviceInterval: json['serviceInterval'] as String?,
      status: json['status'] as String?,
      serviceName: json['serviceName'] as String?,
      dueAt: json['dueAt'] as int?,
      dueDate: json['dueDate'] as String?,
      serviceType: json['serviceType'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
      assetType: json['assetType'] as String?,
      telematicsDeviceId: json['telematicsDeviceId'] as String?,
      deviceType: json['deviceType'] as String?,
      source: json['source'] as String?,
      serviceDate: json['serviceDate'] as String?,
      serviceMeter: json['serviceMeter'] as int?,
      performedBy: json['performedBy'] as String?,
      serviceNotes: json['serviceNotes'] as String?,
      dueInOverdueBy: (json['dueInOverdueBy'] as num?)?.toDouble(),
      completedService: json['completedService'] as String?,
      address: json['address'] as String?,
      workOrder: json['workOrder'] as String?,
    );

Map<String, dynamic> _$MaintenanceListToJson(MaintenanceList instance) =>
    <String, dynamic>{
      'serviceNumber': instance.serviceNumber,
      'customerName': instance.customerName,
      'assetId': instance.assetId,
      'assetName': instance.assetName,
      'assetIcon': instance.assetIcon,
      'serialNumber': instance.serialNumber,
      'make': instance.make,
      'model': instance.model,
      'modelYear': instance.modelYear,
      'productFamily': instance.productFamily,
      'currentHourMeter': instance.currentHourMeter,
      'lastLocationReportedDate': instance.lastLocationReportedDate,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'streetAddress': instance.streetAddress,
      'city': instance.city,
      'state': instance.state,
      'county': instance.county,
      'country': instance.country,
      'zip': instance.zip,
      'odometer': instance.odometer,
      'lastReportedDate': instance.lastReportedDate,
      'percentFuelRemaining': instance.percentFuelRemaining,
      'fuelLastReportedTime': instance.fuelLastReportedTime,
      'serviceInterval': instance.serviceInterval,
      'status': instance.status,
      'serviceName': instance.serviceName,
      'dueAt': instance.dueAt,
      'dueDate': instance.dueDate,
      'serviceType': instance.serviceType,
      'serviceStatus': instance.serviceStatus,
      'assetType': instance.assetType,
      'telematicsDeviceId': instance.telematicsDeviceId,
      'deviceType': instance.deviceType,
      'source': instance.source,
      'serviceDate': instance.serviceDate,
      'serviceMeter': instance.serviceMeter,
      'performedBy': instance.performedBy,
      'serviceNotes': instance.serviceNotes,
      'dueInOverdueBy': instance.dueInOverdueBy,
      'completedService': instance.completedService,
      'address': instance.address,
      'workOrder': instance.workOrder,
    };
