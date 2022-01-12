import 'package:json_annotation/json_annotation.dart';
part 'add_group_edit_payload.g.dart';

@JsonSerializable()
class AddGroupEditPayload {
  String? GroupUid;
  String? GroupName;
  String? Description;
  String? CustomerUID;
  List<String>? AssociatedAssetUID;
  List<String>?  DissociatedAssetUID;

  AddGroupEditPayload({
    this.GroupUid,
    this.GroupName,
    this.Description,
    this.CustomerUID,
    this.AssociatedAssetUID,
    this.DissociatedAssetUID
  });

  factory AddGroupEditPayload.fromJson(Map<String, dynamic> json) =>
      _$AddGroupEditPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$AddGroupEditPayloadToJson(this);
}
