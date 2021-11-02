// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDashboardDetailResult _$SubscriptionDashboardDetailResultFromJson(
    Map<String, dynamic> json) {
  return SubscriptionDashboardDetailResult(
    result: (json['result'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : DetailResult.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$SubscriptionDashboardDetailResultToJson(
        SubscriptionDashboardDetailResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

DetailResult _$DetailResultFromJson(Map<String, dynamic> json) {
  return DetailResult(
    totalDevice: (json['totalDevice'] as num)?.toDouble(),
    ActualStartDate: json['ActualStartDate'] as String,
    CustomerCode: json['CustomerCode'] as String,
    CustomerName: json['CustomerName'] as String,
    DealerCode: json['DealerCode'] as String,
    Code: json['Code'] as String,
    Email: json['Email'] as String,
    ID: json['ID'] as int,
    Name: json['Name'] as String,
    UserName: json['UserName'] as String,
    OEMName: json['OEMName'] as String,
    DealerName: json['DealerName'] as String,
    CommissioningDate: json['CommissioningDate'] as String,
    PrimaryIndustry: json['PrimaryIndustry'] as String,
    SecondaryIndustry: json['SecondaryIndustry'] as String,
    GPSDeviceID: json['GPSDeviceID'] as String,
    Model: json['Model'] as String,
    SubscriptionEndDate: json['SubscriptionEndDate'] as String,
    SubscriptionStartDate: json['SubscriptionStartDate'] as String,
    VIN: json['VIN'] as String,
    NetworkProvider: json['NetworkProvider'] as String,
    ProductFamily: json['ProductFamily'] as String,
  );
}

Map<String, dynamic> _$DetailResultToJson(DetailResult instance) =>
    <String, dynamic>{
      'totalDevice': instance.totalDevice,
      'GPSDeviceID': instance.GPSDeviceID,
      'VIN': instance.VIN,
      'Model': instance.Model,
      'ActualStartDate': instance.ActualStartDate,
      'SubscriptionStartDate': instance.SubscriptionStartDate,
      'SubscriptionEndDate': instance.SubscriptionEndDate,
      'ProductFamily': instance.ProductFamily,
      'CustomerName': instance.CustomerName,
      'CustomerCode': instance.CustomerCode,
      'DealerName': instance.DealerName,
      'DealerCode': instance.DealerCode,
      'NetworkProvider': instance.NetworkProvider,
      'CommissioningDate': instance.CommissioningDate,
      'SecondaryIndustry': instance.SecondaryIndustry,
      'PrimaryIndustry': instance.PrimaryIndustry,
      'OEMName': instance.OEMName,
      'ID': instance.ID,
      'Name': instance.Name,
      'UserName': instance.UserName,
      'Email': instance.Email,
      'Code': instance.Code,
    };
