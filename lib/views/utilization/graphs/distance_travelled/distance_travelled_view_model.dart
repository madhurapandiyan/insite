import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class DistanceTravelledViewModel extends InsiteViewModel {
  Logger log;
  var _utilizationService = locator<AssetUtilizationService>();

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  int pageNumber = 1;
  int pageCount = 50;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool _update = false;
  bool get update => _update;

  ScrollController scrollController;

  DistanceTravelledViewModel() {
    _utilizationService.setUp();
    this.log = getLogger(this.runtimeType.toString());
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    getUtilization();
  }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      Logger().i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getUtilization();
    }
  }

  getUtilization() async {
    Logger().d("getUtilization");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    Utilization result = await _utilizationService.getUtilizationResult(
        startDate,
        endDate,
        '-RuntimeHours',
        pageNumber,
        pageCount,
        appliedFilters);
    if (result != null) {
      if (result.assetResults.isNotEmpty) {
        _utilLizationListData.addAll(result.assetResults);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _utilLizationListData.addAll(result.assetResults);
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
    _update = true;
    notifyListeners();
  }

  refresh() async {
    Logger().d("idle percent working view refreshing ");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    pageNumber = 1;
    pageCount = 50;
    _isRefreshing = true;
    notifyListeners();
    Utilization result = await _utilizationService.getUtilizationResult(
        startDate,
        endDate,
        '-RuntimeHours',
        pageNumber,
        pageCount,
        appliedFilters);
    if (result != null &&
        result.assetResults != null &&
        result.assetResults.isNotEmpty) {
      _utilLizationListData.clear();
      _utilLizationListData.addAll(result.assetResults);
      _isRefreshing = false;
      notifyListeners();
    } else {
      _isRefreshing = false;
      notifyListeners();
    }
    _update = true;
    notifyListeners();
  }

  updateCountToFalse() {
    _update = false;
    notifyListeners();
  }
}
