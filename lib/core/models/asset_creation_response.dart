import 'package:json_annotation/json_annotation.dart';
part 'asset_creation_response.g.dart';


@JsonSerializable()
class AssetCreationResponse {
  String? code;
  String? status;
  Result? result;

  AssetCreationResponse({this.code, this.status, this.result});

 factory AssetCreationResponse.fromJson(Map<String, dynamic> json) =>_$AssetCreationResponseFromJson(json);

  Map<String, dynamic> toJson() =>_$AssetCreationResponseToJson(this);
}

@JsonSerializable()
class Result {
  String? startsWith;
  int? startRange;
  int? endRange;
  int? groupClusterId;
  String? modelName;

  Result(
      {this.startsWith,
      this.startRange,
      this.endRange,
      this.groupClusterId,
      this.modelName});

 factory Result.fromJson(Map<String, dynamic> json)=>_$ResultFromJson(json); 
  Map<String, dynamic> toJson()=>_$ResultToJson(this);
}