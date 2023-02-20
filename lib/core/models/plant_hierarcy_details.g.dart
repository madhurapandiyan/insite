// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_hierarcy_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantHierarchyDetails _$PlantHierarchyDetailsFromJson(
        Map<String, dynamic> json) =>
    PlantHierarchyDetails(
      assetOrHierarchyByTypeAndIdDetail:
          (json['assetOrHierarchyByTypeAndId'] as List<dynamic>?)
              ?.map((e) => AssetOrHierarchyByTypeAndIdDetail.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PlantHierarchyDetailsToJson(
        PlantHierarchyDetails instance) =>
    <String, dynamic>{
      'assetOrHierarchyByTypeAndId': instance.assetOrHierarchyByTypeAndIdDetail,
    };

AssetOrHierarchyByTypeAndIdDetail _$AssetOrHierarchyByTypeAndIdDetailFromJson(
        Map<String, dynamic> json) =>
    AssetOrHierarchyByTypeAndIdDetail(
      name: json['name'] as String?,
      gpsDeviceId: json['gpsDeviceID'] as String?,
      vin: json['vin'] as String?,
      model: json['model'] as String?,
      productFamily: json['productFamily'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
      subscriptionEndDate: json['subscriptionEndDate'] as String?,
      actualStartDate: json['actualStartDate'] as String?,
      typename: json['typename'] as String?,
    );

Map<String, dynamic> _$AssetOrHierarchyByTypeAndIdDetailToJson(
        AssetOrHierarchyByTypeAndIdDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gpsDeviceID': instance.gpsDeviceId,
      'vin': instance.vin,
      'model': instance.model,
      'productFamily': instance.productFamily,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'subscriptionEndDate': instance.subscriptionEndDate,
      'actualStartDate': instance.actualStartDate,
      'typename': instance.typename,
    };
