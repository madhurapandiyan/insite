import 'package:json_annotation/json_annotation.dart';
part 'notification_resolve.g.dart';

@JsonSerializable()
class NotificationStatus {
  final int? successCount;
  final int? failureCount;
  final String? status;
  NotificationStatus({
    this.successCount,
    this.failureCount,
    this.status
  });

  factory NotificationStatus.fromJson(Map<String, dynamic> json) =>
      _$NotificationStatusFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationStatusToJson(this);
}