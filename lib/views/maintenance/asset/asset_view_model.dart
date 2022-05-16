import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/router_constants.dart';

import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/maintenance/asset/asset/detail_popup/detail_popup_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:insite/utils/enums.dart' as screen;

class AssetMaintenanceViewModel extends InsiteViewModel {
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();
  int page = 1;

  int limit = 20;

  int? _totalCount = 0;
  int? get totalCount => _totalCount;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  List<AssetCentricData> _assetData = [];
  List<AssetCentricData> get assetData => _assetData;

  List<dynamic> _maintenanceCount = [];
  List<dynamic> get maintenanceCount => _maintenanceCount;

  List<Services?> _services = [];
  List<Services?> get services => _services;

  List<String?> _servicesList = [];
  List<String?> get servicesList => _servicesList;

  AssetCentricData? _assetCentricData;
  AssetCentricData? get assetCentricData => _assetCentricData;

  late ScrollController scrollController;
  AssetMaintenanceViewModel() {
    setUp();
    // _faultService!.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      getAssetViewList();
      //getMaintenanceListItemData();
    });
  }

  getAssetViewList() async {
    Logger().d("getAssetViewList");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    MaintenanceAsset? result =
        await _maintenanceService?.getMaintenanceAssetData(
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            limit,
            page,
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));
    if (result != null && result.assetCentricData != null) {
      _totalCount = result.total!.toInt();

      if (result.assetCentricData!.isNotEmpty) {
        _assetData.addAll(result.assetCentricData!);
        for (var item in result.assetCentricData!) {
          _maintenanceCount.add(item.overDueCount);
        }

        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _assetData.addAll(result.assetCentricData!);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  refresh() async {
    await getSelectedFilterData();
    await getDateRangeFilterData();
    page = 1;

    if (_assetData.isEmpty) {
      _loading = true;
    } else {
      _refreshing = true;
    }
    _shouldLoadmore = true;
    notifyListeners();
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);

    MaintenanceAsset? result =
        await _maintenanceService?.getMaintenanceAssetData(
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            limit,
            page,
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));
    if (result != null) {
      _totalCount = result.total!.toInt();
      _assetData.clear();
      if (result.assetCentricData != null) {
        _assetData.addAll(result.assetCentricData!);
      }
      for (var item in _assetData) {
        _assetCentricData?.assetID = item.assetID;
      }
      _refreshing = false;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      _refreshing = false;
      notifyListeners();
    }
  }

  // getMaintenanceListItemData() async {
  //   Logger().wtf("sssssssssssssssssssssssssssssssss");
  //   await getSelectedFilterData();
  //   await getDateRangeFilterData();

  //   notifyListeners();
  //   Logger().d("start date " + startDate!);
  //   Logger().d("end date " + endDate!);

  //   MaintenanceListService? result =
  //       await _maintenanceService?.getMaintenanceServiceList(
  //           _assetCentricData!.assetUID,
  //           Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
  //           limit,
  //           page,
  //           Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));

  //   ;
  //   if (result != null && result.services != null) {
  //     if (result.services!.isNotEmpty) {
  //       _services.addAll(result.services!);
  //       Logger().i("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${result.services}");
  //       for (var item in result.services!) {
  //         _servicesList.add(item.serviceName);
  //       }
  //       _refreshing = false;
  //       _loadingMore = false;
  //       notifyListeners();
  //     } else {
  //       _services.addAll(result.services!);
  //       for (var item in result.services!) {
  //         _servicesList.add(item.serviceName);
  //       }
  //       _refreshing = false;
  //       _loadingMore = false;
  //       _shouldLoadmore = false;
  //       notifyListeners();
  //     }
  //   } else {
  //     _refreshing = false;
  //     notifyListeners();
  //   }
  //   _loaded = true;
  //   notifyListeners();
  // }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      Logger().i("load more called");
      page++;
      _loadingMore = true;
      notifyListeners();
      getAssetViewList();
    }
  }

  onDetailPageSelected(AssetCentricData assetCentricData) async {
    ServiceItem? serviceItem = await _maintenanceService!
        .getServiceItemCheckList(assetCentricData.serviceId);
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: assetCentricData.assetSerialNumber,
            assetId: assetCentricData.assetID,
            assetIdentifier: assetCentricData.assetUID,
          ),
          type: screen.ScreenType.MAINTENANCE,
          index: 1),
    );
  }

  onServiceSelected(num? serviceId, AssetData? assetDataValue,
      AssetCentricData? assetData, List<Services?>? services) async {
    ServiceItem? serviceItem =
        await _maintenanceService!.getServiceItemCheckList(serviceId!);
    _navigationService!.navigateToView(
      DetailPopupView(
          serviceItem: serviceItem!,
          assetData: assetData!,
          assetDataValue: assetDataValue,
          services: services!),
    );
  }
}
