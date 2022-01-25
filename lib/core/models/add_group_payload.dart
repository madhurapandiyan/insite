import 'package:json_annotation/json_annotation.dart';
part 'add_group_payload.g.dart';



@JsonSerializable()
class AddGroupPayLoad {
  List<String?>? AssetUID;
  String? GroupName;
  String? Description;

  AddGroupPayLoad({this.AssetUID,this.GroupName,this.Description});

 factory AddGroupPayLoad.fromJson(Map<String, dynamic> json)=>_$AddGroupPayLoadFromJson(json);

  Map<String, dynamic> toJson()=>_$AddGroupPayLoadToJson(this); 
}