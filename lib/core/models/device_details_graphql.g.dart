// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedDevice _$SelectedDeviceFromJson(Map<String, dynamic> json) =>
    SelectedDevice(
      singleFleetDetails: (json['singleFleetDetails'] as List<dynamic>?)
          ?.map((e) => SingleFleetDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SelectedDeviceToJson(SelectedDevice instance) =>
    <String, dynamic>{
      'singleFleetDetails': instance.singleFleetDetails,
    };

SingleFleetDetails _$SingleFleetDetailsFromJson(Map<String, dynamic> json) =>
    SingleFleetDetails(
      vin: json['vin'] as String?,
      gpsDeviceID: json['gpsDeviceID'] as String?,
      model: json['model'] as String?,
      oemName: json['oemName'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
      actualStartDate: json['actualStartDate'] as String?,
      subscriptionEndDate: json['subscriptionEndDate'] as String?,
      productFamily: json['productFamily'] as String?,
      customerName: json['customerName'] as String?,
      customerCode: json['customerCode'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCode: json['dealerCode'] as String?,
      commissioningDate: json['commissioningDate'] == null
          ? null
          : DateTime.parse(json['commissioningDate'] as String),
      secondaryIndustry: json['secondaryIndustry'] as String?,
      primaryIndustry: json['primaryIndustry'] as String?,
      networkProvider: json['networkProvider'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SingleFleetDetailsToJson(SingleFleetDetails instance) =>
    <String, dynamic>{
      'vin': instance.vin,
      'gpsDeviceID': instance.gpsDeviceID,
      'model': instance.model,
      'oemName': instance.oemName,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'actualStartDate': instance.actualStartDate,
      'subscriptionEndDate': instance.subscriptionEndDate,
      'productFamily': instance.productFamily,
      'customerName': instance.customerName,
      'customerCode': instance.customerCode,
      'dealerName': instance.dealerName,
      'dealerCode': instance.dealerCode,
      'commissioningDate': instance.commissioningDate?.toIso8601String(),
      'secondaryIndustry': instance.secondaryIndustry,
      'primaryIndustry': instance.primaryIndustry,
      'networkProvider': instance.networkProvider,
      'status': instance.status,
      'description': instance.description,
    };
