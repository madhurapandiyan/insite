import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/views/maintenance/main/main_detail_popup/main_detail_popup_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

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
      getAssetDetail();
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

  onServiceSelected(num? serviceId, AssetData? assetDataValue,
      SummaryData? assetData, List<Services?>? services) async {
    _servicesData = services;
    ServiceItem? serviceItem =
        await _maintenanceService!.getServiceItemCheckList(serviceId!);

    _navigationService!.navigateToView(
      MainDetailPopupView(
          serviceItem: serviceItem!,
          summaryData: assetData!,
          assetDataValue: assetDataValue,
          services: services!),
    );
  }
}
