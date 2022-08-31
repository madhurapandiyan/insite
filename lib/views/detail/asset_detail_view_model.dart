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

  List<String> popupList = ["Add/Manage Intervals"];
  String? initialValue;

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
      Logger().i(fleet!.assetIdentifier);
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

  onPopupSelected(String value) {
    initialValue = value;
    notifyListeners();
  }

  getAssetDetail() async {
    AssetDetail? assetDetail =
        await _assetService!.getAssetDetail(fleet!.assetIdentifier);
    _assetDetail = assetDetail;
    Logger().wtf(assetDetail!.assetSerialNumber);
    _loading = false;
    notifyListeners();
  }

  onServiceSelected({
    BuildContext? ctx,
    int? serviceId,
    AssetData? assetDataValue,
  }) async {
    showDialog(
        context: ctx!,
        builder: (context) {
          return MainDetailPopupView(
            parentContext: context,
            serviceNo: serviceId,
            assetDataValue: assetDataValue,
          );
        });
  }
}
