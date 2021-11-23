// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_serial_number_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerialNumberResults _$SerialNumberResultsFromJson(Map<String, dynamic> json) {
  return SerialNumberResults(
    result: json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
    status: json['status'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SerialNumberResultsToJson(
        SerialNumberResults instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    startsWith: json['startsWith'] as String,
    startRange: json['startRange'] as int,
    endRange: json['endRange'] as int,
    groupClusterId: json['groupClusterId'] as int,
    modelName: json['modelName'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'startsWith': instance.startsWith,
      'startRange': instance.startRange,
      'endRange': instance.endRange,
      'groupClusterId': instance.groupClusterId,
      'modelName': instance.modelName,
    };