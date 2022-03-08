import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class MaintenanceItemDetailViewModel extends InsiteViewModel {
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();

  Fault? _fault;
  Fault? get fault => _fault;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  int page = 1;

  int limit = 20;

  List<AssetCentricData> _assetData = [];
  List<AssetCentricData> get assetData => _assetData;

  List<Services?> _services = [];
  List<Services?> get services => _services;

  AssetCentricData? _assetCentricData;
  AssetCentricData? get assetCentricData => _assetCentricData;

  ScrollController? scrollController;
  int pageNumber = 1;
  int pageSize = 20;

  MaintenanceItemDetailViewModel(AssetCentricData? assetData) {
    _assetCentricData = assetData;

    setUp();
    _maintenanceService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      //_faults.clear();
      _loaded = false;
      notifyListeners();
    });
  }

  getMaintenanceListItemData() async {
    await getSelectedFilterData();
    await getDateRangeFilterData();

    notifyListeners();
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);

    MaintenanceListService? result =
        await _maintenanceService?.getMaintenanceServiceList(
            _assetCentricData!.assetUID,
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            limit,
            page,
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));

    ;
    if (result != null && result.services != null) {
      if (result.services!.isNotEmpty) {
        _services.addAll(result.services!);
        _refreshing = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _services.addAll(result.services!);
        _refreshing = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _refreshing = false;
      notifyListeners();
    }
    _loaded = true;
    notifyListeners();
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
      //getMaintenanceListItemData();
    }
  }

  void onExpanded() {
    Logger().d("onExpanded");
    if (loaded) {
      return;
    }
    _refreshing = true;
    notifyListeners();
    getMaintenanceListItemData();
  }
}
