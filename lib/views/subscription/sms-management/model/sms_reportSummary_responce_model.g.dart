// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_reportSummary_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsReportSummaryModel _$SmsReportSummaryModelFromJson(
    Map<String, dynamic> json) {
  return SmsReportSummaryModel(
    code: json['code'] as String,
    status: json['status'] as String,
    result: (json['result'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : ReportSummaryModel.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$SmsReportSummaryModelToJson(
        SmsReportSummaryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

ReportSummaryModel _$ReportSummaryModelFromJson(Map<String, dynamic> json) {
  return ReportSummaryModel(
    count: json['count'] as int,
    ID: json['ID'] as int,
    GPSDeviceID: json['GPSDeviceID'] as String,
    SerialNumber: json['SerialNumber'] as String,
    Name: json['Name'] as String,
    Number: json['Number'] as String,
    StartDate: json['StartDate'] as String,
    isSelected: json['isSelected'] as bool,
    Language: json['Language'] as String,
  );
}

Map<String, dynamic> _$ReportSummaryModelToJson(ReportSummaryModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'ID': instance.ID,
      'GPSDeviceID': instance.GPSDeviceID,
      'SerialNumber': instance.SerialNumber,
      'Name': instance.Name,
      'Number': instance.Number,
      'StartDate': instance.StartDate,
      'Language': instance.Language,
      'isSelected': instance.isSelected,
    };
