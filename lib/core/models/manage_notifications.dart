import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/alert_config_edit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'manage_notifications.g.dart';

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
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
  List<OperandData>? operands;
  List<SiteOperand>? siteOperands;
  List<Assets>? assets;
  List<ScheduleDetails>? scheduleDetails;
  List<DeliveryConfig>? deliveryConfig;

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
      this.siteOperands,
      this.assets,
      this.deliveryConfig,
      this.scheduleDetails});

  factory ConfiguredAlerts.fromJson(Map<String, dynamic> json) =>
      _$ConfiguredAlertsFromJson(json);

  Map<String, dynamic> toJson() => _$ConfiguredAlertsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OperandData {
  int? operandID;
  String? operandName;
  int? operatorID;
  String? condition;
  String? value;
  String? unit;

  OperandData(
      {this.operandID,
      this.operandName,
      this.operatorID,
      this.condition,
      this.value,
      this.unit});

  factory OperandData.fromJson(Map<String, dynamic> json) =>
      _$OperandDataFromJson(json);

  Map<String, dynamic> toJson() => _$OperandDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SiteOperand {
  int? operandID;
  String? operandName;
  int? geoFenceID;
  String? geoFenceUID;
  String? name;
  String? condition;

  SiteOperand(
      {this.operandID,
      this.operandName,
      this.geoFenceID,
      this.geoFenceUID,
      this.condition,
      this.name});

  factory SiteOperand.fromJson(Map<String, dynamic> json) =>
      _$SiteOperandFromJson(json);

  Map<String, dynamic> toJson() => _$SiteOperandToJson(this);
}
