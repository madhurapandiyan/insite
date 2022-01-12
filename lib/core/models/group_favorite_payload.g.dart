// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_favorite_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupFavoritePayLoad _$GroupFavoritePayLoadFromJson(
        Map<String, dynamic> json) =>
    GroupFavoritePayLoad(
      groupUID: (json['groupUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFavourite: json['isFavourite'] as bool?,
    );

Map<String, dynamic> _$GroupFavoritePayLoadToJson(
        GroupFavoritePayLoad instance) =>
    <String, dynamic>{
      'groupUID': instance.groupUID,
      'isFavourite': instance.isFavourite,
    };
