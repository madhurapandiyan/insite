import 'package:json_annotation/json_annotation.dart';
part 'favorite_payload.g.dart';

@JsonSerializable()
class FavoritePayLoad {
  List<String>? groupUID;
  bool? isFavourite;

  FavoritePayLoad({this.groupUID, this.isFavourite});

  factory FavoritePayLoad.fromJson(Map<String, dynamic> json) =>
      _$FavoritePayLoadFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritePayLoadToJson(this);
}
