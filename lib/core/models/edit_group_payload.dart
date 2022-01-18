import 'package:json_annotation/json_annotation.dart';
part 'edit_group_payload.g.dart';

@JsonSerializable()
class EditGroupPayLoad {
  String? GroupUid;
  String? GroupName;
  String? Description;
  String? CustomerUID;
  List<String>? AssociatedAssetUID;
  List<String>?  DissociatedAssetUID;

  EditGroupPayLoad({
    this.GroupUid,
    this.GroupName,
    this.Description,
    this.CustomerUID,
    this.AssociatedAssetUID,
    this.DissociatedAssetUID
  });

  factory EditGroupPayLoad.fromJson(Map<String, dynamic> json) =>
      _$EditGroupPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$EditGroupPayLoadToJson(this);
}
