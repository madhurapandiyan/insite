// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndustryListData _$IndustryListDataFromJson(Map<String, dynamic> json) =>
    IndustryListData(
      primarySecondaryIndustries:
          (json['primarySecondaryIndustries'] as List<dynamic>?)
              ?.map((e) =>
                  PrimarySecondaryIndustry.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$IndustryListDataToJson(IndustryListData instance) =>
    <String, dynamic>{
      'primarySecondaryIndustries': instance.primarySecondaryIndustries,
    };

PrimarySecondaryIndustry _$PrimarySecondaryIndustryFromJson(
        Map<String, dynamic> json) =>
    PrimarySecondaryIndustry(
      primaryIndustry: json['primaryIndustry'] as String?,
      secondaryIndustries: json['secondaryIndustries'] as String?,
    );

Map<String, dynamic> _$PrimarySecondaryIndustryToJson(
        PrimarySecondaryIndustry instance) =>
    <String, dynamic>{
      'primaryIndustry': instance.primaryIndustry,
      'secondaryIndustries': instance.secondaryIndustries,
    };
