import 'package:json_annotation/json_annotation.dart';
part 'manage_notifications.g.dart';

@JsonSerializable()
class ManageNotificationsData {
  List<ConfiguredAlerts>? configuredAlerts;
  Links? links;
  Total? total;
  String? responseStatus;

  ManageNotificationsData(
      {this.configuredAlerts, this.links, this.total, this.responseStatus});

  factory ManageNotificationsData.fromJson(Map<String, dynamic> json) =>
      _$ManageNotificationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ManageNotificationsDataToJson(this);
}

@JsonSerializable()
class ConfiguredAlerts {
  int? alertConfigID;
  String? alertConfigUID;
  String? notificationTitle;
  bool? allAssetsInd;
  int? notificationTypeGroupID;
  int? notificationTypeID;
  String? createdDate;
  String? updatedDate;
  String? notificationType;
  int? numberOfAssets;
  int? numberOfAssetGroups;
  int? numberOfGeofences;
  int? alertCategoryID;
  int? alertGroupID;
  List<Operands>? operands;
  List<SiteOperands>? siteOperands;

  ConfiguredAlerts(
      {this.alertConfigID,
      this.alertConfigUID,
      this.notificationTitle,
      this.allAssetsInd,
      this.notificationTypeGroupID,
      this.notificationTypeID,
      this.createdDate,
      this.updatedDate,
      this.notificationType,
      this.numberOfAssets,
      this.numberOfAssetGroups,
      this.numberOfGeofences,
      this.alertCategoryID,
      this.alertGroupID,
      this.operands,
      this.siteOperands});

  factory ConfiguredAlerts.fromJson(Map<String, dynamic> json) =>
      _$ConfiguredAlertsFromJson(json);

  Map<String, dynamic> toJson() => _$ConfiguredAlertsToJson(this);
}

@JsonSerializable()
class Operands {
  int? operandID;
  String? operandName;
  int? operatorID;
  String? condition;
  String? value;
  String? unit;

  Operands(
      {this.operandID,
      this.operandName,
      this.operatorID,
      this.condition,
      this.value,
      this.unit});

  factory Operands.fromJson(Map<String, dynamic> json) =>
      _$OperandsFromJson(json);

  Map<String, dynamic> toJson() => _$OperandsToJson(this);
}

@JsonSerializable()
class SiteOperands {
  int? operandID;
  String? operandName;
  int? geoFenceID;
  String? geoFenceUID;
  String? name;

  SiteOperands(
      {this.operandID,
      this.operandName,
      this.geoFenceID,
      this.geoFenceUID,
      this.name});

  factory SiteOperands.fromJson(Map<String, dynamic> json) =>
      _$SiteOperandsFromJson(json);

  Map<String, dynamic> toJson() => _$SiteOperandsToJson(this);
}

@JsonSerializable()
class Links {
  String? prev;
  String? next;
  String? last;

  Links({this.prev, this.next, this.last});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Total {
  int? items;
  int? pages;

  Total({this.items, this.pages});
  factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}
