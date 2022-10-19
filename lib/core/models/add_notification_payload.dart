import 'package:json_annotation/json_annotation.dart';
part 'add_notification_payload.g.dart';

@JsonSerializable(includeIfNull: false)
class AddNotificationPayLoad {
  int? alertCategoryID;
  String? notificationUid;
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

  List<String>? geofenceUIDs;

  List<String>? assetGroupUIDs;
  List<Operand>? siteOperands;
  List<ZonePayload>? zones;
  AddNotificationPayLoad(
      {this.alertCategoryID,
      this.notificationUid,
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
      this.notificationDeliveryChannel,
      this.assetGroupUIDs,
      this.geofenceUIDs,
      this.siteOperands,
      this.zones});

  factory AddNotificationPayLoad.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationPayLoadToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationSubscribers {
  List<String>? emailIds;
  List<String>? phoneNumbers;

  NotificationSubscribers({this.emailIds, this.phoneNumbers});
  factory NotificationSubscribers.fromJson(Map<String, dynamic> json) =>
      _$NotificationSubscribersFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSubscribersToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Schedule {
  int? day;
  String? startTime;
  String? endTime;
  @JsonKey(ignore: true)
  String? title;

  Schedule({this.day, this.startTime, this.endTime, this.title});
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

@JsonSerializable()
class ZonePayload {
  bool? isInclusion;
  String? zoneUID;

  ZonePayload({this.isInclusion, this.zoneUID});

  factory ZonePayload.fromJson(Map<String, dynamic> json) =>
      _$ZonePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ZonePayloadToJson(this);
}
