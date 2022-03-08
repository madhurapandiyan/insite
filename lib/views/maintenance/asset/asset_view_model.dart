import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:insite/utils/enums.dart' as screen;

class AssetMaintenanceViewModel extends InsiteViewModel {
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();
  int page = 1;

  int limit = 40;

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

  onDetailPageSelected(AssetCentricData assetCentricData) {
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
}
