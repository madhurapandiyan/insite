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
      actualStartDate: json['actualStartDate'] as String?,
      subscriptionEndDate: json['subscriptionEndDate'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
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
      'subscriptionStartDate': instance.subscriptionStartDate,
      'actualStartDate': instance.actualStartDate,
      'subscriptionEndDate': instance.subscriptionEndDate,
    };

DetailResult _$DetailResultFromJson(Map<String, dynamic> json) => DetailResult(
      totalDevice: (json['totalDevice'] as num?)?.toDouble(),
      actualStartDate: json['ActualStartDate'] as String?,
      customerCode: json['CustomerCode'] as String?,
      customerName: json['CustomerName'] as String?,
      dealerCode: json['DealerCode'] as String?,
      code: json['Code'] as String?,
      email: json['Email'] as String?,
      id: json['ID'] as int?,
      name: json['Name'] as String?,
      userName: json['UserName'] as String?,
      oemName: json['OEMName'] as String?,
      dealerName: json['DealerName'] as String?,
      commissioningDate: json['CommissioningDate'] as String?,
      primaryIndustry: json['PrimaryIndustry'] as String?,
      secondaryIndustry: json['SecondaryIndustry'] as String?,
      gpsDeviceId: json['GPSDeviceID'] as String?,
      model: json['Model'] as String?,
      subscriptionEndDate: json['SubscriptionEndDate'] as String?,
      subscriptionStartDate: json['SubscriptionStartDate'] as String?,
      vin: json['vin'] as String?,
      networkProvider: json['NetworkProvider'] as String?,
      productFamily: json['ProductFamily'] as String?,
      fkAssetId: json['fk_AssetId'] as int?,
      sourceName1: json['SourceName1'] as String?,
      sourceName2: json['SourceName2'] as String?,
      destinationName1: json['DestinationName1'] as String?,
      destinationName2: json['DestinationName2'] as String?,
      destinationCustomerType: json['DestinationCustomerType'] as String?,
      insertUtc: json['InsertUTC'] as String?,
      sourceCustomerType: json['SourceCustomerType'] as String?,
      status: json['Status'] as String?,
      count: json['count'] as int?,
      description: json['Description'] as String?,
      fkState: json['fk_State'] as int?,
    );

Map<String, dynamic> _$DetailResultToJson(DetailResult instance) =>
    <String, dynamic>{
      'totalDevice': instance.totalDevice,
      'GPSDeviceID': instance.gpsDeviceId,
      'vin': instance.vin,
      'Model': instance.model,
      'ActualStartDate': instance.actualStartDate,
      'SubscriptionStartDate': instance.subscriptionStartDate,
      'SubscriptionEndDate': instance.subscriptionEndDate,
      'ProductFamily': instance.productFamily,
      'CustomerName': instance.customerName,
      'CustomerCode': instance.customerCode,
      'DealerName': instance.dealerName,
      'DealerCode': instance.dealerCode,
      'NetworkProvider': instance.networkProvider,
      'CommissioningDate': instance.commissioningDate,
      'SecondaryIndustry': instance.secondaryIndustry,
      'PrimaryIndustry': instance.primaryIndustry,
      'OEMName': instance.oemName,
      'ID': instance.id,
      'Name': instance.name,
      'UserName': instance.userName,
      'Email': instance.email,
      'Code': instance.code,
      'fk_AssetId': instance.fkAssetId,
      'fk_State': instance.fkState,
      'SourceName1': instance.sourceName1,
      'SourceName2': instance.sourceName2,
      'DestinationName1': instance.destinationName1,
      'DestinationName2': instance.destinationName2,
      'SourceCustomerType': instance.sourceCustomerType,
      'DestinationCustomerType': instance.destinationCustomerType,
      'Status': instance.status,
      'Description': instance.description,
      'InsertUTC': instance.insertUtc,
      'count': instance.count,
    };
