// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_report_delete_asset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageReportDeleteAssetResponse _$ManageReportDeleteAssetResponseFromJson(
        Map<String, dynamic> json) =>
    ManageReportDeleteAssetResponse(
      status: json['status'] as int?,
      reqId: json['reqId'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$ManageReportDeleteAssetResponseToJson(
        ManageReportDeleteAssetResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'reqId': instance.reqId,
      'msg': instance.msg,
    };
