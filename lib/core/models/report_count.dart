
import 'package:json_annotation/json_annotation.dart';
part 'report_count.g.dart';

@JsonSerializable()
class ReportCount {
  List<CountReportData>? countData;

  ReportCount({this.countData});

 factory ReportCount.fromJson(Map<String, dynamic> json)=>_$ReportCountFromJson(json); 

  Map<String, dynamic> toJson()=>_$ReportCountToJson(this); 
}

@JsonSerializable()
class CountReportData {
  String? groupName;
  dynamic id;
  String? name;
  int? count;

  CountReportData({this.groupName, this.id, this.name, this.count});

 factory CountReportData.fromJson(Map<String, dynamic> json)=>_$CountReportDataFromJson(json);

  Map<String, dynamic> toJson()=>_$CountReportDataToJson(this); 
}