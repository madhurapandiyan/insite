// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_dashboard_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceDashboardCount _$MaintenanceDashboardCountFromJson(
        Map<String, dynamic> json) =>
    MaintenanceDashboardCount(
      maintenanceDashboard: json['maintenanceDashboard'] == null
          ? null
          : MaintenanceDashboard.fromJson(
              json['maintenanceDashboard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaintenanceDashboardCountToJson(
        MaintenanceDashboardCount instance) =>
    <String, dynamic>{
      'maintenanceDashboard': instance.maintenanceDashboard,
    };

MaintenanceDashboard _$MaintenanceDashboardFromJson(
        Map<String, dynamic> json) =>
    MaintenanceDashboard(
      dashboardData: (json['dashboardData'] as List<dynamic>?)
          ?.map((e) => DashboardData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MaintenanceDashboardToJson(
        MaintenanceDashboard instance) =>
    <String, dynamic>{
      'status': instance.status,
      'dashboardData': instance.dashboardData,
    };

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      alias: json['alias'] as String?,
      count: json['count'] as int?,
      displayName: json['displayName'] as String?,
      subCount: (json['subCount'] as List<dynamic>?)
          ?.map((e) => DashboardData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'count': instance.count,
      'alias': instance.alias,
      'subCount': instance.subCount,
    };
