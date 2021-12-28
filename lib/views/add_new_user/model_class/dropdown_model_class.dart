import 'package:insite/core/models/admin_manage_user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dropdown_model_class.g.dart';

@JsonSerializable()
class ApplicationSelectedDropDown {
  ApplicationAccessData? accessData;
  String? value;
  String? key;
  String? applicationName;
  ApplicationSelectedDropDown(
      {this.accessData, this.value, this.key, this.applicationName});

  factory ApplicationSelectedDropDown.fromJson(Map<String, dynamic> json) =>
      _$ApplicationSelectedDropDownFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationSelectedDropDownToJson(this);
}
