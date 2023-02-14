import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/plant_hierarcy_details.dart';
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

  int _totalCount = 0;
  int get totalCount => _totalCount;

  bool _loading = true;
  bool get loading => _loading;

  bool _isDetailLoading = true;
  bool get isDetailLoading => _isDetailLoading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  int start = 0;
  int limit = 100;
  int? changingIndex = 0;
  int? plantListCount = 0;

  SubscriptionDashboardDetailResult? result;
  List<DetailResult> assetDetailList = [];
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
        if (_totalCount == plantListCount) {
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
      _totalCount = result!.assetOrHierarchyByTypeAndId!.length;
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
        _totalCount = result!.subscriptionFleetList!.count!;
      } else if (filter == "day" || filter == "week" || filter == "month") {
        result = await _subscriptionService!.getSubscriptionDeviceListData(
            filter: filter,
            start: start,
            limit: limit,
            filterType: filterType,
            query: graphqlSchemaService!.getPlantDashboardAndHierarchyListData(
                limit: limit, start: start, calendar: filter));
        _totalCount = result!.subscriptionFleetList!.count!;
      } else {
        result = await _subscriptionService!.getSubscriptionDeviceListData(
            filter: filter,
            start: start,
            limit: limit,
            filterType: filterType,
            query: graphqlSchemaService!.getPlantDashboardAndHierarchyListData(
                limit: limit, start: start, model: filter));
        _totalCount = result!.result!.length;
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
          plantListCount = devices.length;
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
              plantListCount = devices.length;
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
              plantListCount = devices.length;
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
        plantListCount = devices.length;
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
      start = start + 100;
      Logger().wtf("start:$start");
      notifyListeners();
      getSubcriptionDeviceListData();
    }
  }

  onPageChange(int value) {
    changingIndex = value;
    notifyListeners();
  }

  String? getDetailName() {
    if (type == PLANTSUBSCRIPTIONDETAILTYPE.PLANT) {
      _filter = "Plant";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.CUSTOMER) {
      _filter = "Customer";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEALER) {
      _filter = "Dealer";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEVICE) {
      _filter = "Plant";
    }
    return _filter;
  }

  void navigateToDetails(int index) async {
    plantListCount = 0;
    _totalCount = 0;

    if (type == PLANTSUBSCRIPTIONDETAILTYPE.PLANT) {
      _filter = "PLANT";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.CUSTOMER) {
      _filter = "CUSTOMER";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEALER) {
      _filter = "DEALER";
    } else if (type == PLANTSUBSCRIPTIONDETAILTYPE.DEVICE) {
      _filter = "asset";
    }
    var assetId;

    for (int i = 0; i < result!.assetOrHierarchyByTypeAndId!.length; i++) {
      var assetDetail = result?.assetOrHierarchyByTypeAndId![i];
      if (i == index) assetId = assetDetail!.id;
    }

    PlantHierarchyDetails? dataDetails =
        await _subscriptionService!.getHierarcyDetail(payload: {
      "id": int.parse(assetId.toString()),
      "start": start,
      "limit": limit,
      "type": _filter
    });
    _isDetailLoading = false;

    _totalCount = dataDetails!.assetOrHierarchyByTypeAndIdDetail!.length;
    Logger().wtf("dataDetails:${dataDetails.toJson()}");
    if (dataDetails.assetOrHierarchyByTypeAndIdDetail != null &&
        dataDetails.assetOrHierarchyByTypeAndIdDetail!.isNotEmpty) {
      var hierarcyitem = dataDetails.assetOrHierarchyByTypeAndIdDetail;
      hierarcyitem!.forEach((element) {
        assetDetailList.add(DetailResult(
            name: element.name,
            model: element.model,
            vin: element.vin,
            gpsDeviceId: element.gpsDeviceId,
            actualStartDate: element.actualStartDate,
            subscriptionStartDate: element.subscriptionStartDate,
            subscriptionEndDate: element.subscriptionEndDate,
            productFamily: element.productFamily));
      });

      plantListCount = assetDetailList.length;
      Logger().wtf("loading:$_loading");
    } else {
      _isDetailLoading = false;
      notifyListeners();
    }

    notifyListeners();
  }
}
