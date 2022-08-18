import 'package:json_annotation/json_annotation.dart';
part 'asset_creation_response.g.dart';


@JsonSerializable()
class AssetCreationResponse {
  String? code;
  String? status;
  Result? result;
  AssetModelByMachineSerialNumber? assetModelByMachineSerialNumber;

  AssetCreationResponse({this.code, this.status, this.result,this.assetModelByMachineSerialNumber});

 factory AssetCreationResponse.fromJson(Map<String, dynamic> json) =>_$AssetCreationResponseFromJson(json);

  Map<String, dynamic> toJson() =>_$AssetCreationResponseToJson(this);
}
@JsonSerializable()
class AssetModelByMachineSerialNumber {
  int? endRange;
  String? modelName;
  int? groupClusterId;
  int? startRange;
  String? startsWith;

  AssetModelByMachineSerialNumber(
      {this.endRange,
      this.modelName,
      this.groupClusterId,
      this.startRange,
      this.startsWith}); 
      factory AssetModelByMachineSerialNumber.fromJson(Map<String, dynamic> json)=>_$AssetModelByMachineSerialNumberFromJson(json); 

  Map<String, dynamic> toJson()=>_$AssetModelByMachineSerialNumberToJson(this); 

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