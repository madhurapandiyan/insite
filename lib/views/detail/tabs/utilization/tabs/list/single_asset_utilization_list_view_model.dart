import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationListViewModel extends BaseViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<AssetResult> _utilLizationList = [];
  List<AssetResult> get utilLizationList => _utilLizationList;

  String _startDate =
      '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}';
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  SingleAssetUtilizationListViewModel(AssetDetail detail) {
    this._assetDetail = detail;

    _assetUtilizationService.setUp();
    getUtilList();
  }

  getUtilList() async {
    Logger().d("getUtilList");
    var result = await _assetUtilizationService.getUtilizationData(
      assetDetail.assetUid,
      _startDate,
      _endDate,
    );
    _utilLizationList = result;
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    _refreshing = true;
    notifyListeners();
    var result = await _assetUtilizationService.getUtilizationData(
      assetDetail.assetUid,
      _startDate,
      _endDate,
    );
    if (result != null) {
      _utilLizationList.clear();
      _utilLizationList.addAll(result);
      _refreshing = false;
      notifyListeners();
    } else {
      _refreshing = false;
      notifyListeners();
    }
  }
}
