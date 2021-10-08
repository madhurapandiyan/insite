import 'package:json_annotation/json_annotation.dart';
part 'add_user.g.dart';


@JsonSerializable()
class AddUser {
    AddUser({
        this.userUid,
    });

    String userUid;

    factory AddUser.fromJson(Map<String, dynamic> json) =>_$AddUserFromJson(json);

    Map<String, dynamic> toJson() => _$AddUserToJson(this);
}
