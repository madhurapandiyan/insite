import 'package:json_annotation/json_annotation.dart';
part 'add_notification_payload.g.dart';

@JsonSerializable()
class AddNotificationPayLoad {
  int? alertCategoryID;
  List<String>? assetUIDs;
  NotificationSubscribers? notificationSubscribers;
  bool? allAssets;
  String? currentDate;
  List<Schedule>? schedule;
  String? alertTitle;
  int? alertGroupId;
  int? notificationTypeGroupID;
  List<Operand>? operands;
  int? notificationTypeId;
  int? numberOfOccurences;
  String? notificationDeliveryChannel;

  AddNotificationPayLoad(
      {this.alertCategoryID,
      this.assetUIDs,
      this.notificationSubscribers,
      this.allAssets,
      this.currentDate,
      this.schedule,
      this.alertTitle,
      this.alertGroupId,
      this.operands,
      this.notificationTypeGroupID,
      this.notificationTypeId,
      this.numberOfOccurences,
      this.notificationDeliveryChannel});

  factory AddNotificationPayLoad.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationPayLoadToJson(this);
}

@JsonSerializable()
class NotificationSubscribers {
  List<String>? emailIds;
  List<String>? phoneNumbers;

  NotificationSubscribers({this.emailIds, this.phoneNumbers});
  factory NotificationSubscribers.fromJson(Map<String, dynamic> json) =>
      _$NotificationSubscribersFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSubscribersToJson(this);
}

@JsonSerializable()
class Schedule {
  int? day;
  String? startTime;
  String? endTime;

  Schedule({this.day, this.startTime, this.endTime});
  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Operand {
  int? operandID;
  int? operatorId;
  String? value;

  Operand({this.operandID, this.operatorId, this.value});

  factory Operand.fromJson(Map<String, dynamic> json) =>
      _$OperandFromJson(json);

  Map<String, dynamic> toJson() => _$OperandToJson(this);
}
