import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart' as service;

class FaultViewModel extends InsiteViewModel {
  FaultService? _faultService = locator<FaultService>();
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();

  int pageNumber = 1;
  int pageSize = 20;

  int? _totalCount = 0;
  int? get totalCount => _totalCount;

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

  List<Devices> _device = [];
  List<Devices> get device => _device;

  late ScrollController scrollController;

  FaultViewModel() {
    setUp();
    _faultService!.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (faults.length != totalCount) {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 2), () async {
      await getFaultViewList();
    });
  }

  getFaultViewList() async {
    Logger().d("getFaultViewList");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    // Logger().d("start date " + startDate!);
    // Logger().d("end date " + endDate!);
    FaultSummaryResponse? result = await _faultService!.getFaultSummaryList(
        Utils.getDateInFormatyyyyMMddTHHmmssZStartFaultDate(startDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEndFaultDate(endDate),
        pageSize,
        pageNumber,
        appliedFilters,
        await graphqlSchemaService!.getfaultQueryString(
            limit: pageSize,
            pageNo: pageNumber,
            applyFilter: appliedFilters,
            startDate:
                Utils.getDateInFormatyyyyMMddTHHmmssZStartFaultDate(startDate),
            endDate:
                Utils.getDateInFormatyyyyMMddTHHmmssZEndFaultDate(endDate)));

    // result!.faults!.forEach((element) {
    //   Logger().i(element.details!.toJson());
    // });

    if (result != null) {
      Logger().w(result.faults!.first.details!.toJson());
      _totalCount = result.total;
      if (result.faults!.isNotEmpty) {
        _faults.addAll(result.faults!);
        getDeviceData(result);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _faults.addAll(result.faults!);
        getDeviceData(result);
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
    pageSize = 20;
    if (_faults.isEmpty) {
      _loading = true;
    } else {
      _refreshing = true;
    }
    _shouldLoadmore = true;
    notifyListeners();
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    FaultSummaryResponse? result = await _faultService!.getFaultSummaryList(
        Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        pageSize,
        pageNumber,
        appliedFilters,
        await graphqlSchemaService!.getfaultQueryString(
            pageNo: pageNumber,
            limit: pageSize,
            startDate: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            applyFilter: appliedFilters,
            endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate)));
    if (result != null) {
      _totalCount = result.total;
      _faults.clear();
      _faults.addAll(result.faults!);
      getDeviceData(result);
      _refreshing = false;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
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
      getFaultViewList();
    }
  }

  onDetailPageSelected(Fault fleet) {
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: fleet.asset!.uid,
            assetId: fleet.asset!.uid,
            assetIdentifier: fleet.asset!.uid,
          ),
          type: ScreenType.HEALTH,
          index: 1),
    );
  }

  getDeviceData(FaultSummaryResponse response) {
    for (int i = 0; i < response.faults!.length; i++) {
      var data = response.faults![i];
      for (int j = 0; j < data.asset!.details!.devices!.length; j++) {
        _device.add(data.asset!.details!.devices![j]);
      }
    }
    Logger().wtf(device.first.toJson());
  }
}
