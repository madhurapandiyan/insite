// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_reportSummary_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsReportSummaryModel _$SmsReportSummaryModelFromJson(
        Map<String, dynamic> json) =>
    SmsReportSummaryModel(
      code: json['code'] as String?,
      status: json['status'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map(
                  (e) => ReportSummaryModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      getSMSSummaryReport: json['getSMSSummaryReport'] == null
          ? null
          : GetSMSSummaryReport.fromJson(
              json['getSMSSummaryReport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SmsReportSummaryModelToJson(
        SmsReportSummaryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'getSMSSummaryReport': instance.getSMSSummaryReport,
      'result': instance.result,
    };

ReportSummaryModel _$ReportSummaryModelFromJson(Map<String, dynamic> json) =>
    ReportSummaryModel(
      count: json['count'] as int?,
      id: json['ID'] as int?,
      gpsDeviceId: json['GPSDeviceID'] as String?,
      serialNumber: json['SerialNumber'] as String?,
      name: json['Name'] as String?,
      number: json['Number'] as String?,
      startDate: json['StartDate'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      language: json['Language'] as String?,
    );

Map<String, dynamic> _$ReportSummaryModelToJson(ReportSummaryModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'ID': instance.id,
      'GPSDeviceID': instance.gpsDeviceId,
      'SerialNumber': instance.serialNumber,
      'Name': instance.name,
      'Number': instance.number,
      'StartDate': instance.startDate,
      'Language': instance.language,
      'isSelected': instance.isSelected,
    };

GetSMSSummaryReport _$GetSMSSummaryReportFromJson(Map<String, dynamic> json) =>
    GetSMSSummaryReport(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as String?,
    );

Map<String, dynamic> _$GetSMSSummaryReportToJson(
        GetSMSSummaryReport instance) =>
    <String, dynamic>{
      'count': instance.count,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as int?,
      gpsDeviceId: json['gpsDeviceId'] as String?,
      serialNumber: json['serialNumber'] as String?,
      name: json['name'] as String?,
      number: json['number'] as String?,
      startDate: json['startDate'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'gpsDeviceId': instance.gpsDeviceId,
      'serialNumber': instance.serialNumber,
      'name': instance.name,
      'number': instance.number,
      'startDate': instance.startDate,
      'language': instance.language,
    };
