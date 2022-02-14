import 'package:insite/core/models/admin_manage_user.dart';
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
  List<Operand>? operands;
  List<SiteOperand>? siteOperands;

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
class Operand {
  int? operandID;
  String? operandName;
  int? operatorID;
  String? condition;
  String? value;
  String? unit;

  Operand(
      {this.operandID,
      this.operandName,
      this.operatorID,
      this.condition,
      this.value,
      this.unit});

  factory Operand.fromJson(Map<String, dynamic> json) =>
      _$OperandFromJson(json);

  Map<String, dynamic> toJson() => _$OperandToJson(this);
}

@JsonSerializable()
class SiteOperand {
  int? operandID;
  String? operandName;
  int? geoFenceID;
  String? geoFenceUID;
  String? name;

  SiteOperand(
      {this.operandID,
      this.operandName,
      this.geoFenceID,
      this.geoFenceUID,
      this.name});

  factory SiteOperand.fromJson(Map<String, dynamic> json) =>
      _$SiteOperandFromJson(json);

  Map<String, dynamic> toJson() => _$SiteOperandToJson(this);
}
