import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/services/asset_service.dart';

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
  AssetService? _assetService = locator<AssetService>();

  int pageNumber = 1;
  int pageSize = 50;

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

  List<MaintenanceList>? historyData = [];

  SummaryData? _summaryData;
  SummaryData? get summaryData => _summaryData;

  bool dataNotFound = false;

  bool isToggled = true;
  bool isMaintenanceDataOptained = true;
  bool isHistoryDataOptained = true;

  late ScrollController scrollController;

  MaintenanceTabViewModel(SummaryData? summaryData) {
   this. _summaryData = summaryData;
    Logger().i( summaryData!.assetID);
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

  toggled(bool value) {
    isToggled = value;
    notifyListeners();
  }

  refresh() async {
    if (isToggled) {
      await getMaintenanceListItemData(isRefreshing: true);
    } else {
      await getHistoryMaintenanceListItem(isRefreshing: true);
    }
  }

  getHistoryMaintenanceListItem({bool? isRefreshing}) async {
    if (isRefreshing == true) {
      isHistoryDataOptained = true;
      historyData?.clear();
      notifyListeners();
    }
    await getSelectedFilterData();
    await getDateRangeFilterData();
    MaintenanceListData? maintenanceListData = await _maintenanceService!
        .getMaintenanceListData(
            startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            limit: pageSize,
            page: pageNumber,
            query: await graphqlSchemaService!.getMaintenanceListData(
                assetId: summaryData!.assetID,
                histroy: true,
                startDate:
                    Utils.maintenanceFromDateFormate(maintenanceStartDate!),
                endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
                limit: pageSize,
                pageNo: pageNumber));
    if (maintenanceListData != null &&
        maintenanceListData.maintenanceList!.isNotEmpty) {
      historyData!.addAll(maintenanceListData.maintenanceList!);
    } else {
      historyData!.clear();
    }
    isHistoryDataOptained = false;
    notifyListeners();
  }

  getMaintenanceListItemData({bool? isRefreshing}) async {
    if (isRefreshing == true) {
      isMaintenanceDataOptained = true;
      notifyListeners();
    }
    await getSelectedFilterData();
    await getDateRangeFilterData();

    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    if (isVisionLink) {
      MaintenanceListService? result =
          await _maintenanceService?.getMaintenanceServiceList(
              _summaryData!.assetUID,
              Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
              pageSize,
              pageNumber,
              Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
               
              );

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
    } else {
      MaintenanceListData? maintenanceListData = await _maintenanceService!
          .getMaintenanceListData(
              startTime:
                  Utils.maintenanceFromDateFormate(maintenanceStartDate!),
              endTime: Utils.maintenanceToDateFormate(maintenanceEndDate!),
              limit: pageSize,
              
              page: pageNumber,
              query: await graphqlSchemaService!.getMaintenanceListData(
                  assetId: "752961ad-c1d9-11eb-82df-0ae8ba8d3970",
                  startDate:
                      Utils.maintenanceFromDateFormate(maintenanceStartDate!),
                  endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
                  limit: pageSize,
                  pageNo: pageNumber));
      if (maintenanceListData != null &&
          maintenanceListData.maintenanceList!.isNotEmpty) {
        Services? singleService;
        _services.clear();
        for (var item in maintenanceListData.maintenanceList!) {
          _assetDataValue = AssetData(
            assetID: item.assetId,
            assetName: item.assetName,
            // assetIdVal: item.assetId,
            assetIcon: item.assetIcon,
            assetSerialNumber: item.serialNumber,
            assetType: item.assetType,
            currentHourmeter: item.currentHourMeter,
            currentOdometer: item.odometer,
            makeCode: item.make,
            model: item.model,
          );
          singleService = Services(
            serviceName: item.serviceName,
            serviceType: item.serviceType,
            serviceId: item.serviceNumber,
            dueInfo: DueInfomation(
              dueAt: item.dueAt,
              dueBy: item.dueInOverdueBy,
              dueDate: item.dueDate.toString(),
              serviceStatus: item.serviceStatus,
            ),
            intervalCode: item.serviceInterval,
          );
          _services.add(singleService);
          _refreshing = false;
          _loadingMore = false;
          isMaintenanceDataOptained = false;
          notifyListeners();
        }
      } else {
        _services.clear();
        isMaintenanceDataOptained = false;
        _refreshing = false;
        _loadingMore = false;
        notifyListeners();
      }
    }

    notifyListeners();
  }
}
