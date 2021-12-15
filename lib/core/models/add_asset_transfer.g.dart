// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_asset_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetTransferData _$AssetTransferDataFromJson(Map<String, dynamic> json) {
  return AssetTransferData(
    source: json['Source'] as String,
    transfer: (json['transfer'] as List)
        ?.map((e) =>
            e == null ? null : Transfer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userID: json['UserID'] as int,
    version: json['Version'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$AssetTransferDataToJson(AssetTransferData instance) =>
    <String, dynamic>{
      'Source': instance.source,
      'Version': instance.version,
      'UserID': instance.userID,
      'transfer': instance.transfer,
      'status': instance.status,
    };

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return Transfer(
    deviceId: json['DeviceId'] as String,
    machineModel: json['MachineModel'] as String,
    hMR: json['HMR'] as String,
    hMRDate: json['HMRDate'] as String,
    plantName: json['PlantName'] as String,
    plantCode: json['PlantCode'] as String,
    plantEmailID: json['PlantEmailID'] as String,
    primaryIndustry: json['PrimaryIndustry'] as String,
    secondaryIndustry: json['SecondaryIndustry'] as String,
    dealerLanguage: json['DealerLanguage'] as String,
    dealerMobile: json['DealerMobile'] as String,
    customerLanguage: json['CustomerLanguage'] as String,
    customerMobile: json['CustomerMobile'] as String,
    machineSlNo: json['MachineSlNo'] as String,
    commissioningDate: json['CommissioningDate'] as String,
    dealerName: json['DealerName'] as String,
    dealerCode: json['DealerCode'] as String,
    dealerEmailID: json['DealerEmailID'] as String,
    customerName: json['CustomerName'] as String,
    customerCode: json['CustomerCode'] as String,
    customerEmailID: json['CustomerEmailID'] as String,
  );
}

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'DeviceId': instance.deviceId,
      'MachineModel': instance.machineModel,
      'HMR': instance.hMR,
      'HMRDate': instance.hMRDate,
      'PlantName': instance.plantName,
      'PlantCode': instance.plantCode,
      'PlantEmailID': instance.plantEmailID,
      'PrimaryIndustry': instance.primaryIndustry,
      'SecondaryIndustry': instance.secondaryIndustry,
      'DealerLanguage': instance.dealerLanguage,
      'DealerMobile': instance.dealerMobile,
      'CustomerLanguage': instance.customerLanguage,
      'CustomerMobile': instance.customerMobile,
      'MachineSlNo': instance.machineSlNo,
      'CommissioningDate': instance.commissioningDate,
      'DealerName': instance.dealerName,
      'DealerCode': instance.dealerCode,
      'DealerEmailID': instance.dealerEmailID,
      'CustomerName': instance.customerName,
      'CustomerCode': instance.customerCode,
      'CustomerEmailID': instance.customerEmailID,
    };
