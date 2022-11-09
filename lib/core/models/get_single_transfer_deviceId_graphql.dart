import 'package:json_annotation/json_annotation.dart';
part 'get_single_transfer_deviceId_graphql.g.dart';

@JsonSerializable()
class DeviceIdValues {
  List<HierarchyFleetSearch>? hierarchyFleetSearch;

  DeviceIdValues({this.hierarchyFleetSearch});

  factory DeviceIdValues.fromJson(Map<String, dynamic> json) =>
      _$DeviceIdValuesFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceIdValuesToJson(this);
}

@JsonSerializable()
class HierarchyFleetSearch {
  String? vin;
  String? gpsDeviceID;
  @JsonKey(name: "__typename")
  String? typeName;

  HierarchyFleetSearch({this.vin, this.gpsDeviceID,this.typeName});
  factory HierarchyFleetSearch.fromJson(Map<String, dynamic> json) =>
      _$HierarchyFleetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$HierarchyFleetSearchToJson(this);
}
