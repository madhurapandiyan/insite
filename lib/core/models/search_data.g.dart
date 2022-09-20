// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopMatch _$TopMatchFromJson(Map<String, dynamic> json) => TopMatch(
      assetID: json['assetID'] as String?,
      assetUid: json['assetUid'] as String?,
      serialNumber: json['serialNumber'] as String?,
    );

Map<String, dynamic> _$TopMatchToJson(TopMatch instance) => <String, dynamic>{
      'assetUid': instance.assetUid,
      'assetID': instance.assetID,
      'serialNumber': instance.serialNumber,
    };

SearchData _$SearchDataFromJson(Map<String, dynamic> json) => SearchData(
      totalCount: json['totalCount'] as int?,
      topMatches: (json['topMatches'] as List<dynamic>?)
          ?.map((e) => TopMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'topMatches': instance.topMatches,
    };
