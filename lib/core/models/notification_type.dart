import 'package:json_annotation/json_annotation.dart';
part 'notification_type.g.dart';

@JsonSerializable()
class AlertTypes {
  List<NotificationTypeGroups>? notificationTypeGroups;

  AlertTypes({this.notificationTypeGroups});

  factory AlertTypes.fromJson(Map<String, dynamic> json) =>
      _$AlertTypesFromJson(json);

  Map<String, dynamic> toJson() => _$AlertTypesToJson(this);
}

@JsonSerializable()
class NotificationTypeGroups {
  int? notificationTypeGroupID;
  String? notificationTypeGroupName;
  List<NotificationTypes>? notificationTypes;

  NotificationTypeGroups(
      {this.notificationTypeGroupID,
      this.notificationTypeGroupName,
      this.notificationTypes});

  factory NotificationTypeGroups.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTypeGroupsToJson(this);
}

@JsonSerializable()
class NotificationTypes {
  int? notificationTypeID;
  String? notificationTypeName;
  String? appName;
  String? appURL;
  List<Operands>? operands;
  List<SiteOperands>? siteOperands;

  NotificationTypes(
      {this.notificationTypeID,
      this.notificationTypeName,
      this.appName,
      this.appURL,
      this.operands,
      this.siteOperands});

  factory NotificationTypes.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypesFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTypesToJson(this);
}

@JsonSerializable()
class Operands {
  String? operandName;
  int? operandID;
  double? maxValue;
  double? minValue;
  int? maxOccurrence;
  int? minOccurrence;
  List<Operators>? operators;
  String? unit;

  Operands(
      {this.operandName,
      this.operandID,
      this.maxValue,
      this.minValue,
      this.maxOccurrence,
      this.minOccurrence,
      this.operators,
      this.unit});
  factory Operands.fromJson(Map<String, dynamic> json) =>
      _$OperandsFromJson(json);

  Map<String, dynamic> toJson() => _$OperandsToJson(this);
}

@JsonSerializable()
class Operators {
  int? operatorID;
  String? code;
  String? name;

  Operators({this.operatorID, this.code, this.name});

  factory Operators.fromJson(Map<String, dynamic> json) =>
      _$OperatorsFromJson(json);

  Map<String, dynamic> toJson() => _$OperatorsToJson(this);
}

@JsonSerializable()
class SiteOperands {
  String? operandName;
  int? operandID;
  double? maxValue;
  double? minValue;
  int? maxOccurrence;
  int? minOccurrence;
  List<Operators>? operators;

  SiteOperands(
      {this.operandName,
      this.operandID,
      this.maxValue,
      this.minValue,
      this.maxOccurrence,
      this.minOccurrence,
      this.operators});

  factory SiteOperands.fromJson(Map<String, dynamic> json) =>
      _$SiteOperandsFromJson(json);

  Map<String, dynamic> toJson() => _$SiteOperandsToJson(this);
}
