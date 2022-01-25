// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePayLoad _$FavoritePayLoadFromJson(Map<String, dynamic> json) =>
    FavoritePayLoad(
      groupUID: (json['groupUID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFavourite: json['isFavourite'] as bool?,
    );

Map<String, dynamic> _$FavoritePayLoadToJson(FavoritePayLoad instance) =>
    <String, dynamic>{
      'groupUID': instance.groupUID,
      'isFavourite': instance.isFavourite,
    };
