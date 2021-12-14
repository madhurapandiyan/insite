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
    );

Map<String, dynamic> _$HierarchyAssetsToJson(HierarchyAssets instance) =>
    <String, dynamic>{
      'result': instance.result,
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
