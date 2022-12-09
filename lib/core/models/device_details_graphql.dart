import 'package:json_annotation/json_annotation.dart';
part 'device_details_graphql.g.dart';

@JsonSerializable()
class SelectedDevice {
  List<SingleFleetDetails>? singleFleetDetails;

  SelectedDevice({this.singleFleetDetails});

  factory SelectedDevice.fromJson(Map<String, dynamic> json) =>
      _$SelectedDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedDeviceToJson(this);
}

@JsonSerializable()
class SingleFleetDetails {
  String? vin;
  String? gpsDeviceID;
  String? model;
  String? oemName;
  String? subscriptionStartDate;
  String? actualStartDate;
  String? subscriptionEndDate;
  String? productFamily;
  String? customerName;
  String? customerCode;
  String? dealerName;
  String? dealerCode;
  DateTime? commissioningDate;
  String? secondaryIndustry;
  String? primaryIndustry;
  String? networkProvider;
  String? status;
  String? description;

  SingleFleetDetails(
      {this.vin,
      this.gpsDeviceID,
      this.model,
      this.oemName,
      this.subscriptionStartDate,
      this.actualStartDate,
      this.subscriptionEndDate,
      this.productFamily,
      this.customerName,
      this.customerCode,
      this.dealerName,
      this.dealerCode,
      this.commissioningDate,
      this.secondaryIndustry,
      this.primaryIndustry,
      this.networkProvider,
      this.status,
      this.description});

  factory SingleFleetDetails.fromJson(Map<String, dynamic> json) =>
      _$SingleFleetDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SingleFleetDetailsToJson(this);
}
