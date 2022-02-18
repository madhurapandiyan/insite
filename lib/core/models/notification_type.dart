import 'package:json_annotation/json_annotation.dart';
part 'notification_type.g.dart';

@JsonSerializable()
class AlertTypes {
  List<NotificationTypeGroups>? notificationTypeGroups;
 

  AlertTypes({this.notificationTypeGroups,});

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
   final bool? isSelected;

  NotificationTypes(
      {this.notificationTypeID,
      this.notificationTypeName,
      this.appName,
      this.appURL,
      this.operands,
      this.isSelected,
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

@JsonSerializable()
class ZoneValues {
  List<Zones>? zones;
  String? responseStatus;

  ZoneValues({this.zones, this.responseStatus});

  factory ZoneValues.fromJson(Map<String, dynamic> json) =>
      _$ZoneValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneValuesToJson(this);
}

@JsonSerializable()
class Zones {
  String? zoneUID;
  String? zoneName;
  double? latitude;
  double? longitude;
  double? radius;

  Zones(
      {this.zoneUID,
      this.zoneName,
      this.latitude,
      this.longitude,
      this.radius});

  factory Zones.fromJson(Map<String, dynamic> json) => _$ZonesFromJson(json);

  Map<String, dynamic> toJson() => _$ZonesToJson(this);
}

@JsonSerializable()
class NotificationExist {
  bool? alertTitleExists;
  String? responseStatus;

  NotificationExist({this.alertTitleExists, this.responseStatus});
  factory NotificationExist.fromJson(Map<String, dynamic> json) =>
      _$NotificationExistFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationExistToJson(this);
}

@JsonSerializable()
class NotificationAdded {
  String? alertUID;
  String? responseStatus;

  NotificationAdded({this.alertUID, this.responseStatus});
  factory NotificationAdded.fromJson(Map<String, dynamic> json) =>
      _$NotificationAddedFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationAddedToJson(this);
}
