// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

<<<<<<< HEAD
DashboardResult _$DashboardResultFromJson(Map<String, dynamic> json) {
  return DashboardResult(
    resultData: (json['resultData'] as List)
        ?.map((e) =>
            e == null ? null : ResultData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DashboardResultToJson(DashboardResult instance) =>
    <String, dynamic>{
      'resultData': instance.resultData?.map((e) => e?.toJson())?.toList(),
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    activeList: json['activelist'] as int,
    inActiveList: json['inActiveList'] as int,
    modelCount: json['ModelCount'] as int,
    modelName: json['ModelName'] as String,
    totalDevice: json['totalDevice'] as int,
    plantAssetCount: json['PlantAssetCount'] as int,
    subscriptionAndAsset: json['subscriptionEndAsset'] as int,
    dayCount: json['day_count'] as int,
    weekCount: json['week_count'] as int,
    monthCount: json['month_count'] as int,
    subscriptionEndingAsset: json['subscriptionEndingAsset_Month'] as int,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
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
=======
Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    result: (json['result'] as List)?.map((e) => e as List)?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'result': instance.result,
>>>>>>> f0ebaa9e7731ed5688bbda93b2a081d7cc3076da
    };
