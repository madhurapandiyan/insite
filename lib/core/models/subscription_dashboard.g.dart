// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDashboardResult _$SubscriptionDashboardResultFromJson(
        Map<String, dynamic> json) =>
    SubscriptionDashboardResult(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map(
                  (e) => ResultSubscription.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      frameSubscription: json['frameSubscription'] == null
          ? null
          : FrameSubscription.fromJson(
              json['frameSubscription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionDashboardResultToJson(
        SubscriptionDashboardResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'frameSubscription': instance.frameSubscription,
    };

ResultSubscription _$ResultSubscriptionFromJson(Map<String, dynamic> json) =>
    ResultSubscription(
      activeList: (json['activelist'] as num?)?.toDouble(),
      inActiveList: (json['inActiveList'] as num?)?.toDouble(),
      modelCount: (json['ModelCount'] as num?)?.toDouble(),
      modelName: json['ModelName'] as String?,
      totalDevice: (json['totalDevice'] as num?)?.toDouble(),
      plantAssetCount: (json['PlantAssetCount'] as num?)?.toDouble(),
      subscriptionAndAsset: (json['subscriptionEndAsset'] as num?)?.toDouble(),
      dayCount: (json['day_count'] as num?)?.toDouble(),
      weekCount: (json['week_count'] as num?)?.toDouble(),
      monthCount: (json['month_count'] as num?)?.toDouble(),
      subscriptionEndingAsset:
          (json['subscriptionEndingAsset_Month'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ResultSubscriptionToJson(ResultSubscription instance) =>
    <String, dynamic>{
      'activelist': instance.activeList,
      'inActiveList': instance.inActiveList,
      'ModelCount': instance.modelCount,
      'ModelName': instance.modelName,
      'totalDevice': instance.totalDevice,
      'PlantAssetCount': instance.plantAssetCount,
      'subscriptionEndAsset': instance.subscriptionAndAsset,
      'day_count': instance.dayCount,
      'week_count': instance.weekCount,
      'month_count': instance.monthCount,
      'subscriptionEndingAsset_Month': instance.subscriptionEndingAsset,
    };

FrameSubscription _$FrameSubscriptionFromJson(Map<String, dynamic> json) =>
    FrameSubscription(
      plantDispatchSummary: json['plantDispatchSummary'] == null
          ? null
          : PlantDispatchSummary.fromJson(
              json['plantDispatchSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FrameSubscriptionToJson(FrameSubscription instance) =>
    <String, dynamic>{
      'plantDispatchSummary': instance.plantDispatchSummary,
    };

PlantDispatchSummary _$PlantDispatchSummaryFromJson(
        Map<String, dynamic> json) =>
    PlantDispatchSummary(
      activeSubscription: json['activeSubscription'] as int?,
      yetToBeActivated: json['yetToBeActivated'] as int?,
      subscriptionEnded: json['subscriptionEnded'] as int?,
      assetActivationByDay: json['assetActivationByDay'],
      assetActivationByWeek: json['assetActivationByWeek'] as int?,
      assetActivationByMonth: json['assetActivationByMonth'] as int?,
      totalDevicesSupplied: json['totalDevicesSupplied'] as int?,
      modelFleetList: (json['modelFleetList'] as List<dynamic>?)
          ?.map((e) => ModelFleetList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlantDispatchSummaryToJson(
        PlantDispatchSummary instance) =>
    <String, dynamic>{
      'activeSubscription': instance.activeSubscription,
      'yetToBeActivated': instance.yetToBeActivated,
      'subscriptionEnded': instance.subscriptionEnded,
      'assetActivationByDay': instance.assetActivationByDay,
      'assetActivationByWeek': instance.assetActivationByWeek,
      'assetActivationByMonth': instance.assetActivationByMonth,
      'totalDevicesSupplied': instance.totalDevicesSupplied,
      'modelFleetList': instance.modelFleetList,
    };

ModelFleetList _$ModelFleetListFromJson(Map<String, dynamic> json) =>
    ModelFleetList(
      modelCount: json['ModelCount'] as int?,
      modelName: json['ModelName'] as String?,
      typename: json['__typename'] as String?,
    );

Map<String, dynamic> _$ModelFleetListToJson(ModelFleetList instance) =>
    <String, dynamic>{
      'ModelCount': instance.modelCount,
      'ModelName': instance.modelName,
      '__typename': instance.typename,
    };
