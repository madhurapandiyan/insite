import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:insite/utils/enums.dart' as screen;

class MainViewModel extends InsiteViewModel {
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();

  int pageNumber = 1;
  int pageSize = 60;

  num? _totalCount = 0;
  num? get totalCount => _totalCount;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  List<SummaryData> _maintenanceList = [];
  List<SummaryData> get maintenanceList => _maintenanceList;

  late ScrollController scrollController;

  MainViewModel() {
    setUp();
    _maintenanceService!.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      getMaintenanceViewList();
    });
  }

  getMaintenanceViewList() async {
    await getSelectedFilterData();
    await getDateRangeFilterData();

    // Logger().d("start date " + startDate!);
    // Logger().d("end date " + endDate!);
    MaintenanceViewData? result = await _maintenanceService!.getMaintenanceData(
      startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
      endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
      limit: pageSize,
      page: pageNumber,
    );

    if (result != null) {
      _totalCount = result.total;
      if (result.summaryData!.isNotEmpty) {
        _maintenanceList.addAll(result.summaryData!);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _maintenanceList.addAll(result.summaryData!);
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
    if (_maintenanceList.isEmpty) {
      _loading = true;
    } else {
      _refreshing = true;
    }
    _shouldLoadmore = true;
    notifyListeners();
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    MaintenanceViewData? result = await _maintenanceService!.getMaintenanceData(
      startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
      endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
      limit: pageSize,
      page: pageNumber,
    );
    if (result != null) {
      _totalCount = result.total;
      _maintenanceList.clear();
      _maintenanceList.addAll(result.summaryData!);
      _refreshing = false;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      _refreshing = false;
      notifyListeners();
    }
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
      getMaintenanceViewList();
    }
  }

  onDetailPageSelected(SummaryData summaryData) {
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: summaryData.assetSerialNumber,
            assetId: summaryData.assetID,
            assetIdentifier: summaryData.assetUID,
          ),
          type: screen.ScreenType.MAINTENANCE,
          index: 1),
    );
  }
}
