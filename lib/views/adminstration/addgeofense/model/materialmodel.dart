import 'package:json_annotation/json_annotation.dart';
part 'materialmodel.g.dart';
@JsonSerializable()
class Materialmodel {
  final List<Material> materials;
  Materialmodel({this.materials});

  factory Materialmodel.fromJson(Map<String, dynamic> json) =>
      _$MaterialmodelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialmodelToJson(this);
}
@JsonSerializable()
class Material {
  final String materialUid;
  final String name;
  final double density;
  Material({this.materialUid, this.name, this.density});
  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialToJson(this);
}
