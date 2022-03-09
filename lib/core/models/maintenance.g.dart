// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceViewData _$MaintenanceViewDataFromJson(Map<String, dynamic> json) =>
    MaintenanceViewData(
      summaryData: (json['summaryData'] as List<dynamic>?)
          ?.map((e) => SummaryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as num?,
      page: json['page'] as num?,
      message: json['message'] as String?,
      pageLinks: (json['pageLinks'] as List<dynamic>?)
          ?.map((e) => PageLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as num?,
    );

Map<String, dynamic> _$MaintenanceViewDataToJson(
        MaintenanceViewData instance) =>
    <String, dynamic>{
      'summaryData': instance.summaryData,
      'limit': instance.limit,
      'page': instance.page,
      'message': instance.message,
      'pageLinks': instance.pageLinks,
      'total': instance.total,
    };

SummaryData _$SummaryDataFromJson(Map<String, dynamic> json) => SummaryData(
      rowId: json['rowId'] as num?,
      assetUID: json['assetUID'] as String?,
      assetIcon: json['assetIcon'] as num?,
      assetID: json['assetID'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      serviceType: json['serviceType'] as String?,
      service: json['service'] as String?,
      serviceId: json['serviceId'] as num?,
      currentHourMeter: json['currentHourMeter'] as num?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      geoLocation: json['geoLocation'] == null
          ? null
          : GeoLocation.fromJson(json['geoLocation'] as Map<String, dynamic>),
      lastReportedDate: json['lastReportedDate'] as String?,
      currentOdometer: json['currentOdometer'] as num?,
      assetStatus: json['assetStatus'] as String?,
      fuelConsumed: json['fuelConsumed'] as num?,
      fuelPercentage: json['fuelPercentage'] as num?,
      completedService: json['completedService'] as String?,
      dueInfo: json['dueInfo'] == null
          ? null
          : DueInfo.fromJson(json['dueInfo'] as Map<String, dynamic>),
      trackStatusID: json['trackStatusID'] as num?,
      isPaused: json['isPaused'] as bool?,
      smuType: json['smuType'] as String?,
      nextOccurrence: json['nextOccurrence'] as num?,
      dcnName: json['dcnName'] as String?,
      dcnNumber: json['dcnNumber'] as String?,
      ucid: json['ucid'] as String?,
      customerName: json['customerName'] as String?,
      customAssetState: json['customAssetState'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCode: json['dealerCode'] as String?,
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => Devices.fromJson(e as Map<String, dynamic>))
          .toList(),
      deviceType: json['deviceType'] as String?,
      geofence: (json['geofence'] as List<dynamic>?)
          ?.map((e) => GeofenceMaintenance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SummaryDataToJson(SummaryData instance) =>
    <String, dynamic>{
      'rowId': instance.rowId,
      'assetUID': instance.assetUID,
      'assetIcon': instance.assetIcon,
      'assetID': instance.assetID,
      'assetSerialNumber': instance.assetSerialNumber,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'serviceType': instance.serviceType,
      'service': instance.service,
      'serviceId': instance.serviceId,
      'currentHourMeter': instance.currentHourMeter,
      'location': instance.location,
      'geoLocation': instance.geoLocation,
      'lastReportedDate': instance.lastReportedDate,
      'currentOdometer': instance.currentOdometer,
      'assetStatus': instance.assetStatus,
      'fuelConsumed': instance.fuelConsumed,
      'fuelPercentage': instance.fuelPercentage,
      'completedService': instance.completedService,
      'dueInfo': instance.dueInfo,
      'trackStatusID': instance.trackStatusID,
      'isPaused': instance.isPaused,
      'smuType': instance.smuType,
      'nextOccurrence': instance.nextOccurrence,
      'dcnName': instance.dcnName,
      'dcnNumber': instance.dcnNumber,
      'ucid': instance.ucid,
      'customerName': instance.customerName,
      'customAssetState': instance.customAssetState,
      'dealerName': instance.dealerName,
      'dealerCode': instance.dealerCode,
      'devices': instance.devices,
      'deviceType': instance.deviceType,
      'geofence': instance.geofence,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      streetAddress: json['streetAddress'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'streetAddress': instance.streetAddress,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'country': instance.country,
    };

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) => GeoLocation(
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
    );

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

DueInfo _$DueInfoFromJson(Map<String, dynamic> json) => DueInfo(
      serviceStatus: json['serviceStatus'] as String?,
      dueAt: json['dueAt'] as num?,
      dueDate: json['dueDate'] as String?,
      dueBy: json['dueBy'] as num?,
      dueDays: json['dueDays'] as num?,
    );

Map<String, dynamic> _$DueInfoToJson(DueInfo instance) => <String, dynamic>{
      'serviceStatus': instance.serviceStatus,
      'dueAt': instance.dueAt,
      'dueDate': instance.dueDate,
      'dueBy': instance.dueBy,
      'dueDays': instance.dueDays,
    };

Devices _$DevicesFromJson(Map<String, dynamic> json) => Devices(
      deviceType: json['deviceType'] as String?,
      mainBoardSoftWareVersion: json['mainBoardSoftWareVersion'] as String?,
      assetID: json['assetID'] as num?,
    );

Map<String, dynamic> _$DevicesToJson(Devices instance) => <String, dynamic>{
      'deviceType': instance.deviceType,
      'mainBoardSoftWareVersion': instance.mainBoardSoftWareVersion,
      'assetID': instance.assetID,
    };

GeofenceMaintenance _$GeofenceMaintenanceFromJson(Map<String, dynamic> json) =>
    GeofenceMaintenance(
      siteName: json['siteName'] as String?,
      assetID: json['assetID'] as num?,
    );

Map<String, dynamic> _$GeofenceMaintenanceToJson(
        GeofenceMaintenance instance) =>
    <String, dynamic>{
      'siteName': instance.siteName,
      'assetID': instance.assetID,
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
