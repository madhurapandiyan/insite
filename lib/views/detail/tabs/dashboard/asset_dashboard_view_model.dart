import 'package:custom_info_window/custom_info_window.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_dashboard_fault_data.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/db/asset_count_data.dart';
import 'package:insite/core/models/fault.dart';

import 'package:insite/core/models/filter_data.dart';

import 'package:insite/core/models/maintenance_dashboard_count.dart';

import 'package:insite/core/models/note.dart';
import 'package:insite/core/models/note_data.dart';
import 'package:insite/core/models/notification.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/date.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';

import 'package:insite/views/health/health_view.dart';

import 'package:intl/intl.dart';
import 'package:load/load.dart';

import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/date_range_service.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger? log;
  AssetService? _assetSingleHistoryService = locator<AssetService>();
  NavigationService? _navigationService = locator<NavigationService>();
  AssetStatusService? _assetService = locator<AssetStatusService>();
  AssetUtilizationService? _assetUtilizationService =
      locator<AssetUtilizationService>();
  DateRangeService? _dateRangeService = locator<DateRangeService>();

  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

  List<Note> _getNotes = [];
  List<Note> get getNotesDataList => _getNotes;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  AssetCount? _faultCountData;
  AssetCount? get faultCountData => _faultCountData;

  bool _faultCountloading = true;
  bool get faultCountloading => _faultCountloading;

  MaintenanceDashboardCount? maintenanceDashboardCount;

  AssetUtilization? _assetUtilization;
  AssetUtilization? get assetUtilization => _assetUtilization;

  MaintenanceService? _maintenanceService = locator<MaintenanceService>();

  List<Note> _assetNotes = [];
  List<Note> get assetNotes => _assetNotes;

  List<Count>? faultCountDataList = [];

  bool _loading = true;
  bool get loading => _loading;

  bool _postingNote = false;
  bool get postingNote => _postingNote;

  bool _maintenanceLoading = true;
  bool get maintenanceLoading => _maintenanceLoading;

  double? _utilizationGreatestValue;
  double? get utilizationGreatestValue => _utilizationGreatestValue;

  FilterData? _currentFilterSelected;
  FilterData? get currentFilterSelected => _currentFilterSelected;

  bool _notificationLoading = true;
  bool get notificationLoading => _notificationLoading;

  NotificationData? _notificationCountDatas;
  NotificationData? get notificationCountDatas => _notificationCountDatas;

  gotoFaultPage() {
    Logger().i("go to fault page");
    _navigationService!
        .navigateWithTransition(HealthView(), transition: "rightToLeft");
  }

  onDateAndFilterSelected(FilterData data, FilterData dateFilter) async {
    Logger().d("onFilterSelected ${data.title}");
    await clearFilterDb();
    if (currentFilterSelected != null) {
      await addFilter(currentFilterSelected!);
    }
    await addFilter(data);
    await _dateRangeService!.updateDateFilter(dateFilter);
  }

  AssetDashboardViewModel(AssetDetail? detail) {
    this._assetDetail = detail;
    Logger().w(assetDetail?.toJson());
    this.log = getLogger(this.runtimeType.toString());
    _assetSingleHistoryService!.setUp();
    Future.delayed(Duration(seconds: 1), () async {
      await getAssetDetail();
      await getAssetUtilization();
      await getNotes();
      await getMaintenanceCountData();
      await getNotificationCountData();
      await getFaultCountData();
    });
  }

  getAssetUtilization() async {
    AssetUtilization? result = await _assetUtilizationService!
        .getAssetUtilGraphDate(assetDetail?.assetUid,
            '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}');
    if (result!.totalDay == null ||
        result.totalMonth == null ||
        result.totalWeek == null) {
      _loading = false;
    } else {
      _assetUtilization = result;
      _utilizationGreatestValue = Utils.greatestOfThree(
          _assetUtilization!.totalDay!.runtimeHours!,
          _assetUtilization!.totalWeek!.runtimeHours!,
          _assetUtilization!.totalMonth!.runtimeHours);
      _loading = false;
    }

    notifyListeners();
  }

  getAssetDetail() async {
    AssetDetail? result =
        await _assetSingleHistoryService!.getAssetDetail(assetDetail?.assetUid);
    _assetDetail = result;
    _loading = false;
    notifyListeners();
  }

  getNotes() async {
    List<Note>? result =
        await _assetSingleHistoryService!.getAssetNotes(assetDetail?.assetUid);
    if (result != null) {
      _assetNotes = result;
    }
    _loading = false;
    notifyListeners();
  }

  postNotes(note) async {
    _postingNote = true;
    notifyListeners();
    await _assetSingleHistoryService!.postNotes(assetDetail!.assetUid, note);
    await getNotes();
    _postingNote = false;
    notifyListeners();
  }

  getMaintenanceCountData() async {
    try {
      var data = await _maintenanceService?.getMaintenanceDashboardCount(
          query: await graphqlSchemaService!.maintenanceDashboardCount(
        fromDate: Utils.maintenanceFromDateFormate(maintenanceStartDate!),
        endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
      ));
      if (data?.maintenanceDashboard?.dashboardData != null &&
          data!.maintenanceDashboard!.dashboardData!.isNotEmpty) {
        data.maintenanceDashboard?.dashboardData!.forEach((element) {
          if (element.displayName == "Overdue") {
            element.maintenanceTotal = MAINTENANCETOTAL.OVERDUE;
          }
          if (element.displayName == "Upcoming") {
            element.maintenanceTotal = MAINTENANCETOTAL.UPCOMING;
          }
          if (element.subCount != null) {
            element.subCount!.forEach((dashboardData) {
              if (dashboardData.displayName == "Next Week") {
                dashboardData.maintenanceTotal = MAINTENANCETOTAL.NEXTWEEK;
              }
              if (dashboardData.displayName == "Next Month") {
                dashboardData.maintenanceTotal = MAINTENANCETOTAL.NEXTMONTH;
              }
            });
          }
        });
        maintenanceDashboardCount = data;
        _maintenanceLoading = false;
      } else {
        _maintenanceLoading = false;
      }

      notifyListeners();
    } catch (e) {
      _maintenanceLoading = false;
      notifyListeners();
    }
  }

  getNotificationCountData() async {
    try {
      var data = await _assetService?.getNotificationDashboardCount(
          query: await graphqlSchemaService!.notificationDashboardCount(),
          payload: {"assetUIDs": assetDetail!.assetUid});

      if (data?.notifications != null) {
        _notificationCountDatas = data;
        _notificationLoading = false;
      } else {
        _notificationLoading = false;
      }
      notifyListeners();
    } catch (e) {}
  }

  deletNotes(String? userid) async {
    showLoadingDialog();
    var isDeleted = await _assetSingleHistoryService!
        .deleteNote({"userAssetNoteUid": userid});
    if (isDeleted) {
      _assetNotes.removeWhere((element) => element.userAssetNoteUID == userid);
    }
    notifyListeners();
    hideLoadingDialog();
  }

  getFaultCountData() async {
    AssetDashboardFaultData? assetDashboardFaultData =
        await _assetSingleHistoryService!.getAssetDashboardFaultCountData(
      graphqlSchemaService!.getSingleAssetFaulSummaryData(
          assetUid: assetDetail?.assetUid,
          startDate: Utils.getFaultDateFormatStartDate(
              DateUtil.calcFromDate(DateRangeType.lastSevenDays)!
                  .subtract(Duration(days: 1))),
          endDate: Utils.getFaultDateFormatEndDate(DateTime.now())),
    );
    Logger().v(
        assetDashboardFaultData!.summaryData!.first.countData!.first.countOf);

    for (var i = 0; i < assetDashboardFaultData.summaryData!.length; i++) {
      var data = assetDashboardFaultData.summaryData![i];
      for (var j = 0; j < data.countData!.length; j++) {
        faultCountDataList!.add(data.countData![j]);
      }
    }
    _faultCountloading = false;
    notifyListeners();
  }
}
