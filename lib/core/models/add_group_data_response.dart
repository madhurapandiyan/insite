import 'package:json_annotation/json_annotation.dart';
part 'add_group_data_response.g.dart';

@JsonSerializable()
class AddGroupDataResponse {
  String? groupUID;

  AddGroupDataResponse({this.groupUID});

  factory AddGroupDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AddGroupDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddGroupDataResponseToJson(this);
}
