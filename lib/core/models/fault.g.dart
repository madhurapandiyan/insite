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
      asset: json['asset'],
      basic: json['basic'] == null
          ? null
          : FaultBasic.fromJson(json['basic'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : FaultDetails.fromJson(json['details'] as Map<String, dynamic>),
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      faultCode: json['faultCode'] as String?,
      hours: (json['hours'] as num?)?.toDouble(),
      faultType: json['faultType'] as String?,
      faultOccuredUTC: json['faultOccuredUTC'] as String?,
      severityLabel: json['severityLabel'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
      'asset': instance.asset,
      'description': instance.description,
      'faultType': instance.faultType,
      'hours': instance.hours,
      'severityLabel': instance.severityLabel,
      'faultOccuredUTC': instance.faultOccuredUTC,
      'source': instance.source,
      'faultCode': instance.faultCode,
      'basic': instance.basic,
      'details': instance.details,
      'countData': instance.countData,
    };

FaultAsset _$FaultAssetFromJson(Map<String, dynamic> json) => FaultAsset(
      uid: json['uid'] as String?,
      basic: json['basic'],
      details: json['details'],
    );

Map<String, dynamic> _$FaultAssetToJson(FaultAsset instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'basic': instance.basic,
      'details': instance.details,
    };

FaultDynamic _$FaultDynamicFromJson(Map<String, dynamic> json) => FaultDynamic(
      status: json['status'] as String?,
      location: json['location'] as String?,
      locationReportedTimeUTC: json['locationReportedTimeUTC'] as String?,
      hourMeter: json['hourMeter'] as String?,
      odometer: json['odometer'] as String?,
    );

Map<String, dynamic> _$FaultDynamicToJson(FaultDynamic instance) =>
    <String, dynamic>{
      'status': instance.status,
      'location': instance.location,
      'locationReportedTimeUTC': instance.locationReportedTimeUTC,
      'hourMeter': instance.hourMeter,
      'odometer': instance.odometer,
    };

FaultBasic _$FaultBasicFromJson(Map<String, dynamic> json) => FaultBasic(
      faultIdentifiers: json['faultIdentifiers'] as String?,
      description: json['description'] as String?,
      source: json['source'] as String?,
      faultOccuredUTC: json['faultOccuredUTC'] as String?,
      faultType: json['faultType'] as String?,
      severity: json['severity'] as String?,
    );

Map<String, dynamic> _$FaultBasicToJson(FaultBasic instance) =>
    <String, dynamic>{
      'faultIdentifiers': instance.faultIdentifiers,
      'description': instance.description,
      'source': instance.source,
      'severity': instance.severity,
      'faultType': instance.faultType,
      'faultOccuredUTC': instance.faultOccuredUTC,
    };

FaultDetails _$FaultDetailsFromJson(Map<String, dynamic> json) => FaultDetails(
      faultReceivedUTC: json['faultReceivedUTC'] as String?,
      faultCode: json['faultCode'] as String?,
    );

Map<String, dynamic> _$FaultDetailsToJson(FaultDetails instance) =>
    <String, dynamic>{
      'faultReceivedUTC': instance.faultReceivedUTC,
      'faultCode': instance.faultCode,
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
