import 'package:insite/core/models/admin_manage_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_notification.g.dart';

@JsonSerializable()
class NotificationsData {
  final Total? total;
  final List<Notification>? notifications;

  final String? status;

  NotificationsData({
    this.total,
    this.notifications,
    this.status,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsDataToJson(this);
}

@JsonSerializable()
class Notification {
  bool? isSelected;
  String? notificationUID;
  String? notificationTitle;
  String? occurUTC;
  String? assetUID;
  String? serialNumber;
  String? assetName;
  String? makeCode;
  String? model;
  String? location;
  int? iconKey;
  dynamic latitude;
  dynamic longitude;
  String? notificationType;
  String? notificationSubType;
  String notificationConfigJSON;
  String? resolvedStatus;
  String? readStatus;

  Notification({
    this.notificationUID,
    this.notificationTitle,
    this.occurUTC,
    this.assetUID,
    this.serialNumber,
    this.assetName,
    this.makeCode,
    this.model,
    this.location,
    this.iconKey,
    this.latitude,
    this.longitude,
    this.notificationType,
    this.notificationSubType,
    required this.notificationConfigJSON,
    this.resolvedStatus,
    this.readStatus,
    this.isSelected = false,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
