// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_group_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetGroupSummaryResponse _$AssetGroupSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    AssetGroupSummaryResponse(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      assetDetailsRecords: (json['assetDetailsRecords'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetGroupSummaryResponseToJson(
        AssetGroupSummaryResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'links': instance.links,
      'assetDetailsRecords': instance.assetDetailsRecords,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      assetIdentifier: json['assetIdentifier'] as String?,
      assetSerialNumber: json['assetSerialNumber'] as String?,
      makeCode: json['makeCode'] as String?,
      model: json['model'] as String?,
      assetIcon: json['assetIcon'] as int?,
      assetId: json['assetId'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'assetIdentifier': instance.assetIdentifier,
      'assetSerialNumber': instance.assetSerialNumber,
      'makeCode': instance.makeCode,
      'model': instance.model,
      'assetIcon': instance.assetIcon,
      'assetId': instance.assetId,
    };
