// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaultSummaryResponse _$FaultSummaryResponseFromJson(Map<String, dynamic> json) {
  return FaultSummaryResponse(
    faults: (json['faults'] as List)
        ?.map(
            (e) => e == null ? null : Fault.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pageLinks: (json['pageLinks'] as List)
        ?.map(
            (e) => e == null ? null : Links.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    limit: json['limit'] as int,
    page: json['page'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$FaultSummaryResponseToJson(
        FaultSummaryResponse instance) =>
    <String, dynamic>{
      'pageLinks': instance.pageLinks,
      'faults': instance.faults,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
    };

Fault _$FaultFromJson(Map<String, dynamic> json) {
  return Fault(
    asset: json['asset'] == null
        ? null
        : FaultAsset.fromJson(json['asset'] as Map<String, dynamic>),
    basic: json['basic'] == null
        ? null
        : FaultBasic.fromJson(json['basic'] as Map<String, dynamic>),
    details: json['details'] == null
        ? null
        : FaultDetails.fromJson(json['details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
      'asset': instance.asset,
      'basic': instance.basic,
      'details': instance.details,
    };

FaultAsset _$FaultAssetFromJson(Map<String, dynamic> json) {
  return FaultAsset(
    limit: json['limit'] as int,
    total: json['total'] as int,
    uid: json['uid'] as String,
    basic: json['basic'],
    details: json['details'],
  );
}

Map<String, dynamic> _$FaultAssetToJson(FaultAsset instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'total': instance.total,
      'uid': instance.uid,
      'basic': instance.basic,
      'details': instance.details,
    };

FaultBasic _$FaultBasicFromJson(Map<String, dynamic> json) {
  return FaultBasic(
    limit: json['limit'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$FaultBasicToJson(FaultBasic instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'total': instance.total,
    };

FaultDetails _$FaultDetailsFromJson(Map<String, dynamic> json) {
  return FaultDetails(
    limit: json['limit'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$FaultDetailsToJson(FaultDetails instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'total': instance.total,
    };

AssetFaultSummaryResponse _$AssetFaultSummaryResponseFromJson(
    Map<String, dynamic> json) {
  return AssetFaultSummaryResponse(
    faults: (json['faults'] as List)
        ?.map(
            (e) => e == null ? null : Fault.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pageLinks: (json['pageLinks'] as List)
        ?.map(
            (e) => e == null ? null : Links.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    limit: json['limit'] as int,
    page: json['page'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$AssetFaultSummaryResponseToJson(
        AssetFaultSummaryResponse instance) =>
    <String, dynamic>{
      'pageLinks': instance.pageLinks,
      'faults': instance.faults,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
    };
