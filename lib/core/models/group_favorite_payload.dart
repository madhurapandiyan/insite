import 'package:json_annotation/json_annotation.dart';
part 'group_favorite_payload.g.dart';

@JsonSerializable()
class GroupFavoritePayLoad {
  List<String>? groupUID;
  bool? isFavourite;

  GroupFavoritePayLoad({this.groupUID, this.isFavourite});

  factory GroupFavoritePayLoad.fromJson(Map<String, dynamic> json) =>
      _$GroupFavoritePayLoadFromJson(json);
  Map<String, dynamic> toJson() => _$GroupFavoritePayLoadToJson(this);
}
