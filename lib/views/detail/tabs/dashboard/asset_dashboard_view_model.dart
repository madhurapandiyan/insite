import 'package:custom_info_window/custom_info_window.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/asset_utilization.dart';
<<<<<<< HEAD
import 'package:insite/core/models/filter_data.dart';
=======
import 'package:insite/core/models/maintenance_dashboard_count.dart';
>>>>>>> d12fcac01e33bab440685f655a0eac783842a8ba
import 'package:insite/core/models/note.dart';
import 'package:insite/core/models/note_data.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
<<<<<<< HEAD
import 'package:insite/views/health/health_view.dart';
=======
import 'package:intl/intl.dart';
>>>>>>> d12fcac01e33bab440685f655a0eac783842a8ba
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/date_range_service.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger? log;
  AssetService? _assetSingleHistoryService = locator<AssetService>();
  NavigationService? _navigationService = locator<NavigationService>();
  AssetUtilizationService? _assetUtilizationService =
      locator<AssetUtilizationService>();
  DateRangeService? _dateRangeService = locator<DateRangeService>();

  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

<<<<<<< HEAD
  List<Note> _getNotes = [];
  List<Note> get getNotesDataList => _getNotes;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  AssetCount? _faultCountData;
  AssetCount? get faultCountData => _faultCountData;

  bool _faultCountloading = true;
  bool get faultCountloading => _faultCountloading;
=======
    MaintenanceDashboardCount? maintenanceDashboardCount;
>>>>>>> d12fcac01e33bab440685f655a0eac783842a8ba

  AssetUtilization? _assetUtilization;
  AssetUtilization? get assetUtilization => _assetUtilization;

 MaintenanceService? _maintenanceService = locator<MaintenanceService>();
 
  List<Note> _assetNotes = [];
  List<Note> get assetNotes => _assetNotes;

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
<<<<<<< HEAD
      await getNotesData();
=======
      await getMaintenanceCountData();
>>>>>>> d12fcac01e33bab440685f655a0eac783842a8ba
    });
  }

  getAssetUtilization() async {
    AssetUtilization? result = await _assetUtilizationService!
        .getAssetUtilGraphDate(assetDetail?.assetUid,
            '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}');
    _assetUtilization = result;
    _utilizationGreatestValue = Utils.greatestOfThree(
        _assetUtilization!.totalDay!.runtimeHours!,
        _assetUtilization!.totalWeek!.runtimeHours!,
        _assetUtilization!.totalMonth!.runtimeHours);
    _loading = false;
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
<<<<<<< HEAD

  getNotesData() async {
    NotesData? result = await _assetSingleHistoryService!
        .getNotesData(graphqlSchemaService!.getNotes(assetDetail!.assetUid!));
    Logger().w(result!.getMetadataNotes!.first.toJson());
    for (var element in result.getMetadataNotes!) {
      _getNotes.add(element);
    }
    notifyListeners();
  }
=======
  getMaintenanceCountData() async {
    try {
      var data = await _maintenanceService?.getMaintenanceDashboardCount(
          query: await graphqlSchemaService!.maintenanceDashboardCount(
        fromDate: Utils.maintenanceFromDateFormate(maintenanceStartDate!),
        endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
      ));
      data?.maintenanceDashboard?.dashboardData!.forEach((element) {
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
      notifyListeners();
    } catch (e) {}
  }
   

>>>>>>> d12fcac01e33bab440685f655a0eac783842a8ba
}
