// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_asset_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAssetRegistrationData _$AddAssetRegistrationDataFromJson(
        Map<String, dynamic> json) =>
    AddAssetRegistrationData(
      source: json['Source'] as String?,
      version: json['Version'] as String?,
      userID: json['UserID'] as int?,
      asset: (json['asset'] as List<dynamic>?)
          ?.map((e) => AssetValues.fromJson(e as Map<String, dynamic>))
          .toList(),
      transfer: (json['transfer'] as List<dynamic>?)
          ?.map((e) => AssetValues.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AddAssetRegistrationDataToJson(
        AddAssetRegistrationData instance) =>
    <String, dynamic>{
      'Source': instance.source,
      'Version': instance.version,
      'UserID': instance.userID,
      'asset': instance.asset,
      'status': instance.status,
      'transfer': instance.transfer,
    };

AssetValues _$AssetValuesFromJson(Map<String, dynamic> json) => AssetValues(
      deviceId: json['DeviceId'] as String?,
      machineModel: json['MachineModel'] as String?,
      hMR: json['HMR'] as int?,
      hMRDate: json['HMRDate'] as String?,
      primaryIndustry: json['PrimaryIndustry'] as String?,
      secondaryIndustry: json['SecondaryIndustry'] as String?,
      machineSlNo: json['MachineSlNo'] as String?,
      commissioningDate: json['CommissioningDate'] as String?,
      plantName: json['PlantName'] as String?,
      plantCode: json['PlantCode'] as String?,
      plantEmailID: json['PlantEmailID'] as String?,
      dealerName: json['DealerName'] as String?,
      dealerCode: json['DealerCode'] as String?,
      dealerEmailID: json['DealerEmailID'] as String?,
      customerName: json['CustomerName'] as String?,
      customerCode: json['CustomerCode'] as String?,
      customerEmailID: json['CustomerEmailID'] as String?,
      CustomerLanguage: json['CustomerLanguage'] as String?,
      CustomerMobile: json['CustomerMobile'] as String?,
      DealerLanguage: json['DealerLanguage'] as String?,
      DealerMobile: json['DealerMobile'] as String?,
    );

Map<String, dynamic> _$AssetValuesToJson(AssetValues instance) =>
    <String, dynamic>{
      'CustomerMobile': instance.CustomerMobile,
      'CustomerLanguage': instance.CustomerLanguage,
      'DealerMobile': instance.DealerMobile,
      'DealerLanguage': instance.DealerLanguage,
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
