import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger log;
  var _assetSingleHistoryService = locator<AssetService>();
  var _assetUtilizationService = locator<AssetUtilizationService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  AssetUtilization _assetUtilization;
  AssetUtilization get assetUtilization => _assetUtilization;

  List<Note> _assetNotes = [];
  List<Note> get assetNotes => _assetNotes;

  bool _loading = true;
  bool get loading => _loading;

  double _highestValue;
  double get highestValue => _highestValue;

  bool _postingNote = false;
  bool get postingNote => _postingNote;

  AssetDashboardViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    this.log = getLogger(this.runtimeType.toString());
    _assetSingleHistoryService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetDetail();
      getAssetUtilization();
      getNotes();
    });
  }

  getAssetUtilization() async {
    AssetUtilization result = await _assetUtilizationService.getAssetUtilGraphDate(
        assetDetail.assetUid,
        '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}');
    _assetUtilization = result;
    _highestValue = getHighestValue(_assetUtilization);
    _loading = false;
    notifyListeners();
  }

  getAssetDetail() async {
    AssetDetail result =
        await _assetSingleHistoryService.getAssetDetail(assetDetail.assetUid);
    _assetDetail = result;
    _loading = false;
    notifyListeners();
  }

  getNotes() async {
    List<Note> result =
        await _assetSingleHistoryService.getAssetNotes(assetDetail.assetUid);
    _assetNotes = result;
    _loading = false;
    notifyListeners();
  }

  postNotes(note) async {
    _postingNote = true;
    notifyListeners();
    await _assetSingleHistoryService.postNotes(assetDetail.assetUid, note);
    _postingNote = false;
    notifyListeners();
  }

  double getHighestValue(AssetUtilization assetUtilization) {
    double highValue = double.minPositive;

    if (assetUtilization.totalDay.workingHours > highValue)
      highValue = assetUtilization.totalDay.workingHours;

    if (assetUtilization.totalDay.idleHours > highValue)
      highValue = assetUtilization.totalDay.idleHours;

    if (assetUtilization.totalDay.runtimeHours > highValue)
      highValue = assetUtilization.totalDay.runtimeHours;

    if (assetUtilization.totalWeek.workingHours > highValue)
      highValue = assetUtilization.totalWeek.workingHours;

    if (assetUtilization.totalWeek.idleHours > highValue)
      highValue = assetUtilization.totalWeek.idleHours;

    if (assetUtilization.totalWeek.runtimeHours > highValue)
      highValue = assetUtilization.totalWeek.runtimeHours;

    if (assetUtilization.totalMonth.workingHours > highValue)
      highValue = assetUtilization.totalMonth.workingHours;

    if (assetUtilization.totalMonth.idleHours > highValue)
      highValue = assetUtilization.totalMonth.idleHours;

    if (assetUtilization.totalMonth.runtimeHours > highValue)
      highValue = assetUtilization.totalMonth.runtimeHours;

    return highValue;
  }
}
