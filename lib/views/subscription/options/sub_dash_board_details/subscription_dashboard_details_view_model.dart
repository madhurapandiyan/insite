import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SubDashBoardDetailsViewModel extends InsiteViewModel {
  late Logger log;
  SubScriptionService? _subscriptionService = locator<SubScriptionService>();
  ScrollController? scrollController;

  String? _filter;
  String? get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE? _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE? get filterType => _filterType;

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

  SubscriptionDashboardDetailResult? result;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  SubDashBoardDetailsViewModel(
      String? filterKey, PLANTSUBSCRIPTIONFILTERTYPE? type) {
    this._filter = filterKey;
    this._filterType = type;
    this.log = getLogger(this.runtimeType.toString());
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getSubcriptionDeviceListData();
    });
  }

  getSubcriptionDeviceListData() async {
    result = await _subscriptionService!.getSubscriptionDeviceListData(
        filter: filter,
        start: start == 0 ? start : start + 1,
        limit: limit,
        filterType: filterType,
        query:
            graphqlSchemaService!.getHierarchyListData(start, limit, filter));
    if (!enableGraphQl) {
      if (filter == "CUSTOMER" ||
          filter == "PLANT" ||
          filter == "DEALER" ||
          filter == "asset") {
        Logger().i(result!.assetOrHierarchyByTypeAndId!.first.toJson());
        for (int i = 0; i < result!.assetOrHierarchyByTypeAndId!.length; i++) {
          var items = result!.assetOrHierarchyByTypeAndId![i];
          DetailResult fleetListData = DetailResult(
            Name: items.name,
            UserName: items.userName,
            Code: items.code,
            Email: items.email,
          );
          devices.add(fleetListData);
        }
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        if (filter == "active" ||
            filter == "inactive" ||
            filter == "subscriptionendasset") {
          result = await _subscriptionService!.getSubscriptionDeviceListData(
              filter: filter,
              start: start == 0 ? start : start + 1,
              limit: limit,
              filterType: filterType,
              query: graphqlSchemaService!
                  .getPlantDashboardAndHierarchyListData(limit, start, filter));
          if (result!.subscriptionFleetList != null) {
            Logger().i(result!.subscriptionFleetList!.provisioningInfo!.first
                .toJson());
            start = start + limit;
            devices.clear();
            for (var i = 0;
                i < result!.subscriptionFleetList!.provisioningInfo!.length;
                i++) {
              var items = result!.subscriptionFleetList!.provisioningInfo![i];
              DetailResult fleetListData = DetailResult(
                  GPSDeviceID: items.gpsDeviceID,
                  VIN: items.vin,
                  Model: items.model,
                  ProductFamily: items.productFamily,
                  NetworkProvider: items.networkProvider,
                  DealerName: items.dealerName,
                  DealerCode: items.dealerCode,
                  CustomerName: items.customerName,
                  CustomerCode: items.customerCode,
                  Status: items.status,
                  Description: items.description);
              devices.add(fleetListData);
            }
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
        } else {
          result = await _subscriptionService!.getSubscriptionDeviceListData(
              filter: filter,
              start: start == 0 ? start : start + 1,
              limit: limit,
              filterType: filterType,
              query: graphqlSchemaService!
                  .getPlantDashboardAndHierarchyCalendarListData(
                      limit, start, filter));
          if (result!.subscriptionFleetList != null) {
            Logger().i(result!.subscriptionFleetList!.provisioningInfo!.first
                .toJson());
            start = start + limit;
            devices.clear();
            for (var i = 0;
                i < result!.subscriptionFleetList!.provisioningInfo!.length;
                i++) {
              var items = result!.subscriptionFleetList!.provisioningInfo![i];
              DetailResult fleetListData = DetailResult(
                  GPSDeviceID: items.gpsDeviceID,
                  VIN: items.vin,
                  Model: items.model,
                  ProductFamily: items.productFamily,
                  NetworkProvider: items.networkProvider,
                  DealerName: items.dealerName,
                  DealerCode: items.dealerCode,
                  CustomerName: items.customerName,
                  CustomerCode: items.customerCode,
                  Status: items.status,
                  Description: items.description);
              devices.add(fleetListData);
            }
            _loading = false;
            _loadingMore = false;
            notifyListeners();
          } else {
            _loading = false;
            _loadingMore = false;
            _shouldLoadmore = false;
            notifyListeners();
          }
        }
      }
    } else {
      if (result!.result!.isNotEmpty) {
        start = start + limit;
        devices.addAll(result!.result![1]);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
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
      getSubcriptionDeviceListData();
    }
  }

  void navigateToDetails() {}
}
