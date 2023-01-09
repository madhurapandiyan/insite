import 'package:json_annotation/json_annotation.dart';
part 'manage_notification_filter.g.dart';
@JsonSerializable()
class ManageNotificationFilter {
  GetAlertConfigsCountData? getAlertConfigsCountData;
 

  ManageNotificationFilter(
      {this.getAlertConfigsCountData});

  factory ManageNotificationFilter.fromJson(Map<String, dynamic> json) =>
      _$ManageNotificationFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ManageNotificationFilterToJson(this);
}

@JsonSerializable()
class GetAlertConfigsCountData {
  List<AlertConfigs>? alertConfigs;

  GetAlertConfigsCountData(
      {this.alertConfigs});

  factory GetAlertConfigsCountData.fromJson(Map<String, dynamic> json) =>
      _$GetAlertConfigsCountDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAlertConfigsCountDataToJson(this);
}

@JsonSerializable()
class AlertConfigs {
 String? notificationType;
 String? notificationTypeGroup;
 int? count;

  AlertConfigs(
      {this.notificationType,this.notificationTypeGroup,this.count});

  factory AlertConfigs.fromJson(Map<String, dynamic> json) =>
      _$AlertConfigsFromJson(json);

  Map<String, dynamic> toJson() => _$AlertConfigsToJson(this);
}