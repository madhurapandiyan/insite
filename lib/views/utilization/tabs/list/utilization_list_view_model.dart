import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/repository/db.dart';
import 'package:stacked_services/stacked_services.dart' as service;

class UtilizationListViewModel extends InsiteViewModel {
  Logger? log;
  AssetUtilizationService? _utilizationService =
      locator<AssetUtilizationService>();
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();
  AssetStatusService? _assetService = locator<AssetStatusService>();

  int _totalCount = 0;
  int get totalCount => _totalCount;

  int pageNumber = 1;
  int pageCount = 50;
  ScrollController? scrollController;

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  UtilizationListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _assetService!.setUp();
    _utilizationService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (utilLizationListData.length != _totalCount) {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 2), () async {
      await getUtilization(true);
    });
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
      getUtilization(false);
    }
  }

  getAssetCount() async {
    Logger().d("getAssetCount");
    AssetCount? result = await _assetService!.getAssetCount(
        null,
        FilterType.ASSET_STATUS,
        graphqlSchemaService!.getAssetCount(grouping: "assetstatus"),
        false);
    if (result != null) {
      if (result.countData!.isNotEmpty && result.countData![0].count != null) {
        _totalCount = result.countData![0].count!.toInt();
      }
      Logger().d("result ${result.toJson()}");
    }
    notifyListeners();
  }

  onDetailPageSelected(AssetResult fleet) {
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: fleet.assetSerialNumber,
            assetId: fleet.assetIdentifierSqluid,
            assetIdentifier: fleet.assetIdentifier,
          ),
          index: 1),
    );
  }

  getUtilization(bool isFirst) async {
    try {
      Logger().d("getUtilization");
      if (isFirst) {
        await getSelectedFilterData();
        await getDateRangeFilterData();
        await getUtilizationCount();
      }
      Utilization? result = await _utilizationService!.getUtilizationResult(
          startDate,
          endDate,
          '-RuntimeHours',
          pageNumber,
          pageCount,
          appliedFilters,
          await graphqlSchemaService!.getFleetUtilization(
              sort: null,
              applyFilter: appliedFilters,
              startDate: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
              endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
              pageSize: pageCount,
              pageNo: pageNumber));

      if (result != null) {
        if (result.assetResults!.isNotEmpty) {
          _utilLizationListData.addAll(result.assetResults!);
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _utilLizationListData.addAll(result.assetResults!);
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
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  refresh() async {
    try {
      Logger().d("refresh getUtilization list");
      await getSelectedFilterData();
      await getDateRangeFilterData();
      pageNumber = 1;
      pageCount = 50;
      _refreshing = true;
      _shouldLoadmore = true;
      notifyListeners();
      Logger().d("start date " + startDate!);
      Logger().d("end date " + endDate!);
      await getUtilizationCount();
      Utilization? result = await _utilizationService!.getUtilizationResult(
          startDate,
          endDate,
          '-RuntimeHours',
          pageNumber,
          pageCount,
          appliedFilters,
          await graphqlSchemaService!.getFleetUtilization(
              sort: null,
              pageSize: pageCount,
              applyFilter: appliedFilters,
              startDate: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
              endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
              pageNo: pageNumber));
      if (result != null) {
        _utilLizationListData.clear();

        Logger().wtf(_utilLizationListData.length);
        _refreshing = false;
        notifyListeners();
      } else {
        _refreshing = false;
        notifyListeners();
      }
      _utilLizationListData.addAll(result!.assetResults!);
      Logger().i("list of _utilLizationListData " +
          _utilLizationListData.length.toString());
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getUtilizationCount() async {
    Logger().d("getUtilizationCount");
    AssetCount? assetCount = await _assetService!.getAssetCountByFilter(
        startDate,
        endDate,
        "-RuntimeHours",
        ScreenType.UTILIZATION,
        appliedFilters,
        await graphqlSchemaService!
            .utilizationToatlCount(startDate!, endDate!, appliedFilters));
    if (assetCount != null) {
      if (assetCount.countData!.isNotEmpty &&
          assetCount.countData![0].count != null) {
        _totalCount = assetCount.countData![0].count!;
      }
      Logger().wtf("result ${assetCount.countData![0].toJson()}");
    }
    notifyListeners();
  }
}
