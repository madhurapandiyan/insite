import 'package:insite/core/models/manage_notifications.dart';
import 'package:json_annotation/json_annotation.dart';
part 'alert_config_edit.g.dart';

@JsonSerializable(explicitToJson: true)
class AlertConfigEdit {
  ConfiguredAlerts? alertConfig;
  String? responseStatus;

  AlertConfigEdit({this.alertConfig, this.responseStatus});
  factory AlertConfigEdit.fromJson(Map<String, dynamic> json) =>
      _$AlertConfigEditFromJson(json);

  Map<String, dynamic> toJson() => _$AlertConfigEditToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Assets {
  int? assetID;
  String? assetUID;
  String? assetName;

  Assets({this.assetID, this.assetUID, this.assetName});
  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleDetails {
  int? alertConfigScheduleDtlID;
  int? scheduleDayNum;
  String? scheduleStartTime;
  String? scheduleEndTime;

  ScheduleDetails(
      {this.alertConfigScheduleDtlID,
      this.scheduleDayNum,
      this.scheduleStartTime,
      this.scheduleEndTime});
  factory ScheduleDetails.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeliveryConfig {
  int? deliveryConfigID;
  int? deliveryModeInd;
  String? recipientStr;
  bool? isVLUser;

  DeliveryConfig(
      {this.deliveryConfigID,
      this.deliveryModeInd,
      this.recipientStr,
      this.isVLUser});
  factory DeliveryConfig.fromJson(Map<String, dynamic> json) =>
      _$DeliveryConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryConfigToJson(this);
}
