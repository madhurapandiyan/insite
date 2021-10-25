// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    result: (json['result'] as List)?.map((e) => e as List)?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'result': instance.result,
    };
