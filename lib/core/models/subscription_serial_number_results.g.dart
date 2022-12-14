// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_serial_number_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerialNumberResults _$SerialNumberResultsFromJson(Map<String, dynamic> json) =>
    SerialNumberResults(
      result: json['result'] == null
          ? null
          : ModelResult.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
      message: json['message'] as String?,
      assetModelByMachineSerialNumber:
          json['assetModelByMachineSerialNumber'] == null
              ? null
              : AssetModelByMachineSerialNumber.fromJson(
                  json['assetModelByMachineSerialNumber']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$SerialNumberResultsToJson(
        SerialNumberResults instance) =>
    <String, dynamic>{
      'assetModelByMachineSerialNumber':
          instance.assetModelByMachineSerialNumber,
      'result': instance.result,
      'status': instance.status,
      'message': instance.message,
    };

ModelResult _$ModelResultFromJson(Map<String, dynamic> json) => ModelResult(
      startsWith: json['startsWith'] as String?,
      startRange: json['startRange'] as int?,
      endRange: json['endRange'] as int?,
      groupClusterId: json['groupClusterId'] as int?,
      modelName: json['modelName'] as String?,
    );

Map<String, dynamic> _$ModelResultToJson(ModelResult instance) =>
    <String, dynamic>{
      'startsWith': instance.startsWith,
      'startRange': instance.startRange,
      'endRange': instance.endRange,
      'groupClusterId': instance.groupClusterId,
      'modelName': instance.modelName,
    };

AssetModelByMachineSerialNumber _$AssetModelByMachineSerialNumberFromJson(
        Map<String, dynamic> json) =>
    AssetModelByMachineSerialNumber(
      startsWith: json['startsWith'] as String?,
      startRange: json['startRange'] as int?,
      endRange: json['endRange'] as int?,
      groupClusterId: json['groupClusterId'] as int?,
      modelName: json['modelName'] as String?,
    );

Map<String, dynamic> _$AssetModelByMachineSerialNumberToJson(
        AssetModelByMachineSerialNumber instance) =>
    <String, dynamic>{
      'startsWith': instance.startsWith,
      'startRange': instance.startRange,
      'endRange': instance.endRange,
      'groupClusterId': instance.groupClusterId,
      'modelName': instance.modelName,
    };
