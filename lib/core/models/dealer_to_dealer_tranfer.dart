import 'package:json_annotation/json_annotation.dart';
part 'dealer_to_dealer_tranfer.g.dart';
@JsonSerializable()
class DealerToDealerDetail {
  DealerToDealerTransfer? dealerToDealerTransfer;
  DealerToDealerDetail({this.dealerToDealerTransfer});

  factory DealerToDealerDetail.fromJson(Map<String, dynamic> json) =>
      _$DealerToDealerDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DealerToDealerDetailToJson(this);
}
@JsonSerializable()
class DealerToDealerTransfer {
   String? vin;
    String? gpsDeviceId;
    DateTime? commissioningDate;
    Details? customerDetails;
    Details? dealerDetails;
    String? secondaryIndustry;
    String? primaryIndustry;
    String? typename;
  DealerToDealerTransfer({
    this.vin,
    this.gpsDeviceId,
    this.commissioningDate,
    this.customerDetails,
    this.dealerDetails,
    this.secondaryIndustry,
    this.primaryIndustry,
    this.typename
    });

  factory DealerToDealerTransfer.fromJson(Map<String, dynamic> json) =>
      _$DealerToDealerTransferFromJson(json);

  Map<String, dynamic> toJson() => _$DealerToDealerTransferToJson(this);
}

@JsonSerializable()
class Details {
  String? name;
   String? code;
    String? email;
    @JsonKey(name: "__typename")
     String? typename;
  Details({
    this.name,
    this.code,
    this.email,
    this.typename,
    });

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

