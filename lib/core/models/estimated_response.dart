import 'package:json_annotation/json_annotation.dart';
part 'estimated_response.g.dart';


@JsonSerializable()
class EstimatedResponse {
  Data? data;

  EstimatedResponse({this.data});

 factory EstimatedResponse.fromJson(Map<String, dynamic> json)=>_$EstimatedResponseFromJson(json);

  Map<String, dynamic> toJson()=>_$EstimatedResponseToJson(this);
}


@JsonSerializable()
class Data {
  UpdateAssetTargetSettings? updateAssetTargetSettings;

  Data({this.updateAssetTargetSettings});

 factory Data.fromJson(Map<String, dynamic> json)=>_$DataFromJson(json); 

  Map<String, dynamic> toJson()=>_$DataToJson(this); 
}


@JsonSerializable()
class UpdateAssetTargetSettings {
  List<String>? assetUIDs;

  UpdateAssetTargetSettings({this.assetUIDs});

 factory UpdateAssetTargetSettings.fromJson(Map<String, dynamic> json)=>_$UpdateAssetTargetSettingsFromJson(json);

  Map<String, dynamic> toJson()=>_$UpdateAssetTargetSettingsToJson(this);
}