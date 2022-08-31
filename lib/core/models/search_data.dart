import 'package:json_annotation/json_annotation.dart';
part 'search_data.g.dart';

@JsonSerializable()
class TopMatch {
  final String? assetUid;
  final String? assetID;
  final String? serialNumber;

  TopMatch({this.assetID, this.assetUid, this.serialNumber});

  factory TopMatch.fromJson(Map<String, dynamic> json) =>
      _$TopMatchFromJson(json);

  Map<String, dynamic> toJson() => _$TopMatchToJson(this);
}

@JsonSerializable()
class SearchData {
  final int? totalCount;
  final List<TopMatch>? topMatches;

  SearchData({this.totalCount, this.topMatches});

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
