import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
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

class AssetViewModel extends InsiteViewModel {
  FaultService? _faultService = locator<FaultService>();
  service.NavigationService? _navigationService =
      locator<service.NavigationService>();

  int pageNumber = 1;
  int pageSize = 20;

  List<Count>? countDataAsset = [];

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

  List<AssetFault> _faults = [];
  List<AssetFault> get faults => _faults;

  late ScrollController scrollController;
  AssetViewModel() {
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
      await getAssetViewList();
    });
  }

  getAssetViewList() async {
    try {
      Logger().d("getAssetViewList");
      await getSelectedFilterData();
      await getDateRangeFilterData();
      AssetFaultSummaryResponse? result =
          await _faultService!.getAssetViewSummaryList(
              Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
              Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
              pageSize,
              pageNumber,
              appliedFilters,
              await graphqlSchemaService!.getAssetQuery(
                filtlerList: appliedFilters,
                pageNo: pageNumber,
                limit: pageSize,
                startDate: Utils()
                    .getStartDateTimeInGMTFormatForHealth(startDate, zone!),
                endDate:
                    Utils().getEndDateTimeInGMTFormatForHealth(endDate, zone!),
              ));
      if (result != null && result.assetFaults != null) {
        _totalCount = result.total;
        if (result.assetFaults!.isNotEmpty) {
          _faults.addAll(result.assetFaults!);
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _faults.addAll(result.assetFaults!);
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
    AssetFaultSummaryResponse? result =
        await _faultService!.getAssetViewSummaryList(
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            pageSize,
            pageNumber,
            appliedFilters,
            await graphqlSchemaService!.getAssetFaultQuery(
              startDate: Utils()
                  .getStartDateTimeInGMTFormatForHealth(startDate, zone!),
              endDate:
                  Utils().getEndDateTimeInGMTFormatForHealth(endDate, zone!),
              filtlerList: appliedFilters,
              pageNo: pageNumber,
              limit: pageSize,
            ));
    if (result != null) {
      _totalCount = result.total;
      _faults.clear();
      Logger().w("inside fault view");
      if (result.assetFaults != null) {
        _faults.addAll(result.assetFaults!);
        
      }
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
      getAssetViewList();
    }
  }

  onDetailPageSelected(AssetFault fleet) {
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

 
}
