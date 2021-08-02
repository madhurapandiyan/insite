import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AssetViewModel extends InsiteViewModel {
  var _faultService = locator<FaultService>();
  var _navigationService = locator<NavigationService>();

  int pageNumber = 1;
  int pageSize = 50;
  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  List<Fault> _faults = [];
  List<Fault> get faults => _faults;

  ScrollController scrollController;
  AssetViewModel() {
    setUp();
    _faultService.setUp();
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
    AssetFaultSummaryResponse result =
        await _faultService.getAssetViewSummaryList("2021-08-01T18:30:00Z",
            "2021-08-02T18:29:59Z", pageSize, pageNumber, appliedFilters);
    if (result != null) {
      if (result.faults.isNotEmpty) {
        _faults.addAll(result.faults);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _faults.addAll(result.faults);
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
    Logger().d("refresh getFaultViewList");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    pageNumber = 1;
    pageSize = 50;
    _refreshing = true;
    _shouldLoadmore = true;
    notifyListeners();
    Logger().d("start date " + startDate);
    Logger().d("end date " + endDate);
    AssetFaultSummaryResponse result =
        await _faultService.getAssetViewSummaryList("2021-08-01T18:30:00Z",
            "2021-08-02T18:29:59Z", pageSize, pageNumber, appliedFilters);
    if (result != null) {
      _faults.clear();
      _faults.addAll(result.faults);
      _refreshing = false;
      notifyListeners();
    } else {
      _refreshing = false;
      notifyListeners();
    }
    Logger().i("list of _faults " + _faults.length.toString());
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
      getAssetViewList();
    }
  }

  onDetailPageSelected(Fault fleet) {
    _navigationService.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: fleet.asset.uid,
            assetId: fleet.asset.uid,
            assetIdentifier: fleet.asset.uid,
          ),
          index: 1),
    );
  }
}
