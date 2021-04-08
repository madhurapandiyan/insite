import 'package:json_annotation/json_annotation.dart';
part 'service_plan.g.dart';

@JsonSerializable()
class ServicePlan {
  final String serviceUID;
  final String type;
  ServicePlan(this.serviceUID, this.type);

  factory ServicePlan.fromJson(Map<String, dynamic> json) =>
      _$ServicePlanFromJson(json);

  Map<String, dynamic> toJson() => _$ServicePlanToJson(this);
}
