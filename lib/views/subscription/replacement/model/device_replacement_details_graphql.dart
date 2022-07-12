import 'package:json_annotation/json_annotation.dart';
part 'device_replacement_details_graphql.g.dart';

@JsonSerializable()
class ReplacementData {
  List<ReplacementHistory>? replacementHistory;

  ReplacementData({this.replacementHistory});

  factory ReplacementData.fromJson(Map<String, dynamic> json) =>
      _$ReplacementDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementDataToJson(this);
}

@JsonSerializable()
class ReplacementHistory {
  String? oldDeviceId;
  String? newDeviceId;
  String? reason;
  String? vin;
  String? insertUTC;
  String? emailID;
  String? firstName;
  String? lastName;
  String? state;
  String? description;
  String? sTypename;

  ReplacementHistory(
      {this.oldDeviceId,
      this.newDeviceId,
      this.reason,
      this.vin,
      this.insertUTC,
      this.emailID,
      this.firstName,
      this.lastName,
      this.state,
      this.description,
      this.sTypename});

  factory ReplacementHistory.fromJson(Map<String, dynamic> json) =>
      _$ReplacementHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementHistoryToJson(this);
}
