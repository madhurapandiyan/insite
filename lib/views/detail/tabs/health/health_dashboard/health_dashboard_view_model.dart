import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class HealthDashboardViewModel extends InsiteViewModel {
  Logger log;
  var _faultService = locator<FaultService>();
  var _assetSingleHistoryService = locator<AssetService>();

  bool _loading = true;
  bool get loading => _loading;

  List<CountData> _faultData=[];
 List<CountData>  get faultData => _faultData;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<Note> _assetNotes = [];
  List<Note> get assetNotes => _assetNotes;

  bool _postingNote = false;
  bool get postingNote => _postingNote;

  HealthDashboardViewModel(AssetDetail assetDetail) {
    this._assetDetail = assetDetail;
    this.log = getLogger(this.runtimeType.toString());
    _faultService.setUp();
    _assetSingleHistoryService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getDashboardListData();
      getAssetDetail();
      getNotes();
    });
  }

  getDashboardListData() async {
    SingleAssetFaultResponse result = await _faultService.getDashboardListData(
        _assetDetail.assetUid,
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));
    if (result != null) {
      _faultData = result.summaryData[0].countData;
    }
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
}
