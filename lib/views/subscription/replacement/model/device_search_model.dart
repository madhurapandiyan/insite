import 'package:json_annotation/json_annotation.dart';
part 'device_search_model.g.dart';

@JsonSerializable()
class DeviceSearchModel {
  final String code;
  final String status;
  final List<List<DeviceContainsList>> result;
  DeviceSearchModel({this.code,this.result,this.status});

  factory DeviceSearchModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSearchModelToJson(this);
}

@JsonSerializable()
class DeviceContainsList {
  final int count;
  final String containsList;
DeviceContainsList({this.count,this.containsList});

    factory DeviceContainsList.fromJson(Map<String, dynamic> json) =>
      _$DeviceContainsListFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceContainsListToJson(this);
}
