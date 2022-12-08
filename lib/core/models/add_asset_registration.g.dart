// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_asset_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAssetRegistrationData _$AddAssetRegistrationDataFromJson(
        Map<String, dynamic> json) =>
    AddAssetRegistrationData(
      Source: json['Source'] as String?,
      Version: json['Version'] as String?,
      UserID: json['UserID'] as int?,
      asset: (json['asset'] as List<dynamic>?)
          ?.map((e) => AssetValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddAssetRegistrationDataToJson(
        AddAssetRegistrationData instance) =>
    <String, dynamic>{
      'Source': instance.Source,
      'Version': instance.Version,
      'UserID': instance.UserID,
      'asset': instance.asset,
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

AssetTransfer _$AssetTransferFromJson(Map<String, dynamic> json) =>
    AssetTransfer(
      Source: json['Source'] as String?,
      UserID: json['UserID'] as int?,
      Version: json['Version'] as String?,
      transfer: (json['transfer'] as List<dynamic>?)
          ?.map((e) => AssetValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetTransferToJson(AssetTransfer instance) =>
    <String, dynamic>{
      'Source': instance.Source,
      'Version': instance.Version,
      'UserID': instance.UserID,
      'transfer': instance.transfer,
    };

AssetOperation _$AssetOperationFromJson(Map<String, dynamic> json) =>
    AssetOperation(
      code: json['code'] as String?,
      status: json['status'] as String?,
      requestId: json['requestID'] as String?,
      typename: json['__typename'] as String?,
    );

Map<String, dynamic> _$AssetOperationToJson(AssetOperation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'requestID': instance.requestId,
      '__typename': instance.typename,
    };

AssetOperationInput _$AssetOperationInputFromJson(Map<String, dynamic> json) =>
    AssetOperationInput(
      source: json['source'] as String?,
      userId: json['userID'] as int?,
      version: json['version'] as String?,
      asset: (json['asset'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetOperationInputToJson(AssetOperationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  writeNotNull('userID', instance.userId);
  writeNotNull('version', instance.version);
  writeNotNull('asset', instance.asset?.map((e) => e.toJson()).toList());
  return val;
}

TranferAssetOperationInput _$TranferAssetOperationInputFromJson(
        Map<String, dynamic> json) =>
    TranferAssetOperationInput(
      source: json['source'] as String?,
      userId: json['userID'] as int?,
      version: json['version'] as String?,
      transfer: (json['transfer'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranferAssetOperationInputToJson(
    TranferAssetOperationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  writeNotNull('userID', instance.userId);
  writeNotNull('version', instance.version);
  writeNotNull('transfer', instance.transfer?.map((e) => e.toJson()).toList());
  return val;
}

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      deviceId: json['deviceId'] as String?,
      machineModel: json['machineModel'] as String?,
      hmr: json['hmr'] as int?,
      hmrDate: json['hmrDate'] as String?,
      primaryIndustry: json['primaryIndustry'] as String?,
      secondaryIndustry: json['secondaryIndustry'] as String?,
      machineSlNo: json['machineSlNo'] as String?,
      commissioningDate: json['commissioningDate'] as String?,
      plantName: json['plantName'] as String?,
      plantCode: json['plantCode'] as String?,
      plantEmailId: json['plantEmailID'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerCode: json['dealerCode'] as String?,
      dealerEmailId: json['dealerEmailID'] as String?,
      customerName: json['customerName'] as String?,
      customerCode: json['customerCode'] as String?,
      customerEmailId: json['customerEmailID'] as String?,
      customerLanguage: json['customerLanguage'] as String?,
      customerMobile: json['customerMobile'] as String?,
      dealerLanguage: json['dealerLanguage'] as String?,
      dealerMobile: json['dealerMobile'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('customerMobile', instance.customerMobile);
  writeNotNull('customerLanguage', instance.customerLanguage);
  writeNotNull('dealerMobile', instance.dealerMobile);
  writeNotNull('dealerLanguage', instance.dealerLanguage);
  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('machineModel', instance.machineModel);
  writeNotNull('hmr', instance.hmr);
  writeNotNull('hmrDate', instance.hmrDate);
  writeNotNull('primaryIndustry', instance.primaryIndustry);
  writeNotNull('secondaryIndustry', instance.secondaryIndustry);
  writeNotNull('machineSlNo', instance.machineSlNo);
  writeNotNull('commissioningDate', instance.commissioningDate);
  writeNotNull('plantName', instance.plantName);
  writeNotNull('plantCode', instance.plantCode);
  writeNotNull('plantEmailID', instance.plantEmailId);
  writeNotNull('dealerName', instance.dealerName);
  writeNotNull('dealerCode', instance.dealerCode);
  writeNotNull('dealerEmailID', instance.dealerEmailId);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('customerCode', instance.customerCode);
  writeNotNull('customerEmailID', instance.customerEmailId);
  return val;
}
