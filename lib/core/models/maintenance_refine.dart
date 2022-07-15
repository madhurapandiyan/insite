import 'package:json_annotation/json_annotation.dart';
part 'maintenance_refine.g.dart';

@JsonSerializable()
class MaintenanceRefineData {
  final MaintenanceRefine? maintenanceRefine;
  MaintenanceRefineData({this.maintenanceRefine});

  factory MaintenanceRefineData.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRefineDataFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceRefineDataToJson(this);
}

@JsonSerializable()
class MaintenanceRefine {
  final List<MaintenanceRefineList>? maintenanceRefine;
  MaintenanceRefine({this.maintenanceRefine});

  factory MaintenanceRefine.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRefineFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceRefineToJson(this);
}

@JsonSerializable()
class MaintenanceRefineList {
  final String? typeName;
  final String? typeAlias;
  final List<TypeValues>? typeValues;
  MaintenanceRefineList({this.typeAlias, this.typeName, this.typeValues});

  factory MaintenanceRefineList.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRefineListFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceRefineListToJson(this);
}

@JsonSerializable()
class TypeValues {
  final String? name;
  final int? count;
  final String? alias;
  TypeValues({this.alias, this.count, this.name});

  factory TypeValues.fromJson(Map<String, dynamic> json) =>
      _$TypeValuesFromJson(json);

  Map<String, dynamic> toJson() => _$TypeValuesToJson(this);
}
