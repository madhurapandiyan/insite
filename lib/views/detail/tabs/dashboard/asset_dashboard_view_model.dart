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

  double _idleHighestValue = 0.0;
  double get idleHighestValue => _idleHighestValue;

  double _runtimeHighestValue = 0.0;
  double get runtimeHighestValue => _runtimeHighestValue;

  double _workingHighestValue = 0.0;
  double get workingHighestValue => _workingHighestValue;

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
    getHighestValue(_assetUtilization);
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

  getHighestValue(AssetUtilization assetUtilization) {
    if (assetUtilization.totalDay.workingHours > _workingHighestValue)
      _workingHighestValue = assetUtilization.totalDay.workingHours;

    if (assetUtilization.totalDay.idleHours > _idleHighestValue)
      _idleHighestValue = assetUtilization.totalDay.idleHours;

    if (assetUtilization.totalDay.runtimeHours > _runtimeHighestValue)
      _runtimeHighestValue = assetUtilization.totalDay.runtimeHours;

    if (assetUtilization.totalWeek.workingHours > _workingHighestValue)
      _workingHighestValue = assetUtilization.totalWeek.workingHours;

    if (assetUtilization.totalWeek.idleHours > _idleHighestValue)
      _idleHighestValue = assetUtilization.totalWeek.idleHours;

    if (assetUtilization.totalWeek.runtimeHours > _runtimeHighestValue)
      _runtimeHighestValue = assetUtilization.totalWeek.runtimeHours;

    if (assetUtilization.totalMonth.workingHours > _workingHighestValue)
      _workingHighestValue = assetUtilization.totalMonth.workingHours;

    if (assetUtilization.totalMonth.idleHours > _idleHighestValue)
      _idleHighestValue = assetUtilization.totalMonth.idleHours;

    if (assetUtilization.totalMonth.runtimeHours > _runtimeHighestValue)
      _runtimeHighestValue = assetUtilization.totalMonth.runtimeHours;
  }
}
