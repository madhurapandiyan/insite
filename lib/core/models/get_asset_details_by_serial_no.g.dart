// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_asset_details_by_serial_no.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDetailsBySerialNo _$AssetDetailsBySerialNoFromJson(
        Map<String, dynamic> json) =>
    AssetDetailsBySerialNo(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ResultsValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetDetailsBySerialNoToJson(
        AssetDetailsBySerialNo instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

ResultsValues _$ResultsValuesFromJson(Map<String, dynamic> json) =>
    ResultsValues(
      model: json['Model'] as String?,
      deviceId: json['GPSDeviceID'] as String?,
    );

Map<String, dynamic> _$ResultsValuesToJson(ResultsValues instance) =>
    <String, dynamic>{
      'Model': instance.model,
      'GPSDeviceID': instance.deviceId,
    };
