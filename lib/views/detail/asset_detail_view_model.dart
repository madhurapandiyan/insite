import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/utils/enums.dart' as enu;
import 'package:insite/views/maintenance/main/main_detail_popup/main_detail_popup_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/models/maintenance_checkList.dart';
import '../../core/services/maintenance_service.dart';

class AssetDetailViewModel extends InsiteViewModel {
  AssetService? _assetService = locator<AssetService>();

  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();

  Logger? log;
  Fleet? fleet;
  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

  bool _loading = true;
  bool get loading => _loading;

  List<Services?>? _servicesData = [];
  List<Services?>? get servicesData => _servicesData;

  AssetDetailViewModel(
    selectedFleet,
    enu.ScreenType type,
  ) {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    fleet = selectedFleet;

    _assetService!.setUp();
    try {
      Logger()
          .i("asset choosen assetSerialNumber " + fleet!.assetSerialNumber!);
      Logger().i("asset choosen assetIdentifier " + fleet!.assetIdentifier!);
      //Logger().i("asset choosen assetId " + fleet!.assetId!);
    } catch (e) {
      Logger().e(e);
    }
    Future.delayed(Duration(seconds: 1), () {
      // if (type == enu.ScreenType.MAINTENANCE) {
      //   _assetDetail =
      //       AssetDetail.fromJson(dummyData["data"]["getSingleAssetDetails"]);
      //   _loading = false;
      //   notifyListeners();
      // } else {
      getAssetDetail();
      //}
    });
  }

  getAssetDetail() async {
    AssetDetail? assetDetail =
        await _assetService!.getAssetDetail(fleet!.assetIdentifier);
    _assetDetail = assetDetail;
    Logger().wtf(assetDetail!.assetSerialNumber);
    _loading = false;
    notifyListeners();
  }

  onServiceSelected(BuildContext ctx, int? serviceId, AssetData? assetDataValue,
      Fleet? assetData, List<Services?>? services, selectedService) async {
    _servicesData = services;
    ServiceItem? serviceItem;
    MaintenanceCheckListModel? serviceCheckList;
    if (isVisionLink) {
      serviceItem = await _maintenanceService!.getServiceItemCheckList(
        serviceId!,
      );
    } else {
      serviceCheckList = await _maintenanceService!
          .getMaintenanceServiceItemCheckList(
              query: graphqlSchemaService!
                  .getMaitenanceCheckList(serviceNo: serviceId));
    }
    showGeneralDialog(
        context: ctx,
        pageBuilder: (context, animation, secondaryAnimation) {
          return MainDetailPopupView(
              serviceItem: serviceCheckList!,
              summaryData: assetData!,
              parentContext: context,
              assetDataValue: assetDataValue,
              selectedService: selectedService,
              services: services!);
        });
  }
}

dynamic dummyData = {
  "data": {
    "getSingleAssetDetails": {
      "assetUid": "b70a2504-ddaa-11ec-82e6-06e3aab2a3b0",
      "assetSerialNumber": "TE000028",
      "assetId": "TE000028",
      "makeCode": "THC",
      "manufacturer": "TATA HITACHI",
      "model": "1650A",
      "assetIcon": 0,
      "productFamily": "Unassigned",
      "status": "Asset Off",
      "hourMeter": 403,
      "odometer": 12518.1,
      "lastReportedLocationLatitude": 16.7657183,
      "lastReportedLocationLongitude": 74.1400583,
      "lastReportedLocation": "Panhala, IN 416229, India",
      "lifetimeFuel": null,
      "lifetimeDEFLiters": null,
      "lastReportedTimeUtc": "2022-06-02T00:12:40",
      "lastLocationUpdateUtc": "2022-06-02T00:12:40",
      "fuelLevelLastReported": 90,
      "lastPercentFuelRemainingUtc": "2022-06-02T00:12:40",
      "lastLifetimeFuelLitersUTC": null,
      "fuelReportedTimeUtc": "2022-06-02T00:12:40",
      "customStateDescription": "IN_USE",
      "dealerName": "Tata Hitachi Corporate Office",
      "percentDEFRemaining": null,
      "lastPercentDEFRemainingUTC": null,
      "dealerCustomerNumber": null,
      "accountName": null,
      "universalCustomerIdentifier": null,
      "universalCustomerName": null,
      "devices": [
        {
          "deviceUid": "b70a2503-ddaa-11ec-82e6-06e3aab2a3b0",
          "deviceType": "SNM476",
          "deviceSerialNumber": "TE000028",
          "deviceState": "Subscribed",
          "isGpsRollOverAffected": false,
          "activeServicePlans": [
            {
              "serviceUid": "33a28916-5bdd-4f60-baba-09b408181ee8",
              "type": "Health"
            },
            {
              "serviceUid": "885287f5-359b-42a4-a66a-1410e8373881",
              "type": "Basic"
            },
            {
              "serviceUid": "e34e8059-a926-4300-af8e-3bfca21b5dbd",
              "type": "Utilization"
            },
            {
              "serviceUid": "f8c1d67d-f773-44f1-8db6-faa4cfb0dddf",
              "type": "Maintenance"
            }
          ]
        }
      ],
      "geofences": [],
      "groups": []
    }
  },
  "extensions": {
    "tracing": {
      "version": 1,
      "startTime": "2022-06-02T08:08:40.249Z",
      "endTime": "2022-06-02T08:08:41.841Z",
      "duration": 1592266440,
      "execution": {"resolvers": []}
    }
  }
};
