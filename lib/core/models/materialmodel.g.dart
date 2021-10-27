// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materialmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Materialmodel _$MaterialmodelFromJson(Map<String, dynamic> json) {
  return Materialmodel(
    materials: (json['materials'] as List)
        ?.map((e) =>
            e == null ? null : Material.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MaterialmodelToJson(Materialmodel instance) =>
    <String, dynamic>{
      'materials': instance.materials,
    };

Material _$MaterialFromJson(Map<String, dynamic> json) {
  return Material(
    materialUid: json['materialUid'] as String,
    name: json['name'] as String,
    density: json['density'] as String,
  );
}

Map<String, dynamic> _$MaterialToJson(Material instance) => <String, dynamic>{
      'materialUid': instance.materialUid,
      'name': instance.name,
      'density': instance.density,
    };
