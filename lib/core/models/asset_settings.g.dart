// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageAssetConfiguration _$ManageAssetConfigurationFromJson(
        Map<String, dynamic> json) =>
    ManageAssetConfiguration(
      assetSettings: (json['assetSettings'] as List<dynamic>?)
          ?.map((e) => AssetSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageAssetConfigurationToJson(
        ManageAssetConfiguration instance) =>
    <String, dynamic>{
      'assetSettings': instance.assetSettings,
      'pageInfo': instance.pageInfo,
    };

AssetSetting _$AssetSettingFromJson(Map<String, dynamic> json) => AssetSetting(
      assetUid: json['assetUid'] as String?,
      assetId: json['assetId'],
      assetSerialNumber: json['assetSerialNumber'] as String?,
      assetModel: json['assetModel'] as String?,
      assetMakeCode: json['assetMakeCode'] as String?,
      assetIconKey: json['assetIconKey'],
      deviceSerialNumber: json['deviceSerialNumber'] as String?,
      devicetype: json['devicetype'] as String?,
      targetStatus: json['targetStatus'] as bool?,
      hoursMeter: (json['hoursMeter'] as num?)?.toDouble(),
      movingOrStoppedThreshold:
          (json['movingOrStoppedThreshold'] as num?)?.toDouble(),
      movingThresholdsDuration: json['movingThresholdsDuration'] as int?,
      movingThresholdsRadius:
          (json['movingThresholdsRadius'] as num?)?.toDouble(),
      odometer: (json['odometer'] as num?)?.toDouble(),
      workDefinition: json['workDefinition'] as int?,
      configuredSwitches: json['configuredSwitches'] as int?,
      totalSwitches: json['totalSwitches'] as int?,
    );

Map<String, dynamic> _$AssetSettingToJson(AssetSetting instance) =>
    <String, dynamic>{
      'assetUid': instance.assetUid,
      'assetId': instance.assetId,
      'assetSerialNumber': instance.assetSerialNumber,
      'assetModel': instance.assetModel,
      'assetMakeCode': instance.assetMakeCode,
      'assetIconKey': instance.assetIconKey,
      'deviceSerialNumber': instance.deviceSerialNumber,
      'devicetype': instance.devicetype,
      'targetStatus': instance.targetStatus,
      'hoursMeter': instance.hoursMeter,
      'movingOrStoppedThreshold': instance.movingOrStoppedThreshold,
      'movingThresholdsDuration': instance.movingThresholdsDuration,
      'movingThresholdsRadius': instance.movingThresholdsRadius,
      'odometer': instance.odometer,
      'workDefinition': instance.workDefinition,
      'configuredSwitches': instance.configuredSwitches,
      'totalSwitches': instance.totalSwitches,
    };

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      totalRecords: json['totalRecords'] as int?,
      totalPages: json['totalPages'] as int?,
      currentPageNumber: json['currentPageNumber'] as int?,
      currentPageSize: json['currentPageSize'] as int?,
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'totalRecords': instance.totalRecords,
      'totalPages': instance.totalPages,
      'currentPageNumber': instance.currentPageNumber,
      'currentPageSize': instance.currentPageSize,
    };
