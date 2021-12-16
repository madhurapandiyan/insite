import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:logger/logger.dart';

class TransferHistoryViewModel extends InsiteViewModel {
  bool _loading = true;
  bool get loading => _loading;

  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  bool _showDownload = false;
  bool get showDownload => _showDownload;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;
  ScrollController? scrollController;

  int start = 0;
  int limit = 50;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  TransferHistoryViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      getTransferHistoryViewData();
    });
  }

  getTransferHistoryViewData() async {
    Logger().i("getTransferHistoryViewData");
    SubscriptionDashboardDetailResult? result =
        await _subscriptionService!.getTransferHistoryViewData(
      start: start == 0 ? start : start + 1,
      limit: limit,
    );
    if (result != null) {
      if (result.result!.isNotEmpty) {
        start = start + limit;
        devices.addAll(result.result![0]);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
      Logger().i("getTransferHistoryViewData length ${devices.length}");
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
      getTransferHistoryViewData();
    }
  }

  late Logger log;
}
