import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:flutter/material.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AssetListViewModel extends InsiteViewModel {
  Logger log;
  var _assetService = locator<AssetService>();
  var _navigationService = locator<NavigationService>();
  List<Asset> _assets = [];
  List<Asset> get assets => _assets;

  bool _loading = true;
  bool get loading => _loading;

  int pageNumber = 1;
  int pageSize = 50;
  ScrollController scrollController;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  String _menuItem = "assetid";
  set menuItem(String menuItem) {
    this._menuItem = menuItem;
  }

  List<DateTime> days = [];

  void updateDateRangeList() {
    try {
      DateTime startTime = DateTime.parse(startDate);
      DateTime endTime = DateTime.parse(endDate);
      final daysToGenerate = endTime.difference(startTime).inDays + 1;
      days = List.generate(
          daysToGenerate,
          (i) =>
              DateTime(startTime.year, startTime.month, startTime.day + (i)));
    } catch (e) {
      Logger().e(e);
    }
  }

  AssetListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService.setUp();
    setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    updateDateRangeList();
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
    });
    Future.delayed(Duration(seconds: 2), () {
      getAssetSummaryList();
    });
  }

  void refresh() async {
    await getSelectedFilterData();
    await getDateRangeFilterData();
    pageNumber = 1;
    pageSize = 50;
    _refreshing = true;
    notifyListeners();
    Logger().d("start date " + startDate);
    Logger().d("end date " + endDate);
    List<Asset> result = await _assetService.getAssetSummaryList(
        startDate, endDate, pageSize, pageNumber, _menuItem, appliedFilters);
    if (result != null) {
      _assets.clear();
      _assets.addAll(result);
      _refreshing = false;
      notifyListeners();
    }
    Logger().i("list of assets " + result.length.toString());
  }

  getAssetSummaryList() async {
    Logger().d("start date " + startDate);
    Logger().d("end date " + endDate);
    List<Asset> result = await _assetService.getAssetSummaryList(
        startDate, endDate, pageSize, pageNumber, _menuItem, appliedFilters);
    if (result != null) {
      if (result.isNotEmpty) {
        Logger().i("list of assets " + result.length.toString());
        _assets.addAll(result);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _assets.addAll(result);
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

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !_refreshing) {
      log.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getAssetSummaryList();
    }
  }

  onDetailPageSelected(Asset asset) {
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            fleet: Fleet(
                assetSerialNumber: asset.serialNumber,
                assetId: asset.assetId,
                assetIdentifier: asset.assetUid)));
  }
}
