import 'package:json_annotation/json_annotation.dart';
part 'filter_notification.g.dart';

@JsonSerializable()
class NotificationItem {
  final String? notificationStatusInd;
  final int? countOf;

  NotificationItem({
    this.notificationStatusInd,
    this.countOf
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}

@JsonSerializable()
class FilterNotification {
  final List<NotificationItem>? notifications;
  
  FilterNotification({
    this.notifications
  });

  factory FilterNotification.fromJson(Map<String, dynamic> json) =>
      _$FilterNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FilterNotificationToJson(this);
}
