import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SubDashBoardDetailsViewModel extends InsiteViewModel {
  Logger log;
  var _subscriptionService = locator<SubScriptionService>();
  ScrollController scrollController;

  String _filter;
  String get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE get filterType => _filterType;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  int start = 0;
  int limit = 50;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  SubDashBoardDetailsViewModel(
      String filterKey, PLANTSUBSCRIPTIONFILTERTYPE type) {
    this._filter = filterKey;
    this._filterType = type;
    this.log = getLogger(this.runtimeType.toString());
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getSubcriptionDeviceListData();
    });
  }

  getSubcriptionDeviceListData() async {
    SubscriptionDashboardDetailResult result =
        await _subscriptionService.getSubscriptionDevicesListData(
      fitler: filter,
      start: start + 1,
      limit: limit,
      filterType: filterType,
    );

    if (result != null) {
      if (result.result.isNotEmpty) {
        start = start + limit;
        devices.addAll(result.result[1]);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
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
      _loadingMore = true;
      notifyListeners();
      getSubcriptionDeviceListData();
    }
  }

  void navigateToDetails() {}
}
