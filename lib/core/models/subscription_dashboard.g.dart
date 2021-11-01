// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDashboardResult _$SubscriptionDashboardResultFromJson(
    Map<String, dynamic> json) {
  return SubscriptionDashboardResult(
    result: (json['result'] as List)
        ?.map((e) => (e as List)
            ?.map((e) =>
                e == null ? null : Result.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$SubscriptionDashboardResultToJson(
        SubscriptionDashboardResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    activeList: (json['activelist'] as num)?.toDouble(),
    inActiveList: (json['inActiveList'] as num)?.toDouble(),
    modelCount: (json['ModelCount'] as num)?.toDouble(),
    modelName: json['ModelName'] as String,
    totalDevice: (json['totalDevice'] as num)?.toDouble(),
    plantAssetCount: (json['PlantAssetCount'] as num)?.toDouble(),
    subscriptionAndAsset: (json['subscriptionEndAsset'] as num)?.toDouble(),
    dayCount: (json['day_count'] as num)?.toDouble(),
    weekCount: (json['week_count'] as num)?.toDouble(),
    monthCount: (json['month_count'] as num)?.toDouble(),
    subscriptionEndingAsset:
        (json['subscriptionEndingAsset_Month'] as num)?.toDouble(),
  );
}

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
