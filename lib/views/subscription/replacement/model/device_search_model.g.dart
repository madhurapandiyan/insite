// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceSearchModel _$DeviceSearchModelFromJson(Map<String, dynamic> json) =>
    DeviceSearchModel(
      code: json['code'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map(
                  (e) => DeviceContainsList.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DeviceSearchModelToJson(DeviceSearchModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

DeviceContainsList _$DeviceContainsListFromJson(Map<String, dynamic> json) =>
    DeviceContainsList(
      count: json['count'] as int?,
      containsList: json['containsList'] as String?,
    );

Map<String, dynamic> _$DeviceContainsListToJson(DeviceContainsList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'containsList': instance.containsList,
    };
