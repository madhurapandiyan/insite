// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateResponse _$TemplateResponseFromJson(Map<String, dynamic> json) =>
    TemplateResponse(
      reports: (json['reports'] as List<dynamic>?)
          ?.map((e) => Reports.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateResponseToJson(TemplateResponse instance) =>
    <String, dynamic>{
      'reports': instance.reports,
    };

Reports _$ReportsFromJson(Map<String, dynamic> json) => Reports(
      reportTypeId: json['reportTypeId'] as String?,
      reportName: json['reportName'] as String?,
      reportTypeName: json['reportTypeName'] as String?,
      filterOptions: json['filterOptions'] as String?,
      sourceApplicationID: json['sourceApplicationID'] as String?,
      sourceAppName: json['sourceAppName'] as String?,
      reportSourcePageName: json['reportSourcePageName'] as String?,
      birstReportInd: json['birstReportInd'] as int?,
      assetParameter: json['assetParameter'] as String?,
      defaultColumn: json['defaultColumn'] as String?,
      dateRange: json['dateRange'] as String?,
    );

Map<String, dynamic> _$ReportsToJson(Reports instance) => <String, dynamic>{
      'reportTypeId': instance.reportTypeId,
      'reportName': instance.reportName,
      'reportTypeName': instance.reportTypeName,
      'filterOptions': instance.filterOptions,
      'sourceApplicationID': instance.sourceApplicationID,
      'sourceAppName': instance.sourceAppName,
      'reportSourcePageName': instance.reportSourcePageName,
      'birstReportInd': instance.birstReportInd,
      'assetParameter': instance.assetParameter,
      'defaultColumn': instance.defaultColumn,
      'dateRange': instance.dateRange,
    };
