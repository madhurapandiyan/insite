import 'package:custom_info_window/custom_info_window.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/maintenance_dashboard_count.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger? log;
  AssetService? _assetSingleHistoryService = locator<AssetService>();
  AssetUtilizationService? _assetUtilizationService =
      locator<AssetUtilizationService>();

  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

    MaintenanceDashboardCount? maintenanceDashboardCount;

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
   

}
