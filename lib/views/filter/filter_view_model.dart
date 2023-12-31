import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/filter_notification.dart';

import 'package:insite/core/models/maintenance_refine.dart';
import 'package:insite/core/models/manage_notification_filter.dart';
import 'package:insite/core/models/notification.dart';
import 'package:insite/core/models/report_count.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';

class FilterViewModel extends InsiteViewModel {
  AssetStatusService? _assetService = locator<AssetStatusService>();
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NotificationService? _notificationService = locator<NotificationService>();
  bool _loading = false;
  bool get loading => _loading;
  bool _refineLoading = true;
  bool get refineLoading => _refineLoading;
  List<FilterData> filterDataDeviceType = [];
  List<FilterData> filterDataMake = [];
  List<FilterData> filterDataManufacturer = [];
  List<FilterData> filterDataModel = [];
  List<FilterData> filterDataSubscription = [];
  List<FilterData> filterDataModelYear = [];
  List<FilterData> filterDataProductFamily = [];
  List<FilterData> filterDataAllAssets = [];
  List<FilterData> filterDataFuelLevel = [];
  List<FilterData> filterDataIdlingLevel = [];
  List<FilterData> filterSeverity = [];
  List<FilterData> notification=[];
   List<FilterData> notificationStatus=[];

  List<FilterData> filterDataJobType = [];
  List<FilterData> filterDataUserType = [];
  List<FilterData> filterFrequencyType = [];
  List<FilterData> filterFormatType = [];
  List<FilterData> filterReportType = [];
  List<FilterData> serviceTypeReportType = [];
  List<FilterData> serviceStatusReportType = [];
  List<FilterData> assetType = [];
  bool isShowing = true;

  List<FilterData?>? selectedFilterData = [];
  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  FilterViewModel(bool isLoad, ScreenType? type) {
    setUp();
    _assetService!.setUp();
    Future.delayed(Duration(seconds: 1), () async {
      if (isLoad) {
        await getSelectedFilterData();
        await getFilterData(type);
        await getData();
      } else {
        await getSelectedFilterData();
        getData();
      }
    });
  }
  getData() async {
    selectedFilterData = appliedFilters;
    _refineLoading = false;
    notifyListeners();
  }

  getFilterData(ScreenType? screenType) async {
    showLoadingDialog(tapDismiss: false);
    if (screenType == ScreenType.FLEET ||
        screenType == ScreenType.LOCATION ||
        screenType == ScreenType.UTILIZATION ||
        screenType == ScreenType.ASSET_OPERATION ||
        screenType == ScreenType.HEALTH ||
        screenType == ScreenType.MAINTENANCE
        // ||screenType == ScreenType.NOTIFICATIONS
        ) {
      AssetCount? resultModel = await _assetService!.getAssetCount(
          "model",
          FilterType.MODEL,
          graphqlSchemaService!.getFilterData("model"),
          false);
      addData(filterDataModel, resultModel, FilterType.MODEL);
      AssetCount? resultDeviceType = await _assetService!.getAssetCount(
          "deviceType",
          FilterType.DEVICE_TYPE,
          graphqlSchemaService!.getFilterData("deviceType"),
          false);
      addData(filterDataDeviceType, resultDeviceType, FilterType.DEVICE_TYPE);
      AssetCount? resultManufacturer = await _assetService!.getAssetCount(
          "manufacturer",
          FilterType.MAKE,
          graphqlSchemaService!.getFilterData("manufacturer"),
          false);
      addData(filterDataMake, resultManufacturer, FilterType.MAKE);
      addData(
          filterDataManufacturer, resultManufacturer, FilterType.MANUFACTURER);
      AssetCount? resultProductfamily = await _assetService!.getAssetCount(
          "productfamily",
          FilterType.PRODUCT_FAMILY,
          graphqlSchemaService!.getFilterData("productfamily"),
          false);
      addData(filterDataProductFamily, resultProductfamily,
          FilterType.PRODUCT_FAMILY);

      AssetCount? resultAllAssets = await _assetService!.getAssetCount(
          "assetstatus",
          FilterType.ALL_ASSETS,
          graphqlSchemaService!.getFilterData("assetstatus"),
          false);
      addData(filterDataAllAssets, resultAllAssets, FilterType.ALL_ASSETS);

      AssetCount? resultFuelLevel = await _assetService!.getFuellevel(
          FilterType.FUEL_LEVEL, graphqlSchemaService!.fuelLevelCount, false);
      filterDataFuelLevel.removeWhere((element) => element.title == "");
      addFuelData(filterDataFuelLevel, resultFuelLevel, FilterType.FUEL_LEVEL);

      // AssetCount? resultSubscriptiontype = await _assetService?.getAssetCount(
      //     "subscriptiontype",
      //     FilterType.SUBSCRIPTION_DATE,
      //     graphqlSchemaService!.getFilterData("subscriptiontype"),
      //     false);
      // addData(filterDataSubscription, resultSubscriptiontype,
      //     FilterType.SUBSCRIPTION_DATE);
    }
    if (screenType == ScreenType.HEALTH) {
      AssetCount? resultSeverity = await _assetService!.getFaultCount(
          Utils.getDateInFormatyyyyMMddTHHmmssZStartFaultDate(startDate),
          Utils.getDateInFormatyyyyMMddTHHmmssZEndFaultDate(endDate),
          graphqlSchemaService!.getFaultCountData(
            startDate:
                Utils.getDateInFormatyyyyMMddTHHmmssZStartFaultDate(startDate),
            endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEndFaultDate(endDate),
          ));
      addData(filterSeverity, resultSeverity, FilterType.SEVERITY);
    }
    if (screenType == ScreenType.USER_MANAGEMENT) {
      AssetCount? resultJobType = await _assetService!.getAssetCount(
          "JobType",
          FilterType.JOBTYPE,
          graphqlSchemaService!.getUserManagementRefine("JobType"),
          null);
      addUserData(filterDataJobType, resultJobType, FilterType.JOBTYPE);

      AssetCount? resultUserType = await _assetService!.getAssetCount(
          "UserType",
          FilterType.USERTYPE,
          graphqlSchemaService!.getUserManagementRefine("UserType"),
          null);
      addUserData(filterDataUserType, resultUserType, FilterType.USERTYPE);
    }
    if (screenType == ScreenType.MANAGE_REPORT) {
      ReportCount? resultReportFrequencyType = await _assetService!
          .getCountReportData(graphqlSchemaService!.reportFilterCountData);
      addReportData(
          filterFrequencyType,
          resultReportFrequencyType,
          FilterType.FREQUENCYTYPE,
          filterFormatType,
          filterReportType,
          FilterType.REPORT_FORMAT,
          FilterType.REPORT_TYPE);
    }
     if (screenType == ScreenType.MANAGE_NOTIFICATION) {
    
        var result=await  _notificationService!.getManageNotificationFilterData();
      Logger().wtf("result:${result?.toJson()}");
      addNotificatiion(
          notification,
          result,
           FilterType.NOTIFICATION_TYPE,
          );
    }

     if (screenType == ScreenType.NOTIFICATIONS) {
    
     var data = await _assetService?.getNotificationDashboardCount(
          query: await graphqlSchemaService!.notificationDashboardCount());
         Logger().wtf("data:${data?.toJson()}");
      
      filterNotification(
          notification,
         data,
         FilterType.NOTIFICATION_TYPE,
         
          );
        
    }
    if (screenType == ScreenType.NOTIFICATIONS) {
     
       var filterStatus = await _notificationService?.getNotificationStatusCount(
          query: await graphqlSchemaService!.notificationStatusCount());
         Logger().wtf("filterStatus:${filterStatus?.toJson()}");
     
          
            filterNotificationItem(
          notificationStatus,
          filterStatus,
          FilterType.NOTIFICATION_STATUS,
          ); 
          
          
    }
    if (screenType == ScreenType.MAINTENANCE) {
      var data = await _maintenanceService!.getRefineData(
          query: graphqlSchemaService!.getMaintenanceRefineData(
              fromDate: Utils.maintenanceFromDateFormate(maintenanceStartDate!),
              toDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
              limit: 50,
              pageNo: 1));
      var serviceTypeAssetCount = getAssetCountFromMaintenanceRefine(
          data!.maintenanceRefine!.maintenanceRefine![0]);
      var serviceStatusAssetCount = getAssetCountFromMaintenanceRefine(
          data.maintenanceRefine!.maintenanceRefine![1]);
      var assetTypeCount = getAssetCountFromMaintenanceRefine(
          data.maintenanceRefine!.maintenanceRefine![2]);
      addData(serviceTypeReportType, serviceTypeAssetCount,
          FilterType.SERVICE_TYPE);
      addData(serviceStatusReportType, serviceStatusAssetCount,
          FilterType.SERVICE_STATUS);
      addData(assetType, assetTypeCount, FilterType.ASSET_TYPE);
    }

    AssetCount? resultIdlingLevel = await _assetService!.getIdlingLevelData(
        startDate,
        endDate,
        FilterType.IDLING_LEVEL,
        null,
        graphqlSchemaService!.getAssetCount(
            idleEfficiencyRanges: "[0,10][10,15][15,25][25,]",
            endDate: DateTime.now().toString(),
            startDate: DateTime.now().subtract(Duration(days: 1)).toString()),
        false);
    addIdlingData(
        filterDataIdlingLevel, resultIdlingLevel, FilterType.IDLING_LEVEL);
    isShowing = false;

    _loading = false;
    hideLoadingDialog();
    notifyListeners();
  }

  AssetCount? getAssetCountFromMaintenanceRefine(MaintenanceRefineList data) {
    AssetCount assetCountData;
    List<Count>? counData = [];
    Count? singleCountData;
    if (data != null) {
      data.typeValues!.forEach((element) {
        singleCountData = Count(count: element.count, countOf: element.name);
        counData.add(singleCountData!);
      });
      assetCountData = AssetCount(countData: counData);
      return assetCountData;
    }
  }

  addData(filterData, AssetCount? resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData!.isNotEmpty) {
      for (Count countData in resultModel.countData!) {
        // if (countData.countOf != "Not Reporting" && //enabling not reporting
        if (countData.countOf != "Excluded") {
          FilterData data = FilterData(
              count: type == FilterType.SEVERITY
                  ? countData.faultCount.toString()
                  : countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

  addFuelData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

  addUserData(filterData, AssetCount? resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData!.isNotEmpty) {
      for (Count countData in resultModel.countData!) {
        FilterData data = FilterData(
            count: countData.count.toString(),
            title: countData.name,
            isSelected: isAlreadSelected(countData.countOf, type),
            extras: [countData.id.toString()],
            type: type);
        filterData.add(data);
      }
    }
  }

  addReportData(filterData, ReportCount? resultModel, fiterFrequencytype,
      filterFormatData, filterReportType, filterFormatype, filterReporttype) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData!.isNotEmpty) {
      for (CountReportData countData in resultModel.countData!) {
        if (countData.groupName == "Frequency" &&
            fiterFrequencytype == FilterType.FREQUENCYTYPE) {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.name,
              isSelected: isAlreadSelected(countData.name, fiterFrequencytype),
              extras: [countData.id.toString()],
              type: fiterFrequencytype,
              id: countData.id.toString());
          filterData.add(data);
        } else if (countData.groupName == "Report Format" &&
            filterFormatype == FilterType.REPORT_FORMAT) {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.name,
              isSelected: isAlreadSelected(countData.name, filterFormatype),
              extras: [countData.id.toString()],
              type: filterFormatype,
              id: countData.id.toString());
          filterFormatData.add(data);
        } else if (countData.groupName == "Report Type" &&
            filterReporttype == FilterType.REPORT_TYPE) {
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.name,
              isSelected: isAlreadSelected(countData.name, filterReporttype),
              extras: [countData.id.toString()],
              type: filterReporttype,
              id: countData.id.toString());
          filterReportType.add(data);
        }
      }
    }
  }

  Future<void> onFilterApplied() async {
    _isRefreshing = true;
    notifyListeners();
    await updateFilterInDb(selectedFilterData!);
    await getSelectedFilterData();
    _isRefreshing = false;
    notifyListeners();
  }

  addIdlingData(filterData, resultModel, type) {
    if (resultModel != null &&
        resultModel.countData != null &&
        resultModel.countData.isNotEmpty) {
      for (Count countData in resultModel.countData) {
        if (countData.countOf != "Not Reporting" &&
            countData.countOf != "Excluded") {
          var x = countData.countOf!
              .split(",")
              .first
              .replaceAll("[", "")
              .replaceAll("]", "");
          var y = countData.countOf!
              .split(",")
              .last
              .replaceAll("[", "")
              .replaceAll("]", "");
          Logger().d("idling level data x", x);
          Logger().d("idling level data y", y);
          FilterData data = FilterData(
              count: countData.count.toString(),
              title: countData.countOf,
              isSelected: isAlreadSelected(countData.countOf, type),
              extras: [x, y],
              type: type);
          filterData.add(data);
        }
      }
    }
  }

 addNotificatiion(filterData, ManageNotificationFilter? manageNotificationFilter,filternotificationtype) {
  try {
    
 
    if ( manageNotificationFilter?.getAlertConfigsCountData?.alertConfigs!=null&&
        manageNotificationFilter!.getAlertConfigsCountData!.alertConfigs!.isNotEmpty) {
          var result=manageNotificationFilter.getAlertConfigsCountData?.alertConfigs;
          Logger().wtf("result:${manageNotificationFilter.getAlertConfigsCountData?.toJson()}");
          for (var element in result!) {
            
             FilterData data = FilterData(
              count: element.count.toString(),
              title: element.notificationType,
              isSelected: isAlreadSelected(element.notificationType, filternotificationtype),
              extras: [element.notificationTypeGroup.toString()],
              type: filternotificationtype,
            
              );
          filterData.add(data);
         
          }
      
        } 
      Logger() .wtf(filterData.length);
       } catch (e) {
    Logger().e(e.toString());
  }
      }
   

 filterNotification(filterData, NotificationData? notificationType, filternotificationtype,) {
  try {
    
if ( notificationType!=null&&
        notificationType.notifications!.isNotEmpty) {
          var result=notificationType.notifications;
          Logger().wtf("result:${notificationType.toJson()}");
          for (var element in result!) {
            
             FilterData data = FilterData(
              count: element.count?.toStringAsFixed(0),
              title: element.notificationSubType,
              isSelected: isAlreadSelected(element.notificationSubType, filternotificationtype),
              extras: [element.notificationType.toString()],
              type: filternotificationtype,
            
              );
          filterData.add(data);
         
          
          }}
        
       } catch (e) {
    Logger().e(e.toString());
  }
      }

       filterNotificationItem(filterItem, FilterNotification? notificationStatus, filterNotificationStatus) {
  try {
    

          if ( notificationStatus!=null&&
        notificationStatus.notifications!.isNotEmpty) {
          var result=notificationStatus.notifications;
          Logger().wtf("result:${notificationStatus.toJson()}");
          for (var element in result!) {
            
             FilterData status = FilterData(
              count: element.countOf.toString(),
              title: element.notificationStatusInd,
              isSelected: isAlreadSelected(element.notificationStatusInd, filterNotificationStatus),
             // extras: [element.notificationSubType.toString()],
              type: filterNotificationStatus,
            
              );
          filterItem.add(status);
         
          
          }}
        //  FilterData secondData = FilterData(
        //       count: notificationType?.count.toString(),
        //       title: notificationType?.notificationType,
        //       isSelected: isAlreadSelected(notificationType?.notificationType, filterNotificationAsset),
        //       extras: [notificationType?.notificationSubType.toString()],
        //       type: filterNotificationAsset,
            
        //       );
        //   filterAsset.add(secondData);
        //  Logger() .wtf(filterAsset.length);
       } catch (e) {
    Logger().e(e.toString());
  }
      }
   

   

  removeAllSelectedFilter() async {
    selectedFilterData!.clear();
    notifyListeners();
  }

  removeSelectedFilter(value) async {
    Logger().d("removeFilter title " + value.title.toString());
    try {
      int size = selectedFilterData!.length;
      if (size > 0) {
        for (var i = 0; i < size; i++) {
          FilterData data = selectedFilterData![i]!;
          Logger().d("current filter data on loop ", data);
          if (data.title == value.title && data.type == value.type) {
            print("delete filter " + data.title.toString());
            selectedFilterData!.removeAt(i);
            break;
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onFilterSelected(List<FilterData> list, FilterType type) {
    if (list.isEmpty) {
      clearFilterOfType(type);
    } else {
      Logger().wtf("type");
      Logger().e(type);

      if (type == FilterType.FUEL_LEVEL) {
        updateFilter(list.first);
      } else {
        list.forEach((element) {
          updateFilter(element);
        });
      }
    }
    notifyListeners();
    // updateFilterInDb(list);
    // getSelectedFilterData();
  }

  updateFilter(FilterData value) async {
    if (value.type == FilterType.FUEL_LEVEL) {
      selectedFilterData!
          .removeWhere((element) => element!.type == FilterType.FUEL_LEVEL);
    }
    int size = selectedFilterData!.length;

    if (size == 0) {
      selectedFilterData!.add(value);
    } else {
      bool shouldAdd = true;
      for (var i = 0; i < size; i++) {
        FilterData data = selectedFilterData![i]!;
        if (data.title == value.title) {
          shouldAdd = false;
          break;
        }
      }
      if (shouldAdd) {
        print("add filter " + value.title.toString());
        selectedFilterData!.add(value);
      }
    }
  }

  //removes filters of particular type
  clearFilterOfType(FilterType type) async {
    try {
      int size = selectedFilterData!.length;
      print("filter size before clear");
      print(selectedFilterData!.length);
      print("FilterType " + type.toString());
      selectedFilterData!.removeWhere((element) => element!.type == type);
      //commenting tradional way of removing elements in list
      // for (var i = 0; i < size; i++) {
      //   FilterData data = selectedFilterData[i];
      //   Logger().d("current filter data on loop ${data.type} , ${data.title}");
      //   if (data.type == type) {
      //     selectedFilterData.removeAt(i);
      //   }
      // }
      print("filter size after clear");
      print(selectedFilterData!.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  onFilterCleared(FilterType type) {
    clearFilterOfType(type);
    notifyListeners();
    // clearFilterOfTypeInDb(type);
    // getSelectedFilterData();
  }
}
