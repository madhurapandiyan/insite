import 'dart:async';

import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart' as service;

class AssetOperationViewModel extends InsiteViewModel {
  late Logger log;
  AssetService? _assetService = locator<AssetService>();
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();
  AssetStatusService? _assetStatusService = locator<AssetStatusService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();
  List<Asset> _assets = [];
  List<Asset> get assets => _assets;

  bool _loading = true;
  bool get loading => _loading;

  int _totalCount = 0;
  int get totalCount => _totalCount;

  int pageNumber = 1;
  int pageSize = 50;
  ScrollController? scrollController;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  String _menuItem = "assetid";
  set menuItem(String menuItem) {
    this._menuItem = menuItem;
  }

  List<DateTime> days = [];

  updateDateRangeList() {
    try {
      DateTime startTime = DateFormat("yyyy-MM-dd").parse(startDate!);
      DateTime endTime = DateFormat("yyyy-MM-dd").parse(endDate!);
      final daysToGenerate = endTime.difference(startTime).inDays + 1;
      days = List.generate(
          daysToGenerate,
          (i) =>
              DateTime(startTime.year, startTime.month, startTime.day + (i)));
      Logger().d("date range length ${days.length}");
    } catch (e) {
      Logger().e(e);
    }
  }

  AssetOperationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _assetService!.setUp();
    _assetStatusService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getSelectedFilterData();
      getDateRangeFilterData();
    });
    Future.delayed(Duration(seconds: 2), () {
      getAssetSummaryList();
    });
  }

  void refresh() async {
    await getDateRangeFilterData();
    await getSelectedFilterData();
    await getAssetOperationCount();
    updateDateRangeList();
    pageNumber = 1;
    pageSize = 50;
    if (_assets.isEmpty) {
      _loading = true;
    } else {
      _refreshing = true;
    }
    _shouldLoadmore = true;
    notifyListeners();
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    AssetSummaryResponse result = await (_assetService!.getAssetSummaryList(
            startDate,
            endDate,
            pageSize,
            pageNumber,
            _menuItem,
            appliedFilters,
            _graphqlSchemaService!.assetOperationData)
        as FutureOr<AssetSummaryResponse>);
    if (result != null) {
      _assets.clear();
      _assets.addAll(result.assets!);
      _loading = false;
      _refreshing = false;
      notifyListeners();
    } else {
      _loading = false;
      _refreshing = false;
      notifyListeners();
    }
    Logger().i("list of assets " + result.assets!.length.toString());
  }

  getAssetSummaryList() async {
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    await getAssetOperationCount();
    updateDateRangeList();
    AssetSummaryResponse? result = await _assetService!.getAssetSummaryList(
        startDate,
        endDate,
        pageSize,
        pageNumber,
        _menuItem,
        appliedFilters,
        _graphqlSchemaService!.assetOperationData);
    if (result != null) {
      if (result.pagination!.totalAssets != null) {
        _totalCount = result.pagination!.totalAssets!.toInt();
      }
      if (result.assets!.isNotEmpty) {
        Logger().i("list of assets " + result.assets!.length.toString());
        _assets.addAll(result.assets!);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _assets.addAll(result.assets!);
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

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !_refreshing) {
      log.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getAssetSummaryList();
    }
  }

  onDetailPageSelected(Asset asset) {
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            index: 2,
            fleet: Fleet(
                assetSerialNumber: asset.serialNumber,
                assetId: asset.assetId,
                assetIdentifier: asset.assetUid)));
  }

  getAssetOperationCount() async {
    Logger().d("getAssetOperationCount");
    AssetCount? assetCount = await _assetStatusService!.getAssetCountByFilter(
        startDate,
        endDate,
        "-RuntimeHours",
        ScreenType.ASSET_OPERATION,
        appliedFilters,
        _graphqlSchemaService!.utilizationTotalCount);
    if (assetCount != null) {
      if (assetCount.countData!.isNotEmpty &&
          assetCount.countData![0].count != null) {
        _totalCount = assetCount.countData![0].count!.toInt();
      }
      Logger().d("result ${assetCount.toJson()}");
    }
    notifyListeners();
  }
}
