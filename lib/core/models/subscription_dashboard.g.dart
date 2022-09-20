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
              .map((e) => Result.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      plantDispatchSummary: json['plantDispatchSummary'] == null
          ? null
          : PlantDispatchSummary.fromJson(
              json['plantDispatchSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionDashboardResultToJson(
        SubscriptionDashboardResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'plantDispatchSummary': instance.plantDispatchSummary,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
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

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
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
    };
