import 'package:json_annotation/json_annotation.dart';
part 'prefill_customer_details.g.dart';

@JsonSerializable()
class CustomerDetails {
  @JsonKey(name: "result")
  CustomerResult customerResult;
  CustomerDetails({this.customerResult});

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class CustomerResult {
  @JsonKey(name: "Customer")
  CustomerData customerData;

  CustomerResult({this.customerData});

  factory CustomerResult.fromJson(Map<String, dynamic> json) =>
      _$CustomerResultFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResultToJson(this);
}

@JsonSerializable()
class CustomerData {
  @JsonKey(name: "Name")
  String name;
  @JsonKey(name: "Code")
  String code;
  @JsonKey(name: "Email")
  String email;

  CustomerData({this.name, this.code, this.email});

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);
}
