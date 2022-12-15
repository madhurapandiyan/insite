// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fault_code_type_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaultCodeTypeSearch _$FaultCodeTypeSearchFromJson(Map<String, dynamic> json) =>
    FaultCodeTypeSearch(
      descriptions: (json['descriptions'] as List<dynamic>?)
          ?.map((e) => FaultCodeDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      reqId: json['reqId'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$FaultCodeTypeSearchToJson(
        FaultCodeTypeSearch instance) =>
    <String, dynamic>{
      'descriptions': instance.descriptions,
      'reqId': instance.reqId,
      'total': instance.total,
    };

SingleFaultCodeTypeSearch _$SingleFaultCodeTypeSearchFromJson(
        Map<String, dynamic> json) =>
    SingleFaultCodeTypeSearch(
      faults: (json['faults'] as List<dynamic>?)
          ?.map((e) => FaultCodeDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SingleFaultCodeTypeSearchToJson(
        SingleFaultCodeTypeSearch instance) =>
    <String, dynamic>{
      'faults': instance.faults,
      'status': instance.status,
    };

FaultCodeDetails _$FaultCodeDetailsFromJson(Map<String, dynamic> json) =>
    FaultCodeDetails(
      faultCodeIdentifier: json['faultCodeIdentifier'] as String?,
      faultCodeType: json['faultCodeType'] as String?,
      faultDescription: json['faultDescription'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$FaultCodeDetailsToJson(FaultCodeDetails instance) =>
    <String, dynamic>{
      'faultCodeIdentifier': instance.faultCodeIdentifier,
      'faultDescription': instance.faultDescription,
      'faultCodeType': instance.faultCodeType,
      'isExpanded': instance.isExpanded,
    };
