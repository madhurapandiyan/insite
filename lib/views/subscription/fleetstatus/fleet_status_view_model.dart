import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_fleet_graphql.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:logger/logger.dart';

class FleetStatusViewModel extends InsiteViewModel {
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

  FleetStatusViewModel() {
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
      getFleetStatusData();
    });
  }
  late Logger log;
  SubscriptionDashboardDetailResult? subscriptionDashboardDetailResult;
  FleetProvisionStatus? fleetProvisionStatus;

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !_refreshing) {
      log.i("load more called");
      _loadingMore = true;
      notifyListeners();
      getFleetStatusData();
    }
  }

  getFleetStatusData() async {
    if (enableGraphQl) {
      Logger().i("getFleetStatusData");
      fleetProvisionStatus = await _subscriptionService!.getFleetDataGraphql(
          graphqlSchemaService!.getSubscriptionFleetData(start, limit));

      if (fleetProvisionStatus != null) {
        if (fleetProvisionStatus!.fleetProvisionStatusInfo!.isNotEmpty) {
          start = start + limit;
          devices.addAll(fleetProvisionStatus!.fleetProvisionStatusInfo!);
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
    } else {
      Logger().i("getFleetStatusData");
      subscriptionDashboardDetailResult =
          await _subscriptionService!.getFleetStatusData(
        start: start == 0 ? start : start + 1,
        limit: limit,
      );

      if (subscriptionDashboardDetailResult != null) {
        if (subscriptionDashboardDetailResult!.result!.isNotEmpty) {
          start = start + limit;
          devices.addAll(subscriptionDashboardDetailResult!.result![1]);
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
  }

  int start = 0;
  int limit = 50;

  List<dynamic> _devices = [];
  List<dynamic> get devices => _devices;
}
