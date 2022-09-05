import 'package:json_annotation/json_annotation.dart';
part 'industry_list_data.g.dart';

@JsonSerializable()
class IndustryListData{
  final List<PrimarySecondaryIndustry>? primarySecondaryIndustries;
  IndustryListData({this.primarySecondaryIndustries});
  factory IndustryListData.fromJson(Map<String, dynamic> json) =>
      _$IndustryListDataFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryListDataToJson(this);

}

@JsonSerializable()
class PrimarySecondaryIndustry {
final String ? primaryIndustry;
final String ? secondaryIndustries;

PrimarySecondaryIndustry({this.primaryIndustry,this.secondaryIndustries});
factory PrimarySecondaryIndustry.fromJson(Map<String, dynamic> json) =>
      _$PrimarySecondaryIndustryFromJson(json);

  Map<String, dynamic> toJson() => _$PrimarySecondaryIndustryToJson(this);

}