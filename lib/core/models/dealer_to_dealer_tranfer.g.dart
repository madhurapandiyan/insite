// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_to_dealer_tranfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealerToDealerDetail _$DealerToDealerDetailFromJson(
        Map<String, dynamic> json) =>
    DealerToDealerDetail(
      dealerToDealerTransfer: json['dealerToDealerTransfer'] == null
          ? null
          : DealerToDealerTransfer.fromJson(
              json['dealerToDealerTransfer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DealerToDealerDetailToJson(
        DealerToDealerDetail instance) =>
    <String, dynamic>{
      'dealerToDealerTransfer': instance.dealerToDealerTransfer,
    };

DealerToDealerTransfer _$DealerToDealerTransferFromJson(
        Map<String, dynamic> json) =>
    DealerToDealerTransfer(
      vin: json['vin'] as String?,
      gpsDeviceId: json['gpsDeviceId'] as String?,
      commissioningDate: json['commissioningDate'] == null
          ? null
          : DateTime.parse(json['commissioningDate'] as String),
      customerDetails: json['customerDetails'] == null
          ? null
          : Details.fromJson(json['customerDetails'] as Map<String, dynamic>),
      dealerDetails: json['dealerDetails'] == null
          ? null
          : Details.fromJson(json['dealerDetails'] as Map<String, dynamic>),
      secondaryIndustry: json['secondaryIndustry'] as String?,
      primaryIndustry: json['primaryIndustry'] as String?,
      typename: json['typename'] as String?,
    );

Map<String, dynamic> _$DealerToDealerTransferToJson(
        DealerToDealerTransfer instance) =>
    <String, dynamic>{
      'vin': instance.vin,
      'gpsDeviceId': instance.gpsDeviceId,
      'commissioningDate': instance.commissioningDate?.toIso8601String(),
      'customerDetails': instance.customerDetails,
      'dealerDetails': instance.dealerDetails,
      'secondaryIndustry': instance.secondaryIndustry,
      'primaryIndustry': instance.primaryIndustry,
      'typename': instance.typename,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      name: json['name'] as String?,
      code: json['code'] as String?,
      email: json['email'] as String?,
      typename: json['__typename'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'email': instance.email,
      '__typename': instance.typename,
    };
