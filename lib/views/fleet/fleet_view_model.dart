import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class FleetViewModel extends InsiteViewModel {
  FleetService? _fleetService = locator<FleetService>();
  NavigationService? _navigationService = locator<NavigationService>();

  int pageNumber = 1;
  int pageSize = 20;
  ScrollController? scrollController;

  List<Fleet> _assets = [];
  List<Fleet> get assets => _assets;

  int _totalCount = 0;
  int get totalCount => _totalCount;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FleetViewModel() {
    _fleetService!.setUp();
    setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (_totalCount == _assets.length) {
        } else {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 0), () async {
      await getSelectedFilterData();
      await getDateRangeFilterData();
    });
    Future.delayed(Duration(seconds: 1), () async {
      await getFleetSummaryList();
    });
  }

  getFleetSummaryList() async {
    try {
      FleetSummaryResponse? result;
      if (appliedFilters!
          .any((element) => element!.type == FilterType.IDLING_LEVEL)) {
        result = await _fleetService!.getFleetSummaryList(
            Utils.getIdlingFleetDateParse(startDate),
            Utils.getIdlingDateParse(endDate),
            pageSize,
            pageNumber,
            appliedFilters);
      } else {
        result = await _fleetService!
            .getFleetSummaryList("", "", pageSize, pageNumber, appliedFilters);
      }

      if (result != null) {
        if (result.pagination?.totalCount != null) {
          _totalCount = result.pagination!.totalCount!.toInt();
        }
        if (result.fleetRecords != null && result.fleetRecords!.isNotEmpty) {
          Logger()
              .i("list of assets " + result.fleetRecords!.length.toString());
          _assets.addAll(result.fleetRecords!);
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _assets.addAll(result.fleetRecords!);
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
    } catch (e) {
      //Logger().e(e.toString());
      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;
      notifyListeners();
    }
  }

  onDetailPageSelected(Fleet? fleet) {
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
        fleet: fleet,
        index: 0,
      ),
       
     
    );
  }

  onHomeSelected() {
    _navigationService!.replaceWith(homeViewRoute);
  }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !_isRefreshing) {
      Logger().i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getFleetSummaryList();
    }
  }

  void refresh() async {
    try {
      Logger().e("fleet filter applied");
      FleetSummaryResponse? result;
      await getSelectedFilterData();
      pageNumber = 1;
      pageSize = 20;
      _isRefreshing = true;
      _shouldLoadmore = true;
      notifyListeners();
      if (appliedFilters!
          .any((element) => element!.type == FilterType.IDLING_LEVEL)) {
        result = await _fleetService!.getFleetSummaryList(
            Utils.getIdlingFleetDateParse(startDate),
            Utils.getIdlingDateParse(endDate),
            pageSize,
            pageNumber,
            appliedFilters);
      } else {
        result = await _fleetService!
            .getFleetSummaryList("", "", pageSize, pageNumber, appliedFilters);
      }

      if (result != null &&
          result.fleetRecords != null &&
          result.fleetRecords!.isNotEmpty) {
        if (result.pagination!.totalCount != null) {
          _totalCount = result.pagination!.totalCount!.toInt();
        }
        _assets.clear();
        _assets.addAll(result.fleetRecords!);
        _isRefreshing = false;
        notifyListeners();
      } else {
        _isRefreshing = false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
      _assets.clear();
      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;
      _totalCount = 0;
      notifyListeners();
    }
  }
}
