import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';

import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/maintenance_service.dart';

class MaintenanceTabViewModel extends InsiteViewModel {
  Logger? log;

  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();

  int pageNumber = 1;
  int pageSize = 20;

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

  AssetData? _assetDataValue;
  AssetData? get assetDataValue => _assetDataValue;

  List<SummaryData> _maintenanceList = [];
  List<SummaryData> get maintenanceList => _maintenanceList;

  List<Services?> _services = [];
  List<Services?> get services => _services;

  SummaryData? _summaryData;
  SummaryData? get summaryData => _summaryData;

  bool dataNotFound = false;

  late ScrollController scrollController;

  MaintenanceTabViewModel(SummaryData? summaryData) {
    _summaryData = summaryData;
    Logger().i(" $summaryData");
    setUp();

    _maintenanceService!.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //   _loadMore();
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      getMaintenanceListItemData();
      _loading = false;
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
            _summaryData!.assetUID,
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            pageSize,
            pageNumber,
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));

    _loading = false;

    if (result != null && result.services != null) {
      if (result.services!.isNotEmpty) {
        _assetDataValue = result.assetData;
        _services.clear();
        _services.addAll(result.services!);
        _refreshing = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        // _services.addAll(result.services!);
        _refreshing = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _refreshing = false;
      notifyListeners();
    }

    notifyListeners();
  }
}
