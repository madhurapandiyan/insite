// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetCreationResponse _$AssetCreationResponseFromJson(
        Map<String, dynamic> json) =>
    AssetCreationResponse(
      code: json['code'] as String?,
      status: json['status'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      assetModelByMachineSerialNumber:
          json['assetModelByMachineSerialNumber'] == null
              ? null
              : AssetModelByMachineSerialNumber.fromJson(
                  json['assetModelByMachineSerialNumber']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetCreationResponseToJson(
        AssetCreationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
      'assetModelByMachineSerialNumber':
          instance.assetModelByMachineSerialNumber,
    };

AssetModelByMachineSerialNumber _$AssetModelByMachineSerialNumberFromJson(
        Map<String, dynamic> json) =>
    AssetModelByMachineSerialNumber(
      endRange: json['endRange'] as int?,
      modelName: json['modelName'] as String?,
      groupClusterId: json['groupClusterId'] as int?,
      startRange: json['startRange'] as int?,
      startsWith: json['startsWith'] as String?,
    );

Map<String, dynamic> _$AssetModelByMachineSerialNumberToJson(
        AssetModelByMachineSerialNumber instance) =>
    <String, dynamic>{
      'endRange': instance.endRange,
      'modelName': instance.modelName,
      'groupClusterId': instance.groupClusterId,
      'startRange': instance.startRange,
      'startsWith': instance.startsWith,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      startsWith: json['startsWith'] as String?,
      startRange: json['startRange'] as int?,
      endRange: json['endRange'] as int?,
      groupClusterId: json['groupClusterId'] as int?,
      modelName: json['modelName'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'startsWith': instance.startsWith,
      'startRange': instance.startRange,
      'endRange': instance.endRange,
      'groupClusterId': instance.groupClusterId,
      'modelName': instance.modelName,
    };
