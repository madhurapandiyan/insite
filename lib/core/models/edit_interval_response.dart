import 'package:json_annotation/json_annotation.dart';
part 'edit_interval_response.g.dart';

@JsonSerializable()
class EditIntervalResponse{
   UpdateMaintenanceIntervals? updateMaintenanceIntervals;

  EditIntervalResponse({this.updateMaintenanceIntervals});

 factory EditIntervalResponse.fromJson(Map<String, dynamic> json)=>_$EditIntervalResponseFromJson(json); 

  Map<String, dynamic> toJson()=>_$EditIntervalResponseToJson(this); 
}


@JsonSerializable()
class UpdateMaintenanceIntervals {
  String? status;
  String? message;

  UpdateMaintenanceIntervals({this.status, this.message});

 factory UpdateMaintenanceIntervals.fromJson(Map<String, dynamic> json)=>_$UpdateMaintenanceIntervalsFromJson(json);

  Map<String, dynamic> toJson()=>_$UpdateMaintenanceIntervalsToJson(this);
}
