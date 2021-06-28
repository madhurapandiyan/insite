import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class FleetViewModel extends InsiteViewModel {
  var _fleetService = locator<FleetService>();
  var _navigationService = locator<NavigationService>();

  Logger log;

  int pageNumber = 1;
  int pageSize = 50;
  ScrollController scrollController;

  List<Fleet> _assets = [];
  List<Fleet> get assets => _assets;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FleetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _fleetService.setUp();
    setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
    });
    Future.delayed(Duration(seconds: 2), () {
      getFleetSummaryList();
    });
  }

  getFleetSummaryList() async {
    List<Fleet> result = await _fleetService.getFleetSummaryList(
        pageSize, pageNumber, appliedFilters);
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

  onDetailPageSelected(Fleet fleet) {
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(fleet: fleet, index: 0));
  }

  onHomeSelected() {
    _navigationService.replaceWith(dashboardViewRoute);
  }

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !_isRefreshing) {
      log.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getFleetSummaryList();
    }
  }

  void refresh() async {
    await getSelectedFilterData();
    pageNumber = 1;
    pageSize = 50;
    _isRefreshing = true;
    _shouldLoadmore = true;
    notifyListeners();
    List<Fleet> result = await _fleetService.getFleetSummaryList(
        pageSize, pageNumber, appliedFilters);
    if (result != null && result.isNotEmpty) {
      _assets.clear();
      _assets.addAll(result);
      _isRefreshing = false;
      notifyListeners();
    } else {
      _isRefreshing = false;
      notifyListeners();
    }
    Logger().i("list of assets " + result.length.toString());
  }
}
