// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_heirarchy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HierarchyAssets _$HierarchyAssetsFromJson(Map<String, dynamic> json) =>
    HierarchyAssets(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => Result.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      plantHierarchyDetails: json['plantHierarchyDetails'] == null
          ? null
          : PlantHierarchyDetails.fromJson(
              json['plantHierarchyDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HierarchyAssetsToJson(HierarchyAssets instance) =>
    <String, dynamic>{
      'result': instance.result,
      'plantHierarchyDetails': instance.plantHierarchyDetails,
    };

PlantHierarchyDetails _$PlantHierarchyDetailsFromJson(
        Map<String, dynamic> json) =>
    PlantHierarchyDetails(
      totalAssetCount: json['totalAssetCount'] as int?,
      totalCustomerCount: json['totalCustomerCount'] as int?,
      totalDealerCount: json['totalDealerCount'] as int?,
      totalPlantCount: json['totalPlantCount'] as int?,
    );

Map<String, dynamic> _$PlantHierarchyDetailsToJson(
        PlantHierarchyDetails instance) =>
    <String, dynamic>{
      'totalAssetCount': instance.totalAssetCount,
      'totalCustomerCount': instance.totalCustomerCount,
      'totalDealerCount': instance.totalDealerCount,
      'totalPlantCount': instance.totalPlantCount,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      customerCount: json['Customer_Count'] as int?,
      dealerCount: json['Dealer_Count'] as int?,
      plantCount: json['Plant_Count'] as int?,
      totalAssets: json['TotelAssets'] as int?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'Customer_Count': instance.customerCount,
      'Dealer_Count': instance.dealerCount,
      'Plant_Count': instance.plantCount,
      'TotelAssets': instance.totalAssets,
    };
