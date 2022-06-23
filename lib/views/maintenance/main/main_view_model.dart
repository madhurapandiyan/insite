import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/complete.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/models/maintenance_list_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/maintenance/asset/asset/detail_popup/detail_popup_view.dart';
import 'package:insite/views/maintenance/main/main_detail_popup/main_detail_popup_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:insite/utils/enums.dart' as screen;

class MainViewModel extends InsiteViewModel {
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();

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

  List<MaintenanceList> _maintenanceListData = [];
  List<MaintenanceList> get maintenanceListData => _maintenanceListData;

  List<Services?> _services = [];
  List<Services?> get services => _services;

  SummaryData? _summaryData;
  SummaryData? get summaryData => _summaryData;

  bool dataNotFound = false;

  late ScrollController scrollController;

  MainViewModel() {
    setUp();

    _maintenanceService!.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_maintenanceList.length != _totalCount) {
          _loadMore();
        }
      }
    });
    _maintenanceService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getMaintenanceViewList();
    });
  }

  getMaintenanceViewList() async {
    await getSelectedFilterData();
    await getDateRangeFilterData();

    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    if (isVisionLink) {
      MaintenanceViewData? result =
          await _maintenanceService!.getMaintenanceData(
        startTime:
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(maintenanceStartDate),
        endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(maintenanceEndDate),
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
    } else {
      MaintenanceListData? maintenanceListData = await _maintenanceService!
          .getMaintenanceListData(
              startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
              endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
              limit: pageSize,
              page: pageNumber,
              query: await graphqlSchemaService!.getMaintenanceListData(
                  appliedFilter: appliedFilters,
                  startDate:
                      Utils.maintenanceFromDateFormate(maintenanceStartDate!),
                  endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
                  limit: pageSize,
                  pageNo: pageNumber));

      if (maintenanceListData != null) {
        _totalCount = maintenanceListData.count;
        SummaryData singleSummaryData;
        if (maintenanceListData.maintenanceList!.isNotEmpty) {
          // _maintenanceListData.addAll(maintenanceListData.maintenanceList!);
          for (var item in maintenanceListData.maintenanceList!) {
            singleSummaryData = SummaryData(
                assetID: item.assetId,
                assetSerialNumber: item.serialNumber,
                assetStatus: item.status,
                assetIcon: item.assetIcon,
                completedService: item.completedService,
                serviceCompletedDate: item.serviceDate,
                telematicDeviceId: item.telematicsDeviceId,
                fuelReportedTime: item.fuelLastReportedTime,
                currentHourMeter: item.currentHourMeter,
                currentOdometer: item.odometer,
                customerName: item.customerName,
                productFamily: item.productFamily,
                dueInfo: DueInfo(
                    dueAt: item.dueAt,
                    dueDate: item.dueDate,
                    dueBy: item.dueInOverdueBy,
                    serviceStatus: item.serviceStatus),
                fuelPercentage: item.percentFuelRemaining,
                lastReportedDate: item.lastReportedDate,
                makeCode: item.make,
                model: item.model,
                service: item.serviceName,
                serviceId: item.serviceNumber,
                deviceType: item.deviceType,
                location: Location(
                    city: item.city,
                    country: item.country,
                    state: item.state,
                    streetAddress: item.address,
                    zip: item.zip),
                serviceType: item.serviceType);
            _maintenanceList.add(singleSummaryData);
          }

          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _maintenanceList.clear();
          _loading = false;
          _loadingMore = false;
          _shouldLoadmore = false;
          notifyListeners();
        }
      } else {
        _maintenanceList.clear();
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      }
    }
  }

  refresh() async {
    _loading = true;
    notifyListeners();
    _maintenanceList.clear();
    await getMaintenanceViewList();
    // await getSelectedFilterData();
    // await getDateRangeFilterData();
    // pageNumber = 1;
    // pageSize = 20;
    // if (_maintenanceList.isEmpty) {
    //   _loading = true;
    // } else {
    //   _refreshing = true;
    // }
    // _shouldLoadmore = true;
    // notifyListeners();
    // Logger().d("start date " + startDate!);
    // Logger().d("end date " + endDate!);
    // MaintenanceViewData? result = await _maintenanceService!.getMaintenanceData(
    //   startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
    //   endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
    //   limit: pageSize,
    //   page: pageNumber,
    // );
    // if (result != null) {
    //   _totalCount = result.total;
    //   _maintenanceList.clear();
    //   _maintenanceList.addAll(result.summaryData!);
    //   _refreshing = false;
    //   _loading = false;
    //   notifyListeners();
    // } else {
    //   _loading = false;
    //   _refreshing = false;
    //   notifyListeners();
    // }
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

  onServiceSelected({
    BuildContext? ctx,
    int? serviceId,
    AssetData? assetDataValue,
  }) async {
    MaintenanceCheckListModel? serviceCheckList;

    showGeneralDialog(
        context: ctx!,
        pageBuilder: (context, animation, secondaryAnimation) {
          return MainDetailPopupView(
            parentContext: context,
            assetDataValue: assetDataValue,
            serviceNo: serviceId,
          );
        });
  }

  onDetailPageSelected(SummaryData? summaryData) {
    _navigationService!.navigateTo(
      assetDetailViewRoute,
      arguments: DetailArguments(
          fleet: Fleet(
            assetSerialNumber: summaryData!.assetSerialNumber,
            assetId: summaryData.assetID,
            assetIdentifier: summaryData.assetID,
          ),
          type: screen.ScreenType.MAINTENANCE,
          index: 5),
    );
    // _navigationService!.navigateToView(
    //   AssetDetailView(
    //       fleet: Fleet(
    //         assetSerialNumber: summaryData!.assetUID,
    //         assetId: summaryData.assetUID,
    //         assetIdentifier: summaryData.assetUID,
    //       ),
    //       type: screen.ScreenType.MAINTENANCE,
    //       summaryData: summaryData,
    //       tabIndex: 2),
    // );
    notifyListeners();
  }

  // onServiceSelected(num? serviceId, AssetData? assetDataValue,
  //     SummaryData? assetData, List<Services?>? services) async {
  //   // ServiceItem? serviceItem =
  //   //     await _maintenanceService!.getServiceItemCheckList(serviceId!);

  //   // _navigationService!.navigateToView(
  //   //   MainDetailPopupView(
  //   //       serviceItem: serviceItem!,
  //   //       summaryData: assetData!,
  //   //       assetDataValue: assetDataValue,
  //   //       services: services!),
  //   // );
  // }
}
