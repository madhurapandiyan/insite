// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopMatch _$TopMatchFromJson(Map<String, dynamic> json) {
  return TopMatch(
    assetID: json['assetID'] as String,
    assetUID: json['assetUID'] as String,
    serialNumber: json['serialNumber'] as String,
  );
}

Map<String, dynamic> _$TopMatchToJson(TopMatch instance) => <String, dynamic>{
      'assetUID': instance.assetUID,
      'assetID': instance.assetID,
      'serialNumber': instance.serialNumber,
    };

SearchData _$SearchDataFromJson(Map<String, dynamic> json) {
  return SearchData(
    totalCount: json['totalCount'] as int,
    topMatches: (json['topMatches'] as List)
        ?.map((e) =>
            e == null ? null : TopMatch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'topMatches': instance.topMatches,
    };
