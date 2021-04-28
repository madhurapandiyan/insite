// {
//   "assetUid": "c1e5fa93-634e-e311-b5a0-90e2ba076184",
//   "assetSerialNumber": "ZZZ00024",
//   "makeCode": "CAT",
//   "manufacturer": "CAT",
//   "model": "TEST BENCH",
//   "year": 2014,
//   "assetIcon": 0,
//   "productFamily": "Unassigned",
//   "status": "Awaiting First Report",
//   "customStateDescription": "IN_TRANSIT",
//   "geofences": [

//   ],
//   "groups": [

//   ],
//   "devices": [
//     {
//       "deviceUID": "90c7d64e-05f9-e311-8d69-d067e5fd4637",
//       "deviceType": "Series523",
//       "deviceSerialNumber": "28399008RM",
//       "deviceState": "Subscribed",
//       "isGpsRollOverAffected": true,
//       "activeServicePlans": [
//         {
//           "serviceUID": "c54e6e18-85f1-43b4-b5ab-ea6cb6ec2d31",
//           "type": "Basic"
//         }
//       ]
//     }
//   ],
//   "dealerName": "CATERPILLAR DEMO DEALER TD00",
//   "dealerCustomerNumber": "C00DEV",
//   "accountName": "CAT PRODUCT DEV & MAINT",
//   "universalCustomerIdentifier": "2969600765",
//   "universalCustomerName": "CAT PRODUCT LINK INTERNAL"
// }

import 'package:insite/core/models/device.dart';
import 'package:json_annotation/json_annotation.dart';
part 'asset_detail.g.dart';

@JsonSerializable()
class AssetDetail {
  final String assetUid;
  final String assetSerialNumber;
  final String makeCode;
  final String manufacturer;
  final String model;
  final double year;
  final int assetIcon;
  final String productFamily;
  final String status;
  final String customStateDescription;
  final String dealerName;
  final String dealerCustomerNumber;
  final String accountName;
  final String universalCustomerIdentifier;
  final String universalCustomerName;
  final double lastReportedLocationLatitude;
  final double lastReportedLocationLongitude;
  final List<Device> devices;
  AssetDetail(
    this.assetUid,
    this.assetSerialNumber,
    this.makeCode,
    this.manufacturer,
    this.devices,
    this.model,
    this.year,
    this.assetIcon,
    this.productFamily,
    this.status,
    this.customStateDescription,
    this.dealerName,
    this.dealerCustomerNumber,
    this.accountName,
    this.universalCustomerIdentifier,
    this.universalCustomerName,
    this.lastReportedLocationLatitude,
    this.lastReportedLocationLongitude
  );
  factory AssetDetail.fromJson(Map<String, dynamic> json) =>
      _$AssetDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDetailToJson(this);
}
