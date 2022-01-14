import 'package:json_annotation/json_annotation.dart';

part 'main_notification.g.dart';

@JsonSerializable()
class NotificationsData {
  final Total? total;
  final List<Notifications>? notifications;

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
class Total {
  int? items;
  int? pages;

  Total({this.items, this.pages});
  factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}

@JsonSerializable()
class Notifications {
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
  double? latitude;
  double? longitude;
  String? notificationType;
  String? notificationSubType;
  String notificationConfigJSON;
  String? resolvedStatus;
  String? readStatus;

  Notifications({
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

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}
