// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_smmary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsSummaryModel _$SmsSummaryModelFromJson(Map<String, dynamic> json) =>
    SmsSummaryModel(
      getSMSSummaryReport: (json['getSMSSummaryReport'] as List<dynamic>?)
          ?.map((e) => GetSMSSummaryReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SmsSummaryModelToJson(SmsSummaryModel instance) =>
    <String, dynamic>{
      'getSMSSummaryReport': instance.getSMSSummaryReport,
    };

GetSMSSummaryReport _$GetSMSSummaryReportFromJson(Map<String, dynamic> json) =>
    GetSMSSummaryReport(
      id: json['id'] as int?,
      gpsDeviceId: json['gpsDeviceId'] as String?,
      serialNumber: json['serialNumber'] as String?,
      name: json['name'] as String?,
      number: json['number'] as String?,
      startDate: json['startDate'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$GetSMSSummaryReportToJson(
        GetSMSSummaryReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gpsDeviceId': instance.gpsDeviceId,
      'serialNumber': instance.serialNumber,
      'name': instance.name,
      'number': instance.number,
      'startDate': instance.startDate,
      'language': instance.language,
    };
