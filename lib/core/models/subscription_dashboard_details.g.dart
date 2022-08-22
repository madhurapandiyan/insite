// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dashboard_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDashboardDetailResult _$SubscriptionDashboardDetailResultFromJson(
        Map<String, dynamic> json) =>
    SubscriptionDashboardDetailResult(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => DetailResult.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      subscriptionFleetList: json['subscriptionFleetList'] == null
          ? null
          : SubscriptionFleetList.fromJson(
              json['subscriptionFleetList'] as Map<String, dynamic>),
      assetOrHierarchyByTypeAndId: (json['assetOrHierarchyByTypeAndId']
              as List<dynamic>?)
          ?.map((e) =>
              AssetOrHierarchyByTypeAndId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionDashboardDetailResultToJson(
        SubscriptionDashboardDetailResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscriptionFleetList': instance.subscriptionFleetList,
      'assetOrHierarchyByTypeAndId': instance.assetOrHierarchyByTypeAndId,
    };

AssetOrHierarchyByTypeAndId _$AssetOrHierarchyByTypeAndIdFromJson(
        Map<String, dynamic> json) =>
    AssetOrHierarchyByTypeAndId(
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      code: json['code'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AssetOrHierarchyByTypeAndIdToJson(
        AssetOrHierarchyByTypeAndId instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userName': instance.userName,
      'code': instance.code,
      'email': instance.email,
      'id': instance.id,
    };

SubscriptionFleetList _$SubscriptionFleetListFromJson(
        Map<String, dynamic> json) =>
    SubscriptionFleetList(
      count: json['count'] as int?,
      provisioningInfo: (json['provisioningInfo'] as List<dynamic>?)
          ?.map((e) => ProvisioningInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionFleetListToJson(
        SubscriptionFleetList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'provisioningInfo': instance.provisioningInfo,
    };

ProvisioningInfo _$ProvisioningInfoFromJson(Map<String, dynamic> json) =>
    ProvisioningInfo(
      gpsDeviceID: json['gpsDeviceID'] as String?,
      model: json['model'] as String?,
      vin: json['vin'] as String?,
      productFamily: json['productFamily'] as String?,
      customerCode: json['customerCode'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCode: json['dealerCode'] as String?,
      customerName: json['customerName'] as String?,
      status: json['status'],
      description: json['description'],
      networkProvider: json['networkProvider'] as String?,
    );

Map<String, dynamic> _$ProvisioningInfoToJson(ProvisioningInfo instance) =>
    <String, dynamic>{
      'gpsDeviceID': instance.gpsDeviceID,
      'model': instance.model,
      'vin': instance.vin,
      'productFamily': instance.productFamily,
      'customerCode': instance.customerCode,
      'dealerName': instance.dealerName,
      'dealerCode': instance.dealerCode,
      'customerName': instance.customerName,
      'status': instance.status,
      'description': instance.description,
      'networkProvider': instance.networkProvider,
    };

DetailResult _$DetailResultFromJson(Map<String, dynamic> json) => DetailResult(
      totalDevice: (json['totalDevice'] as num?)?.toDouble(),
      ActualStartDate: json['ActualStartDate'] as String?,
      CustomerCode: json['CustomerCode'] as String?,
      CustomerName: json['CustomerName'] as String?,
      DealerCode: json['DealerCode'] as String?,
      Code: json['Code'] as String?,
      Email: json['Email'] as String?,
      ID: json['ID'] as int?,
      Name: json['Name'] as String?,
      UserName: json['UserName'] as String?,
      OEMName: json['OEMName'] as String?,
      DealerName: json['DealerName'] as String?,
      CommissioningDate: json['CommissioningDate'] as String?,
      PrimaryIndustry: json['PrimaryIndustry'] as String?,
      SecondaryIndustry: json['SecondaryIndustry'] as String?,
      GPSDeviceID: json['GPSDeviceID'] as String?,
      Model: json['Model'] as String?,
      SubscriptionEndDate: json['SubscriptionEndDate'] as String?,
      SubscriptionStartDate: json['SubscriptionStartDate'] as String?,
      VIN: json['VIN'] as String?,
      NetworkProvider: json['NetworkProvider'] as String?,
      ProductFamily: json['ProductFamily'] as String?,
      fk_AssetId: json['fk_AssetId'] as int?,
      SourceName1: json['SourceName1'] as String?,
      SourceName2: json['SourceName2'] as String?,
      DestinationName1: json['DestinationName1'] as String?,
      DestinationName2: json['DestinationName2'] as String?,
      DestinationCustomerType: json['DestinationCustomerType'] as String?,
      InsertUTC: json['InsertUTC'] as String?,
      SourceCustomerType: json['SourceCustomerType'] as String?,
      Status: json['Status'] as String?,
      count: json['count'] as int?,
      Description: json['Description'] as String?,
      vin: json['vin'] as String?,
      fk_State: json['fk_State'] as int?,
    );

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
      'vin': instance.vin,
      'fk_AssetId': instance.fk_AssetId,
      'fk_State': instance.fk_State,
      'SourceName1': instance.SourceName1,
      'SourceName2': instance.SourceName2,
      'DestinationName1': instance.DestinationName1,
      'DestinationName2': instance.DestinationName2,
      'SourceCustomerType': instance.SourceCustomerType,
      'DestinationCustomerType': instance.DestinationCustomerType,
      'Status': instance.Status,
      'Description': instance.Description,
      'InsertUTC': instance.InsertUTC,
      'count': instance.count,
    };
