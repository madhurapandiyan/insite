// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_asset_fault_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleAssetFaultResponse _$SingleAssetFaultResponseFromJson(
    Map<String, dynamic> json) {
  return SingleAssetFaultResponse(
    summaryData: (json['summaryData'] as List)
        ?.map((e) =>
            e == null ? null : SummaryData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleAssetFaultResponseToJson(
        SingleAssetFaultResponse instance) =>
    <String, dynamic>{
      'summaryData': instance.summaryData,
    };

SummaryData _$SummaryDataFromJson(Map<String, dynamic> json) {
  return SummaryData(
    countData: (json['countData'] as List)
        ?.map((e) =>
            e == null ? null : CountData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SummaryDataToJson(SummaryData instance) =>
    <String, dynamic>{
      'countData': instance.countData,
    };

CountData _$CountDataFromJson(Map<String, dynamic> json) {
  return CountData(
    countOf: json['countOf'] as String,
    assetCount: json['assetCount'] as int,
    faultCount: json['faultCount'] as int,
  );
}

Map<String, dynamic> _$CountDataToJson(CountData instance) => <String, dynamic>{
      'countOf': instance.countOf,
      'assetCount': instance.assetCount,
      'faultCount': instance.faultCount,
    };
