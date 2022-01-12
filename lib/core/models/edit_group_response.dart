

import 'package:json_annotation/json_annotation.dart';
part 'edit_group_response.g.dart';

@JsonSerializable()
class EditGroupResponse {
  String? GroupUid;
  String? GroupName;
  List<String?> ?AssetUID;
  String? CustomerUID;
  String ?Description;

  EditGroupResponse(
      {this.GroupUid, this.GroupName, this.AssetUID, this.CustomerUID, this.Description});

 factory EditGroupResponse.fromJson(Map<String, dynamic> json)=>_$EditGroupResponseFromJson(json);

  Map<String, dynamic> toJson()=>_$EditGroupResponseToJson(this);
}
