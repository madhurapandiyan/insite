// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      self: json['self'] as String?,
      next: json['next'] as String?,
      href: json['href'] as String?,
      rel: json['rel'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
      'next': instance.next,
      'prev': instance.prev,
      'rel': instance.rel,
      'href': instance.href,
    };
