// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      activeSubscription: (json['activeSubscription'] as num?)?.toDouble(),
      yetToBeActivated: (json['yetToBeActivated'] as num?)?.toDouble(),
      totalDevicesSupplied: (json['totalDevicesSupplied'] as num?)?.toDouble(),
      plantAssetCount: (json['plantAssetCount'] as num?)?.toDouble(),
      subscriptionEnded: (json['subscriptionEnded'] as num?)?.toDouble(),
      assetActivationByDay: (json['assetActivationByDay'] as num?)?.toDouble(),
      assetActivationByWeek:
          (json['assetActivationByWeek'] as num?)?.toDouble(),
      assetActivationByMonth:
          (json['assetActivationByMonth'] as num?)?.toDouble(),
      modelFleetList: (json['modelFleetList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ModelFleetList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'activeSubscription': instance.activeSubscription,
      'yetToBeActivated': instance.yetToBeActivated,
      'totalDevicesSupplied': instance.totalDevicesSupplied,
      'plantAssetCount': instance.plantAssetCount,
      'subscriptionEnded': instance.subscriptionEnded,
      'assetActivationByDay': instance.assetActivationByDay,
      'assetActivationByWeek': instance.assetActivationByWeek,
      'assetActivationByMonth': instance.assetActivationByMonth,
      'modelFleetList': instance.modelFleetList,
    };

ModelFleetList _$ModelFleetListFromJson(Map<String, dynamic> json) =>
    ModelFleetList(
      modelCount: (json['ModelCount'] as num?)?.toDouble(),
      modelName: json['ModelName'] as String?,
    );

Map<String, dynamic> _$ModelFleetListToJson(ModelFleetList instance) =>
    <String, dynamic>{
      'ModelCount': instance.modelCount,
      'ModelName': instance.modelName,
    };
