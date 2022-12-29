import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
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
  int limit = 100;

  SubscriptionDashboardDetailResult? result;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  PLANTSUBSCRIPTIONDETAILTYPE type;

  SubDashBoardDetailsViewModel(String? filterKey, this.type, this._filterType) {
    this._filter = filterKey;

    this.log = getLogger(this.runtimeType.toString());
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (result!.subscriptionFleetList!.provisioningInfo!.isEmpty) {
        } else {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getSubcriptionDeviceListData();
    });
  }

  getSubcriptionDeviceListData() async {
    Logger().w(type);
    // if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEVICE &&
    //     _filterType == PLANTSUBSCRIPTIONFILTERTYPE.TYPE) {
    if (type == PLANTSUBSCRIPTIONDETAILTYPE.PLANT ||
        type == PLANTSUBSCRIPTIONDETAILTYPE.CUSTOMER ||
        type == PLANTSUBSCRIPTIONDETAILTYPE.DEALER ||
        type == PLANTSUBSCRIPTIONDETAILTYPE.PLANT ||
        type == PLANTSUBSCRIPTIONDETAILTYPE.ASSET) {
      result = await _subscriptionService!.getSubscriptionDeviceListData(
          filter: filter,
          start: start,
          limit: limit,
          filterType: filterType,
          query:
              graphqlSchemaService!.getHierarchyListData(start, limit, filter));
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEVICE ||
        type == PLANTSUBSCRIPTIONDETAILTYPE.TOBEACTIVATED) {
      if (filter == "active" ||
          filter == "inactive" ||
          filter == "subscriptionendasset" ||
          filter == "total" ||
          filter == "plantasset" ||
          filter == "subscriptionendasset") {
        result = await _subscriptionService!.getSubscriptionDeviceListData(
            filter: filter,
            start: start,
            limit: limit,
            filterType: filterType,
            query: graphqlSchemaService!.getPlantDashboardAndHierarchyListData(
              limit: limit,
              start: start,
              status: filter,
            ));
      } else if (filter == "day" || filter == "week" || filter == "month") {
        result = await _subscriptionService!.getSubscriptionDeviceListData(
            filter: filter,
            start: start,
            limit: limit,
            filterType: filterType,
            query: graphqlSchemaService!.getPlantDashboardAndHierarchyListData(
                limit: limit, start: start, calendar: filter));
      } else {
        result = await _subscriptionService!.getSubscriptionDeviceListData(
            filter: filter,
            start: start,
            limit: limit,
            filterType: filterType,
            query: graphqlSchemaService!.getPlantDashboardAndHierarchyListData(
                limit: limit, start: start, model: filter));
      }
    }
   

    if (enableGraphQl) {
      Logger().wtf(filter);
      if (filter == "CUSTOMER" ||
          filter == "PLANT" ||
          filter == "DEALER" ||
          filter == "asset") {
        for (int i = 0; i < result!.assetOrHierarchyByTypeAndId!.length; i++) {
          var items = result!.assetOrHierarchyByTypeAndId![i];
          DetailResult fleetListData = DetailResult(
            name: items.name,
            userName: items.userName,
            code: items.code,
            email: items.email,
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
          if (result!.subscriptionFleetList != null &&
              result!.subscriptionFleetList!.provisioningInfo!.isNotEmpty) {
            Logger().i(result!.subscriptionFleetList!.provisioningInfo!.first
                .subscriptionStartDate);

            for (var i = 0;
                i < result!.subscriptionFleetList!.provisioningInfo!.length;
                i++) {
              var items = result!.subscriptionFleetList!.provisioningInfo![i];
              DetailResult fleetListData = DetailResult(
                  gpsDeviceId: items.gpsDeviceID,
                  vin: items.vin,
                  model: items.model,
                  productFamily: items.productFamily,
                  networkProvider: items.networkProvider,
                  dealerName: items.dealerName,
                  dealerCode: items.dealerCode,
                  customerName: items.customerName,
                  customerCode: items.customerCode,
                  status: items.status,
                  description: items.description,
                  actualStartDate: items.actualStartDate,
                  subscriptionEndDate: items.subscriptionEndDate,
                  subscriptionStartDate: items.subscriptionStartDate);
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
        } else {
          if (result!.subscriptionFleetList != null &&
              result!.subscriptionFleetList!.provisioningInfo!.isNotEmpty) {
            Logger().i(result!.subscriptionFleetList!.provisioningInfo!.first
                .toJson());

            for (var i = 0;
                i < result!.subscriptionFleetList!.provisioningInfo!.length;
                i++) {
              var items = result!.subscriptionFleetList!.provisioningInfo![i];
              DetailResult fleetListData = DetailResult(
                  subscriptionStartDate: items.subscriptionStartDate,
                  actualStartDate: items.actualStartDate,
                  subscriptionEndDate: items.subscriptionEndDate,
                  gpsDeviceId: items.gpsDeviceID,
                  vin: items.vin,
                  model: items.model,
                  productFamily: items.productFamily,
                  networkProvider: items.networkProvider,
                  dealerName: items.dealerName,
                  dealerCode: items.dealerCode,
                  customerName: items.customerName,
                  customerCode: items.customerCode,
                  status: items.status,
                  description: items.description);
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
      start++;

      notifyListeners();
      getSubcriptionDeviceListData();
    }
  }

  void navigateToDetails() {}
}
