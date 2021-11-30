// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_asset_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAssetRegistrationData _$AddAssetRegistrationDataFromJson(
    Map<String, dynamic> json) {
  return AddAssetRegistrationData(
    source: json['Source'] as String,
    version: json['Version'] as String,
    userID: json['UserID'] as int,
    asset: (json['asset'] as List)
        ?.map((e) =>
            e == null ? null : AssetValues.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..status = json['status'] as String;
}

Map<String, dynamic> _$AddAssetRegistrationDataToJson(
        AddAssetRegistrationData instance) =>
    <String, dynamic>{
      'Source': instance.source,
      'Version': instance.version,
      'UserID': instance.userID,
      'asset': instance.asset,
      'status': instance.status,
    };

AssetValues _$AssetValuesFromJson(Map<String, dynamic> json) {
  return AssetValues(
    deviceId: json['DeviceId'] as String,
    machineModel: json['MachineModel'] as String,
    hMR: json['HMR'] as int,
    hMRDate: json['HMRDate'] as String,
    primaryIndustry: json['PrimaryIndustry'] as String,
    secondaryIndustry: json['SecondaryIndustry'] as String,
    machineSlNo: json['MachineSlNo'] as String,
    commissioningDate: json['CommissioningDate'] as String,
    plantName: json['PlantName'] as String,
    plantCode: json['PlantCode'] as String,
    plantEmailID: json['PlantEmailID'] as String,
    dealerName: json['DealerName'] as String,
    dealerCode: json['DealerCode'] as String,
    dealerEmailID: json['DealerEmailID'] as String,
    customerName: json['CustomerName'] as String,
    customerCode: json['CustomerCode'] as String,
    customerEmailID: json['CustomerEmailID'] as String,
  );
}

Map<String, dynamic> _$AssetValuesToJson(AssetValues instance) =>
    <String, dynamic>{
      'DeviceId': instance.deviceId,
      'MachineModel': instance.machineModel,
      'HMR': instance.hMR,
      'HMRDate': instance.hMRDate,
      'PrimaryIndustry': instance.primaryIndustry,
      'SecondaryIndustry': instance.secondaryIndustry,
      'MachineSlNo': instance.machineSlNo,
      'CommissioningDate': instance.commissioningDate,
      'PlantName': instance.plantName,
      'PlantCode': instance.plantCode,
      'PlantEmailID': instance.plantEmailID,
      'DealerName': instance.dealerName,
      'DealerCode': instance.dealerCode,
      'DealerEmailID': instance.dealerEmailID,
      'CustomerName': instance.customerName,
      'CustomerCode': instance.customerCode,
      'CustomerEmailID': instance.customerEmailID,
    };
