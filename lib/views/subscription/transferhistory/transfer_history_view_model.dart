import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/views/subscription/transferhistory/model/tranfer_history.dart';
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
  int totalCount = 0;

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
    int startCount = 1;
    int endLimit = 100;
    if (enableGraphQl) {
      TranferHistory? transferHistory = await _subscriptionService!
          .getDeviceTranferHistory(
              graphqlSchemaService!.getTranferHistory(startCount, endLimit));

      if (transferHistory != null) {
        totalCount = transferHistory.deviceTransfer!.length;
        Logger().wtf("totalCount:$totalCount");
        if (transferHistory.deviceTransfer != null) {
          for (DeviceTransfer element in transferHistory.deviceTransfer!) {
            devices.add(DetailResult(
              gpsDeviceId: element.gpsDeviceId,
              oemName: element.oemName,
              status: element.status,
              destinationCustomerType: element.destinationCustomerType,
              destinationName1: element.destinationName1,
              destinationName2: element.destinationName2,
              sourceCustomerType: element.sourceCustomerType,
              fkAssetId: element.fkAssetId,
              insertUtc: element.insertUtc,
              sourceName1: element.sourceName1,
              sourceName2: element.sourceName2,
              vin: element.vin,
            ));
          }
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        }
      } else {
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      }
    } else {
      Logger().i("getTransferHistoryViewData");
      SubscriptionDashboardDetailResult?
          subscriptionDashboardDetailResultresult =
          await _subscriptionService!.getTransferHistoryViewData(
        start: start == 0 ? start : start + 1,
        limit: limit,
      );

      if (subscriptionDashboardDetailResultresult != null) {
        totalCount =
            subscriptionDashboardDetailResultresult.result!.last.last.count!;

        Logger().wtf("totalCount:$totalCount");
        if (subscriptionDashboardDetailResultresult.result!.isNotEmpty) {
          start = start + limit;
          devices.addAll(subscriptionDashboardDetailResultresult.result![0]);
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
