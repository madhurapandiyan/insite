import 'dart:async';

import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/plant_hierachy_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_dash_board_details/subscription_dashboard_details_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PlantHierachyViewModel extends InsiteViewModel {
  Logger? log;

  PlantHeirarchyAssetService? _plantHierarchyService =
      locator<PlantHeirarchyAssetService>();
  LocalService? _localService = locator<LocalService>();
  NavigationService? _navigationService = locator<NavigationService>();

  bool _loading = true;
  bool get loading => _loading;

  List<String> _assetType = [];
  List<String> get assetType => _assetType;

  List<String> _filterType = [];
  List<String> get filterType => _filterType;

  List<int?> _assetCount = [];
  List<int?> get assetCount => _assetCount;

  PlantHierachyViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _plantHierarchyService!.setUp();
    _localService!.getToken();
    Future.delayed(Duration(seconds: 2), () {
      getPlantHeirrchyAssetData();
    });
  }

  getPlantHeirrchyAssetData() async {
    try {
      HierarchyAssets? assetsData = await (_plantHierarchyService!
          .getResultsFromPlantHierchyApi(
              graphqlSchemaService!.getHierarchyData()));

      if (enableGraphQl) {
        _assetType
            .addAll(["Customer", "Dealer", "Plant", "Total no. of Assets"]);
        _filterType.addAll(["CUSTOMER", "DEALER", "PLANT", "asset"]);
        _assetCount.addAll([
          assetsData!.plantHierarchyDetails!.totalCustomerCount,
          assetsData.plantHierarchyDetails!.totalDealerCount,
          assetsData.plantHierarchyDetails!.totalPlantCount,
          assetsData.plantHierarchyDetails!.totalAssetCount
        ]);
      } else {
        _assetType
            .addAll(["Customer", "Dealer", "Plant", "Total no. of Assets"]);
        _filterType.addAll(["CUSTOMER", "DEALER", "PLANT", "asset"]);

        final customerCount = assetsData!.result![0][0].customerCount;
        final dealerCount = assetsData.result![0][0].dealerCount;
        final plantCount = assetsData.result![0][0].plantCount;
        final totalAssets = assetsData.result![1][0].totalAssets;
        _assetCount
            .addAll([customerCount, dealerCount, plantCount, totalAssets]);
      }

      _loading = false;
    } catch (e) {
      Logger().e(e.toString());
      _loading = false;
    }
    notifyListeners();
  }

  gotoDetailsPage(String filter) {
    Logger().i("gotoDetailsPage $filter");
    var detailsType = PLANTSUBSCRIPTIONDETAILTYPE.DEVICE;
    if (filter == "CUSTOMER") {
      detailsType = PLANTSUBSCRIPTIONDETAILTYPE.CUSTOMER;
    } else if (filter == "DEALER") {
      detailsType = PLANTSUBSCRIPTIONDETAILTYPE.DEALER;
    } else if (filter == "PLANT") {
      detailsType = PLANTSUBSCRIPTIONDETAILTYPE.PLANT;
    } else if (filter == "asset") {
      detailsType = PLANTSUBSCRIPTIONDETAILTYPE.ASSET;
    }
    _navigationService!.navigateToView(SubDashBoardDetailsView(
      filterKey: filter,
      detailType: detailsType,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
    ));
  }
}
