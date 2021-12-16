import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger? log;
  AssetService? _assetSingleHistoryService = locator<AssetService>();
  AssetUtilizationService? _assetUtilizationService = locator<AssetUtilizationService>();

  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

  AssetUtilization? _assetUtilization;
  AssetUtilization? get assetUtilization => _assetUtilization;

  List<Note> _assetNotes = [];
  List<Note> get assetNotes => _assetNotes;

  bool _loading = true;
  bool get loading => _loading;

  bool _postingNote = false;
  bool get postingNote => _postingNote;

  double? _utilizationGreatestValue;
  double? get utilizationGreatestValue => _utilizationGreatestValue;

  AssetDashboardViewModel(AssetDetail? detail) {
    this._assetDetail = detail;
    this.log = getLogger(this.runtimeType.toString());
    _assetSingleHistoryService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetDetail();
      getAssetUtilization();
      getNotes();
    });
  }

  getAssetUtilization() async {
    AssetUtilization? result = await _assetUtilizationService!.getAssetUtilGraphDate(
        assetDetail!.assetUid,
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
        await _assetSingleHistoryService!.getAssetDetail(assetDetail!.assetUid);
    _assetDetail = result;
    _loading = false;
    notifyListeners();
  }

  getNotes() async {
    List<Note>? result =
        await _assetSingleHistoryService!.getAssetNotes(assetDetail!.assetUid);
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
}
