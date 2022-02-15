import 'package:json_annotation/json_annotation.dart';
part 'manage_report_delete_asset_response.g.dart';

@JsonSerializable()
class ManageReportDeleteAssetResponse {
  int? status;
  String? reqId;
  String? msg;

  ManageReportDeleteAssetResponse({this.status, this.reqId, this.msg});

 factory ManageReportDeleteAssetResponse.fromJson(Map<String, dynamic> json)=>_$ManageReportDeleteAssetResponseFromJson(json);
  Map<String, dynamic> toJson()=>_$ManageReportDeleteAssetResponseToJson(this);
}