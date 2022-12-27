// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaultSummaryResponse _$FaultSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    FaultSummaryResponse(
      faults: (json['faults'] as List<dynamic>?)
          ?.map((e) => Fault.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageLinks: (json['pageLinks'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$FaultSummaryResponseToJson(
        FaultSummaryResponse instance) =>
    <String, dynamic>{
      'pageLinks': instance.pageLinks,
      'faults': instance.faults,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
    };

Fault _$FaultFromJson(Map<String, dynamic> json) => Fault(
      asset: json['asset'] == null
          ? null
          : Asset.fromJson(json['asset'] as Map<String, dynamic>),
      faultUid: json['faultUid'] as String?,
      basic: json['basic'] == null
          ? null
          : Basic.fromJson(json['basic'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : FaultDetails.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
      'asset': instance.asset,
      'faultUid': instance.faultUid,
      'basic': instance.basic,
      'details': instance.details,
    };

FaultDetails _$FaultDetailsFromJson(Map<String, dynamic> json) => FaultDetails(
      dataLinkType: json['dataLinkType'] as String?,
      faultCode: json['faultCode'] as String?,
      faultReceivedUTC: json['faultReceivedUTC'] as String?,
      occurrences: json['occurrences'] as int?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$FaultDetailsToJson(FaultDetails instance) =>
    <String, dynamic>{
      'faultCode': instance.faultCode,
      'faultReceivedUTC': instance.faultReceivedUTC,
      'dataLinkType': instance.dataLinkType,
      'occurrences': instance.occurrences,
      'url': instance.url,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      uid: json['uid'] as String?,
      basic: json['basic'] == null
          ? null
          : Basic.fromJson(json['basic'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      faultDynamic: json['dynamic'] == null
          ? null
          : FaultDynamic.fromJson(json['dynamic'] as Map<String, dynamic>),
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'uid': instance.uid,
      'details': instance.details,
      'basic': instance.basic,
      'countData': instance.countData,
      'dynamic': instance.faultDynamic,
    };

Basic _$BasicFromJson(Map<String, dynamic> json) => Basic(
      serialNumber: json['serialNumber'] as String?,
      description: json['description'] as String?,
      faultIdentifiers: json['faultIdentifiers'] as String?,
      faultOccuredUTC: json['faultOccuredUTC'] as String?,
      faultType: json['faultType'] as String?,
      isResponseReceived: json['isResponseReceived'] as bool?,
      severity: json['severity'] as String?,
      severityLabel: json['severityLabel'] as String?,
      source: json['source'] as String?,
      sourceIdentifierCode: json['sourceIdentifierCode'] as String?,
    );

Map<String, dynamic> _$BasicToJson(Basic instance) => <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'faultIdentifiers': instance.faultIdentifiers,
      'description': instance.description,
      'severityLabel': instance.severityLabel,
      'severity': instance.severity,
      'faultType': instance.faultType,
      'source': instance.source,
      'faultOccuredUTC': instance.faultOccuredUTC,
      'sourceIdentifierCode': instance.sourceIdentifierCode,
      'isResponseReceived': instance.isResponseReceived,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      productFamily: json['productFamily'] as String?,
      assetIcon: json['assetIcon'] as int?,
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => Devices.fromJson(e as Map<String, dynamic>))
          .toList(),
      dealerCode: json['dealerCode'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCustomerName: json['dealerCustomerName'] as String?,
      universalCustomerName: json['universalCustomerName'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'makeCode': instance.makeCode,
      'model': instance.model,
      'productFamily': instance.productFamily,
      'assetIcon': instance.assetIcon,
      'devices': instance.devices,
      'dealerCode': instance.dealerCode,
      'dealerName': instance.dealerName,
      'dealerCustomerName': instance.dealerCustomerName,
      'universalCustomerName': instance.universalCustomerName,
    };

Devices _$DevicesFromJson(Map<String, dynamic> json) => Devices(
      deviceType: json['deviceType'] as String?,
      deviceSerialNumber: json['deviceSerialNumber'] as String?,
      firmwareVersion: json['firmwareVersion'] as String?,
    );

Map<String, dynamic> _$DevicesToJson(Devices instance) => <String, dynamic>{
      'deviceType': instance.deviceType,
      'deviceSerialNumber': instance.deviceSerialNumber,
      'firmwareVersion': instance.firmwareVersion,
    };

FaultDynamic _$FaultDynamicFromJson(Map<String, dynamic> json) => FaultDynamic(
      status: json['status'] as String?,
      locationLatitude: (json['locationLatitude'] as num?)?.toDouble(),
      locationLongitude: (json['locationLongitude'] as num?)?.toDouble(),
      locationReportedTimeUTC: json['locationReportedTimeUTC'] as String?,
      location: json['location'] as String?,
      hourMeter: (json['hourMeter'] as num?)?.toDouble(),
      odometer: (json['odometer'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FaultDynamicToJson(FaultDynamic instance) =>
    <String, dynamic>{
      'status': instance.status,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
      'locationReportedTimeUTC': instance.locationReportedTimeUTC,
      'location': instance.location,
      'hourMeter': instance.hourMeter,
      'odometer': instance.odometer,
    };

AssetFaultSummaryResponse _$AssetFaultSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    AssetFaultSummaryResponse(
      assetFaults: (json['assetFaults'] as List<dynamic>?)
          ?.map((e) => Fault.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageLinks: (json['pageLinks'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$AssetFaultSummaryResponseToJson(
        AssetFaultSummaryResponse instance) =>
    <String, dynamic>{
      'pageLinks': instance.pageLinks,
      'assetFaults': instance.assetFaults,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
    };
