// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_dashboard_fault_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDashboardFaultData _$AssetDashboardFaultDataFromJson(
        Map<String, dynamic> json) =>
    AssetDashboardFaultData(
      summaryData: (json['summaryData'] as List<dynamic>?)
          ?.map((e) => FaultSummaryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetDashboardFaultDataToJson(
        AssetDashboardFaultData instance) =>
    <String, dynamic>{
      'summaryData': instance.summaryData,
    };

FaultSummaryData _$FaultSummaryDataFromJson(Map<String, dynamic> json) =>
    FaultSummaryData(
      countData: (json['countData'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaultSummaryDataToJson(FaultSummaryData instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };
