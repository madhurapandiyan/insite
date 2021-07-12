import 'package:insite/core/models/service_plan.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

@JsonSerializable()
class Device {
  final String deviceType;
  final String deviceSerialNumber;
  final String mainboardSoftwareVersion;
  final bool isGpsRollOverAffected;
  final String deviceUID;
  final List<ServicePlan> activeServicePlans;
  Device(
      {this.deviceType,
      this.deviceUID,
      this.deviceSerialNumber,
      this.activeServicePlans,
      this.isGpsRollOverAffected,
      this.mainboardSoftwareVersion});
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
