// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_report_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReportPayLoad _$AddReportPayLoadFromJson(Map<String, dynamic> json) =>
    AddReportPayLoad(
      assetFilterCategoryID: json['assetFilterCategoryID'] as int?,
      reportCategoryID: json['reportCategoryID'] as int?,
      reportFormat: json['reportFormat'] as int?,
      reportPeriod: json['reportPeriod'] as int?,
      reportTitle: json['reportTitle'] as String?,
      reportScheduledDate: json['reportScheduledDate'] as String?,
      reportStartDate: json['reportStartDate'] as String?,
      reportEndDate: json['reportEndDate'] as String?,
      emailSubject: json['emailSubject'] as String?,
      emailRecipients: (json['emailRecipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      svcMethod: json['svcMethod'] as String?,
      allAssets: json['allAssets'] as bool?,
      queryUrl: json['queryUrl'] as String?,
      emailContent: json['emailContent'] as String?,
      reportType: json['reportType'] as String?,
      reportColumns: (json['reportColumns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      Latitude: json['Latitude'] as String?,
      Longitude: json['Longitude'] as String?,
      assetFilterUIDs: (json['assetFilterUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      assetIDContains: json['assetIDContains'] as String?,
      assetstatus: json['assetstatus'] as String?,
      fuelLevelPercentLT: json['fuelLevelPercentLT'] as String?,
      idleEfficiencyGT: json['idleEfficiencyGT'] as String?,
      idleEfficiencyLTE: json['idleEfficiencyLTE'] as String?,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      productfamily: json['productfamily'] as String?,
      radiuskm: json['radiuskm'] as String?,
      snContains: json['snContains'] as String?,
      svcbody:
          (json['svcbody'] as List<dynamic>?)?.map((e) => e as String).toList(),
      svcbodyJson: json['svcbodyJson'] == null
          ? null
          : SvcbodyResponse.fromJson(
              json['svcbodyJson'] as Map<String, dynamic>),
      reportUid: json['reportUid'] as String?,
    );

Map<String, dynamic> _$AddReportPayLoadToJson(AddReportPayLoad instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('assetFilterCategoryID', instance.assetFilterCategoryID);
  writeNotNull('reportCategoryID', instance.reportCategoryID);
  writeNotNull('reportFormat', instance.reportFormat);
  writeNotNull('reportPeriod', instance.reportPeriod);
  writeNotNull('reportTitle', instance.reportTitle);
  writeNotNull('reportScheduledDate', instance.reportScheduledDate);
  writeNotNull('reportStartDate', instance.reportStartDate);
  writeNotNull('reportEndDate', instance.reportEndDate);
  writeNotNull('emailSubject', instance.emailSubject);
  writeNotNull('emailRecipients', instance.emailRecipients);
  writeNotNull('svcMethod', instance.svcMethod);
  writeNotNull('allAssets', instance.allAssets);
  writeNotNull('emailContent', instance.emailContent);
  writeNotNull('queryUrl', instance.queryUrl);
  writeNotNull('reportType', instance.reportType);
  writeNotNull('reportColumns', instance.reportColumns);
  writeNotNull('svcbody', instance.svcbody);
  writeNotNull('assetFilterUIDs', instance.assetFilterUIDs);
  writeNotNull('productfamily', instance.productfamily);
  writeNotNull('model', instance.model);
  writeNotNull('assetstatus', instance.assetstatus);
  writeNotNull('fuelLevelPercentLT', instance.fuelLevelPercentLT);
  writeNotNull('idleEfficiencyGT', instance.idleEfficiencyGT);
  writeNotNull('idleEfficiencyLTE', instance.idleEfficiencyLTE);
  writeNotNull('assetIDContains', instance.assetIDContains);
  writeNotNull('snContains', instance.snContains);
  writeNotNull('Latitude', instance.Latitude);
  writeNotNull('Longitude', instance.Longitude);
  writeNotNull('radiuskm', instance.radiuskm);
  writeNotNull('manufacturer', instance.manufacturer);
  writeNotNull('svcbodyJson', instance.svcbodyJson);
  writeNotNull('reportUid', instance.reportUid);
  return val;
}

SvcbodyResponse _$SvcbodyResponseFromJson(Map<String, dynamic> json) =>
    SvcbodyResponse(
      assetuids: (json['assetuids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      colFilters: (json['colFilters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SvcbodyResponseToJson(SvcbodyResponse instance) =>
    <String, dynamic>{
      'assetuids': instance.assetuids,
      'colFilters': instance.colFilters,
    };
